#!/usr/bin/env bash
set -ex

mkdir -p ~/.local/share/typst/packages/$(head -n 1 main.typ | sed -e "s/.*\"@\(.*\)\".*/\1/" | cut -d: -f1)
ln -sf $(realpath .) ~/.local/share/typst/packages/$(head -n 1 main.typ | sed -e "s/.*\"@\(.*\)\".*/\1/" | sed -e "s/:/\//")
