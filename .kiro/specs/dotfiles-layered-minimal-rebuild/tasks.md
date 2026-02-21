# Tasks

## Phase 1: Re-observe legacy sources
- [x] `dotfiles-shell/` のファイルをカテゴリ分けする（主ソース）
- [x] `dotfiles-old/` の補助参照ポイントを抽出する（補助ソース）
- [x] `keep / drop / defer` 判定表を再作成する
- [x] Layer1/Layer2 へ再割り当てする

## Phase 2: Rebuild minimal Layer2
- [x] `layer2/install.sh` を external `dotfiles-shell` 実行方式に切り替える
- [x] Layer2 のローカル `home` 管理を廃止する

## Phase 3: Align Layer1
- [x] Layer1 からユーザー設定責務を除外する
- [x] 必要最小限のパッケージ方針を確認する
- [x] `dotfiles-old/install/packages.sh` 由来の keep/defer/drop を確定する
- [x] keep パッケージを Layer1 の allowlist に反映する

## Phase 4: Documentation
- [x] README に Layer1/Layer2 責務境界を明記する
- [x] 移植対象/削除対象/保留対象の判断ログを記録する
- [x] 実行手順を最短導線で更新する

## Done Definition
- [ ] 最小 dotfiles が起動確認できる
- [ ] 旧構成（shell-old / old）からの不要要素削除が説明可能
- [ ] 再実行しても安全な構成になっている
