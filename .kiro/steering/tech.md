# Technical Steering

## Stack
- Shell: `bash` (portable, strict mode enabled)
- OS target: Arch Linux (`pacman`, optional `yay`)
- Repo style: plain scripts + markdown docs

## Script Conventions
- Start scripts with:
  - `#!/usr/bin/env bash`
  - `set -euo pipefail`
- Prefer small helper functions (`log`, `die`, `require_cmd`)
- Use explicit env flags for optional behavior
- Keep commands idempotent when feasible (`pacman -S --needed`)

## Dependency Policy
- Prefer official Arch packages first
- Use AUR only when explicitly requested via env flags
- Avoid adding new runtime dependencies unless they reduce complexity materially
- During migration, do not carry forward old dependencies unless actively required

## Safety & Reliability
- Validate prerequisites before side effects
- Avoid destructive behavior by default
- Print timestamped progress logs for long-running operations

## Documentation Policy
- Keep `README.md` aligned with script behavior
- Every new env flag must be documented with effect and default

## Cleanup Policy
- Treat `dotfiles-old/` as reference, not as a direct template
- Remove obsolete aliases/options/plugins that have no clear current use
- Keep only settings that are tested in the new Layer2 environment
