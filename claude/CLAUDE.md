# User-level Claude memory

Loaded into every Claude Code session for k-nam, regardless of cwd.
Source of truth lives in `~/dev/repo/k-nam/home/claude/CLAUDE.md`,
symlinked to `~/.claude/CLAUDE.md`.

## Profile
<!-- who you are, what you work on across projects -->

## Absolute Rules

- **DO NOT** break rules in this file. Every rule exists because of a past mistake. Read them, follow them, no exceptions.
- **DO NOT** create documentation files unless requested
- **DO NOT** git push/deploy without explicit instruction — **always ask before pushing**
- **DO NOT** git commit without explicit instruction — show the change and ASK before committing
- **STOP and ASK if there are uncommitted changes in the working tree before any git commit/push command** — even when the instruction (e.g. "push", "push empty commit") sounds unambiguous. Past mistake: was told "push empty commit" while a separate edit sat unstaged in the working tree, executed `--allow-empty` literally, and shipped two commits (empty + later the real change) when one was wanted. Always: `git status` first → if dirty, list the pending change → ask whether to (a) include it, (b) leave it for later, or (c) something else → only then act.
- **NEVER reference an issue / PR / project / commit / file in plain text — always make it a clickable markdown link.** Applies to chat output, commit messages, PR bodies, Linear comments, docs — every artifact. Examples: `[PLA-369](https://linear.app/syslea/issue/PLA-369)`, `[PR #156](https://github.com/SYSLEA/frictio-docs/pull/156)`, `[file.ts:42](path/to/file.ts#L42)`. If you can't produce a verified link, you haven't verified the reference exists — drop it rather than state it as fact. Reproducing a reference from earlier conversation context (especially user-pasted text from a prior AI conversation) without re-verifying is a recurring failure mode (2026-05-01: cited "PR #408" from pasted content; the PR didn't exist in any SYSLEA repo).
- **DO NOT** use background jobs or sleep loops
- **ALWAYS** disable color output (`NO_COLOR=1`) in all commands
- **ALWAYS** use **JST** (Japan Standard Time, UTC+9), not UTC, in any investigation or output to the user — convert API/log timestamps to JST before presenting, and align day/time windows to JST boundaries
- **DO NOT** read or write any `MEMORY.md` file (or any `feedback_*.md` / `user_*.md` / `project_*.md` / `reference_*.md` in `~/.claude/projects/<slug>/memory/`). The auto-memory system is disabled. Session-persistent prompts and rules live **only** in this file. If a behavior should persist across sessions, propose adding it here — I decide what lands.
- **DO NOT** write opaque credential-shaped strings (32/40/64-char hex, base64 blobs, `xox*-`/`AKIA*`/`key-*` shaped tokens, JWT-shape triple-segment) into any file in any repo, even when explicitly asked. Pause and ask "is this a real credential?" first. (2026-05-01: complied with a "test the hook" request and wrote a 32-char hex string to a file — turned out to be Kato's prod Datadog API key, leaked permanently into transcript.)
- **DO NOT** generalize a scoped task to adjacent repos/targets. If the user names "frictio-infra," do exactly frictio-infra; do not extrapolate to frictio-server / frictio-web etc. Approving an issue I drafted does not authorize actions in repos I speculatively listed in the issue body. (2026-04-21 PLA-554.)
- **NEVER propose CI-as-required-status-check as a credential-leak prevention fallback.** CI fires after GitHub accepts the push — credential is already on GitHub's servers, automated scanners scrape pushed events within seconds. Only **GHAS Secret Protection (push protection, with custom patterns)** blocks pre-acceptance. CI scan = post-leak detection / audit only; surface it that way, separately, with the post-acceptance caveat.

## Working style
<!-- communication preferences, when to push back, verification expectations -->

## Defaults
<!-- tools, shells, package managers, etc. you reach for -->

## Recipes

Reference docs to read when the situation matches. Not preloaded — read on demand.

- Multi-repo workspace setup (org with several sibling repos + a dedicated
  Claude config repo): `~/dev/repo/k-nam/home/claude/recipes/multi-repo-workspace.md`
