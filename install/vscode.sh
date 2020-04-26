#!/bin/bash

VSCODE_PKG_LIST=(
  JuanBlanco.solidity
  MS-CEINTL.vscode-language-pack-ja
  PeterJausovec.vscode-docker
  Prisma.vscode-graphql
  bungcip.better-toml
  chrmarti.regex
  dsznajder.es7-react-js-snippets
  dunstontc.vscode-rust-syntax
  esbenp.prettier-vscode
  felixfbecker.php-debug
  felixfbecker.php-intellisense
  foxundermoon.shell-format
  kokororin.vscode-phpfmt
  lihui.vs-color-picker
  ms-mssql.mssql
  ms-python.python
  ms-vscode.Go
  ms-vscode.cpptools
  ms-vscode.csharp
  ms-vscode.powershell
  msjsdiag.debugger-for-chrome
  rust-lang.rust
  shd101wyy.markdown-preview-enhanced
  timonwong.shellcheck
  GrapeCity.gc-excelviewer
  neilbrayfield.php-docblocker
  joelday.docthis,
  arjun.swagger-viewer,
  alanz.vscode-hie-server,
  file-tree-generator,
  mauve.terraform,
  amazonwebservices.aws-toolkit-vscode,
  joelday.docthis,
  vscodevim.vim
)

for i in "${VSCODE_PKG_LIST[@]}"; do
  code --install-extension $i
done