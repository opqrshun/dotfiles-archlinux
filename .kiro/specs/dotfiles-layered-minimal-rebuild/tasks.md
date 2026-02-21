# Tasks

## Phase 1: Re-observe legacy sources
- [ ] `dotfiles-shell-old/` のファイルをカテゴリ分けする（主ソース）
- [ ] `dotfiles-old/` の補助参照ポイントを抽出する（補助ソース）
- [ ] `keep / drop / defer` 判定表を再作成する
- [ ] Layer1/Layer2 へ再割り当てする

## Phase 2: Rebuild minimal Layer2
- [ ] `layer2/home/.zshenv` の最小版を作成する
- [ ] `layer2/home/.zprofile` の最小版を作成する
- [ ] `layer2/home/.zshrc` の最小版を作成する
- [ ] `layer2/home/.tmux.conf` の最小版を作成する
- [ ] 不要な alias/plugin/options を除外する

## Phase 3: Align Layer1
- [ ] Layer1 からユーザー設定責務を除外する
- [ ] 必要最小限のパッケージ方針を確認する
- [ ] `dotfiles-old/install/packages.sh` 由来の keep/defer/drop を確定する
- [ ] keep パッケージを Layer1 の allowlist に反映する

## Phase 4: Documentation
- [ ] README に Layer1/Layer2 責務境界を明記する
- [ ] 移植対象/削除対象/保留対象の判断ログを記録する
- [ ] 実行手順を最短導線で更新する

## Done Definition
- [ ] 最小 dotfiles が起動確認できる
- [ ] 旧構成（shell-old / old）からの不要要素削除が説明可能
- [ ] 再実行しても安全な構成になっている
