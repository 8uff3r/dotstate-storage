#!/bin/bash

lg() {
  local RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case"
  local INITIAL_QUERY="${1:-}"

  FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY'" \
    fzf --ansi --disabled --query "$INITIAL_QUERY" \
        --bind "change:reload:$RG_PREFIX {q} || true" \
        --delimiter ':' \
        --preview 'bat --color=always --style=numbers --highlight-line {2}:{2} {1}' \
        --preview-window '+{2}-5'  | cut -d: -f1,2,3
}

lg "$@"
