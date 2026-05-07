#!/usr/bin/env bash
set -ex

mkdir -p ~/.local/share/typst/packages/$(head -n 1 tümpel/main.typ | sed -e "s/.*\"@\(.*\)\".*/\1/" | cut -d: -f1)
ln -sf $(realpath ./tümpel) ~/.local/share/typst/packages/$(head -n 1 tümpel/main.typ | sed -e "s/.*\"@\(.*\)\".*/\1/" | sed -e "s/:/\//")
