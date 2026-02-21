# Observation (Reset)

## Scope
- Primary source: `dotfiles-shell-old/`
- Secondary source: `dotfiles-old/`
- Goal: shell 共通化の意図を活かしつつ、Layer1/Layer2 分離の最小構成へ再設計する

## Keep / Drop / Defer Table (v2)

| Source | Category | Decision | Target | Reason |
|---|---|---|---|---|
| `dotfiles-shell-old/.zshrc` | zsh interactive core | keep | Layer2 | 中核。依存強い部分だけ削って再構築 |
| `dotfiles-shell-old/.zshenv` | zsh env/path | keep | Layer2 | PATH管理を最小化して流用可能 |
| `dotfiles-shell-old/.zprofile` | login env/editor | keep | Layer2 | editor/lang/less設定の骨格として有用 |
| `dotfiles-shell-old/.zpreztorc` | prezto module selection | defer | Layer2 optional | prezto 前提が強いため optional 化 |
| `dotfiles-shell-old/.tmux.conf` | tmux core config | keep | Layer2 | pane移動等は有用。xsel/cpu plugin は削減対象 |
| `dotfiles-shell-old/install/link.sh` | symlink deploy | keep | Layer2 tooling | 役割は妥当。安全化して再実装する |
| `dotfiles-shell-old/install/setupShell.sh` | zsh/tmux installer | defer | Layer2 optional | `yarn` や外部 clone 前提で重い |
| `dotfiles-shell-old/install/setupVim.sh` | SpaceVim installer | drop | N/A | 最小 shell-first 方針から外れる |
| `dotfiles-shell-old/.SpaceVim.d/*` | editor config | drop | N/A | 初期スコープ外 |
| `dotfiles-shell-old/.config/ranger/*` | ranger config | defer | Layer2 optional | 必須ではないが後で追加可能 |
| `dotfiles-shell-old/.config/bat/config` | bat config | defer | Layer2 optional | 任意設定として分離可能 |
| `dotfiles-old/install-system.sh` | system entrypoint | keep | Layer1 | system側責務の分離方針に沿う |
| `dotfiles-old/install/packages.sh` | large package installer | drop | N/A | 過剰。最小方針に反する |
| `dotfiles-old/install/services.sh` | service/runtime setup | drop | N/A | dotfiles責務外 |
| `dotfiles-old/.config/autostart/*` | desktop autostart | drop | N/A | shell最小構成に不要 |
| `dotfiles-old/.config/Code/User/*` | VS Code settings | defer | Layer2 optional | まず shell/tmux 優先 |

## Layer Ownership Summary (v2)
- Layer1
  - `bootstrap.sh` と最小パッケージ導入
- Layer2
  - zsh/tmux の最小 dotfiles
  - 安全なリンク反映スクリプト
- Optional bucket (later)
  - prezto 拡張
  - ranger/bat/vscode などアプリ個別設定

## Package Selection Snapshot (from `dotfiles-old/install/packages.sh`)
- keep (Layer1):
  - `zsh`, `tmux`, `git`, `curl`, `wget`
  - `ripgrep`, `fd`, `fzf`, `bat`, `less`
  - `neovim`, `htop`, `tree`, `openssh`, `man-db`, `man-pages`
- defer:
  - `ranger`, `tig`, `tldr`, `jq`, `bind-tools`, `nmap`
- drop:
  - GUI群 (`alacritty`, `libreoffice-fresh`, `filezilla`, `zoom` など)
  - 言語ランタイム大量導入 (`php`, `ruby`, `r`, `deno` など)
  - サービス/インフラ用途 (`mariadb`, `ansible`, `terraform`, `aws-cli` など)

## Notes for Next Step
- `dotfiles-shell-old` の zsh から heavy dependency を外す
- tmux plugin は最小セットに絞る
- install は clone 前提から「存在すれば使う」設計へ変更する
