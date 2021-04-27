#!/usr/bin/env bash
complete tree-sitter generate -o filenames  -X !*.js;
complete -W "build-wasm dump-languages generate help highlight init-config parse query tags test web-ui" tree-sitter;
