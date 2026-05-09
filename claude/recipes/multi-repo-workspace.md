# Multi-repo workspace setup

Pattern for working on multiple sibling repos under one GitHub org while
keeping a dedicated, git-managed Claude config repo. Solves: preloading
sibling `CLAUDE.md` files when cwd is the config repo.

## Layout

```
~/work/{org}/
├── claude/                          ← cwd, the config repo
│   ├── CLAUDE.md
│   ├── .claude/
│   │   ├── settings.json
│   │   └── settings.local.json      (gitignored)
│   ├── .repos/                      ← symlinks (gitignored)
│   │   ├── product-api -> ../../product-api
│   │   ├── product-web -> ../../product-web
│   │   └── infra -> ../../infra
│   ├── bin/
│   │   ├── sync                     ← refresh symlinks + imports
│   │   └── launch                   ← start claude with --add-dir flags
│   ├── .gitignore
│   └── README.md
├── product-api/
├── product-web/
└── infra/
```

The `{org}/{repo}` parent path layout is preserved — product repos stay
where they normally live, and `claude/` is just another sibling repo.

## `claude/CLAUDE.md`

```markdown
# {Org} — Claude workspace

Org-wide rules here.

<!-- BEGIN: imports (managed by bin/sync) -->
@./.repos/product-api/CLAUDE.md
@./.repos/product-web/CLAUDE.md
@./.repos/infra/CLAUDE.md
<!-- END: imports -->
```

## `claude/.gitignore`

```
.repos/
.claude/settings.local.json
```

## `claude/bin/sync`

```bash
#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."
parent="$(cd .. && pwd)"

mkdir -p .repos

# Refresh symlinks: one per sibling git repo (excluding ourselves)
imports=()
for dir in "$parent"/*/; do
  name="$(basename "$dir")"
  [[ "$name" == "claude" ]] && continue
  [[ -e "$dir/.git" ]] || continue

  ln -sfn "../../$name" ".repos/$name"
  [[ -f "$dir/CLAUDE.md" ]] && imports+=("@./.repos/$name/CLAUDE.md")
done

# Drop dead symlinks for repos that disappeared
for link in .repos/*; do
  [[ -L "$link" && ! -e "$link" ]] && rm "$link"
done

# Update the managed import block in CLAUDE.md
if [[ ${#imports[@]} -gt 0 ]]; then
  block=$(printf '%s\n' "${imports[@]}")
else
  block=""
fi
awk -v block="$block" '
  /<!-- BEGIN: imports/ { print; print block; skip=1; next }
  /<!-- END: imports/  { skip=0 }
  !skip
' CLAUDE.md > CLAUDE.md.tmp && mv CLAUDE.md.tmp CLAUDE.md

echo "Synced ${#imports[@]} repo(s)."
```

## `claude/bin/launch`

```bash
#!/usr/bin/env bash
set -euo pipefail

here="$(cd "$(dirname "$0")/.." && pwd)"
cd "$here"

./bin/sync

add_dirs=()
for link in .repos/*/; do
  [[ -L "${link%/}" ]] || continue
  add_dirs+=(--add-dir "$(readlink -f "$link")")
done

exec claude "${add_dirs[@]}" "$@"
```

Use `./bin/launch` instead of bare `claude`. It refreshes symlinks/imports
and grants Claude file-access permission to each sibling via `--add-dir`
on the real paths.

## Two things to verify on first use

1. **Do `@` imports through symlinks work?** Run `./bin/launch` and ask
   Claude to recite a unique string from a sibling's CLAUDE.md. If it
   can't, the import resolution may not follow symlinks — workaround:
   change the sync script to write absolute paths,
   e.g. `@/Users/you/work/acme/product-api/CLAUDE.md`.

2. **Does Grep search into symlinked dirs?** ripgrep doesn't follow
   symlinks by default. If Grep from `claude/` misses files inside
   `.repos/product-api/`, it's because of this. The `--add-dir` flags in
   `launch` give Claude access to the real paths, so the workaround is:
   tell Claude to grep `../product-api/` (the real path) rather than
   `.repos/product-api/`. You can encode this hint in `CLAUDE.md`.
