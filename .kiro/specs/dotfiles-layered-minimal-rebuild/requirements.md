# Requirements

## Spec
- Title: dotfiles-shell-old を主ソースに、Layer1/Layer2責務分離した最小dotfilesを再構築する
- Status: Draft (Reset)

## Background
- `dotfiles-shell-old/` はシェル系設定を独立管理する意図で作られていた可能性が高い。
- `dotfiles-old/` は system/user 設定やアプリ固有設定が混在しており、最小化方針には過剰。
- 新構成では、シェル共通基盤を Layer2 に寄せつつ、Layer1 は OS/bootstrap のみに限定する。

## Goals
- `dotfiles-shell-old/` を中心に、再利用可能な shell/tmux 最小構成を定義する。
- Layer1(システム初期化) と Layer2(ユーザーdotfiles) を厳密に分離する。
- `dotfiles-old/` は補助参照に留め、不要要素を持ち込まない。
- `dotfiles-old/install/packages.sh` の中から必要パッケージを選抜して取り込む。

## Non-Goals
- `dotfiles-shell-old/` / `dotfiles-old/` の完全互換。
- VS Code/desktop/autostart など GUI 周辺設定の初期同梱。
- プロジェクト固有の言語ランタイム構築を dotfiles の責務に含めること。

## Functional Requirements
1. 観測対象を `dotfiles-shell-old/` (主) と `dotfiles-old/` (補助) に再定義する。
2. `keep / drop / defer` 判定表を再作成する。
3. Layer2 最小構成として `~/.zshrc`, `~/.zshenv`, `~/.zprofile`, `~/.tmux.conf` の方針を確定する。
4. Prezto/TPM など外部依存は optional 化し、最小起動を阻害しない設計にする。
5. Layer1 は bootstrap と最小パッケージ導入のみを扱う。
6. 旧不要要素はデフォルトで除外し、必要なら後段で opt-in 追加する。
7. `dotfiles-old` 由来のパッケージは allowlist 方式で採用する（丸ごと移植しない）。

## Acceptance Criteria
- spec に主ソース/補助ソースの扱いが明記されている。
- Layer2 最小構成で zsh と tmux が起動可能。
- 移植対象/削除対象/保留対象が一覧化されている。
- `dotfiles-old` 由来パッケージの採用リスト（keep/defer/drop）が定義されている。
- 再実行しても安全な構成方針になっている。

## Initial Observation Notes (Reset)
- `dotfiles-shell-old/` には zsh + tmux + link スクリプトの核がある。
- `dotfiles-shell-old/install/setupShell.sh` は `yarn` 前提など依存が強い。
- `dotfiles-old/` 側の大量パッケージ・サービス設定は最小構成の対象外。
