# Design

## Architecture
- Layer1: Arch Linux 向け bootstrap と最小共通ツール導入
- Layer2: shell-first なユーザー設定とリンク反映

## Source Priority
1. Primary: `dotfiles-shell/`
2. Secondary: `dotfiles-old/`

`dotfiles-shell/` は shell 共通化の設計意図を持つため、Layer2 の設計起点とする。

## Responsibility Split
- Layer1 owns:
  - `bootstrap.sh` とその周辺
  - 必須 CLI のみ導入（過剰依存を避ける）
  - `dotfiles-old` 由来パッケージの採用先
- Layer2 owns:
  - `layer2/install.sh` (external `dotfiles-shell` を clone/update して実行)

## Minimal Shell Design
- zsh は「起動に必須な設定」だけを初期搭載する
- Prezto / pure / thefuck / z などは optional 扱いにする
- alias は汎用性が高いもののみ残し、OS や個別ツール前提を削る

## Minimal Tmux Design
- prefix, pane 移動、設定再読込など必須キーのみ
- plugin は `tmux-sensible` 程度までに抑え、CPU/logging などは optional
- `xsel` 前提のコピー連携は Linux 環境依存のため defer

## Migration Strategy (Reset)
1. `dotfiles-shell/` の shell/tmux を棚卸しし `keep / drop / defer` 判定
2. `dotfiles-old/` は不足部分の補助参照のみ
3. Layer2 は external `dotfiles-shell` 実行方式へ切り替え
4. README に Layer1/Layer2 の責務境界を反映

## Package Selection Strategy
- Source list: `dotfiles-old/install/packages.sh`
- Method: `keep / defer / drop` で選別し、Layer1 の package allowlist に反映
- Rule:
  - keep: shell/tmux/dotfiles 運用に直結するもの
  - defer: 利用者次第の便利ツール
  - drop: GUI依存、重い言語ランタイム、サービス構築用途

## Initial Keep Candidates (from dotfiles-old)
- `zsh`, `tmux`, `git`, `curl`, `wget`
- `ripgrep`, `fd`, `fzf`, `bat`, `less`
- `neovim`, `htop`, `tree`, `openssh`, `man-db`, `man-pages`

## Risks
- shell 依存の削減で操作習慣が一時的に変わる
- optional 化した機能の再導入漏れ

## Mitigations
- `keep / drop / defer` の判断理由を記録
- optional 機能を `layer2/optional/` へ分離予定として管理
