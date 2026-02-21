# Structure Steering

## Current Layout
- `bootstrap.sh`: Layer1 machine bootstrap entrypoint
- `README.md`: top-level usage and flags
- `dotfiles-old/`: legacy source-of-truth during migration

## Target Layout
- `layer1/`: base system bootstrap and machine-wide setup
- `layer2/`: user-level dotfiles and shell/editor/tmux configs
- `scripts/` (optional): reusable helper scripts for install/link tasks

## File Ownership Rules
- Keep Layer1 concerns separate from Layer2 concerns
- Do not modify `dotfiles-old/` except for reference or migration notes
- New active config should live in target layout (`layer1/`, `layer2/`)

## Change Patterns
- Small, composable scripts over one giant script
- Prefer additive migrations (copy/transform) before deleting legacy artifacts
- Preserve backward-compatible bootstrap invocation from README when possible
- Rebuild active dotfiles from design intent first, then selectively port proven pieces
- Delete clearly unnecessary legacy files/settings instead of preserving by default

## Review Checklist
- Is the change in the correct layer?
- Is behavior idempotent on rerun?
- Are new flags/options documented?
- Is there a clear rollback or safe failure mode?
- Is this legacy element still necessary for the new design?
