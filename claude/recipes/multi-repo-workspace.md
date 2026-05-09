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
sibling_paths=()
for dir in "$parent"/*/; do
  name="$(basename "$dir")"
  [[ "$name" == "claude" ]] && continue
  [[ -e "$dir/.git" ]] || continue

  ln -sfn "../../$name" ".repos/$name"
  sibling_paths+=("../$name")
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
  /<!-- BEGIN: imports/ { print; if (block != "") print block; skip=1; next }
  /<!-- END: imports/  { skip=0 }
  !skip
' CLAUDE.md > CLAUDE.md.tmp && mv CLAUDE.md.tmp CLAUDE.md

# Sync sibling paths into .claude/settings.json so file access works
# regardless of launcher (CLI flag, VS Code extension, etc.)
command -v jq >/dev/null || { echo "jq required" >&2; exit 1; }
settings=".claude/settings.json"
[[ -f "$settings" ]] || echo '{}' > "$settings"
if [[ ${#sibling_paths[@]} -gt 0 ]]; then
  paths_json=$(printf '%s\n' "${sibling_paths[@]}" | jq -R . | jq -s .)
else
  paths_json='[]'
fi
tmp="$(mktemp)"
jq --argjson paths "$paths_json" \
   '.permissions.additionalDirectories = $paths' "$settings" > "$tmp"
mv "$tmp" "$settings"

echo "Synced ${#imports[@]} repo(s) with CLAUDE.md, ${#sibling_paths[@]} additional director(ies)."
```

## `claude/bin/launch`

```bash
#!/usr/bin/env bash
set -euo pipefail

here="$(cd "$(dirname "$0")/.." && pwd)"
cd "$here"

./bin/sync

exec claude "$@"
```

Use `./bin/launch` to refresh symlinks/imports/settings.json before starting
Claude. File-access permission for sibling repos is set via
`permissions.additionalDirectories` in `.claude/settings.json` (committed),
so it also applies when launching via the VS Code extension or any other
launcher that doesn't run `bin/launch` first.

## Two things to verify on first use

1. **Do `@` imports through symlinks work?** Run `./bin/launch` and ask
   Claude to recite a unique string from a sibling's CLAUDE.md. If it
   can't, the import resolution may not follow symlinks — workaround:
   change the sync script to write absolute paths,
   e.g. `@/Users/you/work/acme/product-api/CLAUDE.md`.

2. **Does Grep search into symlinked dirs?** ripgrep doesn't follow
   symlinks by default. If Grep from `claude/` misses files inside
   `.repos/product-api/`, tell Claude to grep `../product-api/` (the real
   path) instead. The `additionalDirectories` setting grants access to the
   real paths, so this works.

## Note on CLAUDE.md preload from sibling repos

`additionalDirectories` only grants file access — it does NOT cause
sibling `CLAUDE.md` files to preload. Two ways to surface them:

- **Imports (preferred for static context):** `@./.repos/<name>/CLAUDE.md`
  in the workspace `CLAUDE.md`, as `bin/sync` already manages.
- **Auto-load (alternative):** set
  `CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD=1` in your shell — this
  causes Claude Code to load CLAUDE.md from any `additionalDirectories`
  entry. Replaces the `@` import approach.
