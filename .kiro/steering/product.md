# Product Steering

## Purpose
This repository defines a layered Arch Linux setup:
- Layer1: base machine bootstrap (`bootstrap.sh`)
- Layer2: user dotfiles and shell/editor/tmux environment (in progress)

The goal is reproducible workstation setup with minimal manual steps.
This iteration specifically rebuilds dotfiles with a clean, intentional design.

## Users
- Primary: repository owner maintaining personal Linux workstation setup
- Secondary: trusted teammates who may reuse the bootstrap flow

## Outcomes
- Fast, deterministic machine provisioning on Arch Linux
- Safe reruns (`--needed`, idempotent installs, clear logging)
- Clear migration path from legacy config (`dotfiles-old/`) to curated Layer2
- A newly curated dotfiles set designed for current needs, not legacy compatibility
- Removal of clearly unnecessary legacy elements during migration

## Non-Goals
- Supporting non-Arch distributions in bootstrap scripts
- Heavy interactive installers
- Large framework abstraction for a single-user dotfiles repo

## Quality Bar
- Scripts must fail fast and explain failure clearly
- Defaults should be practical; optional behavior must be env-flag driven
- README must document one-shot usage and key flags
