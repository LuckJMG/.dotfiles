#!/usr/bin/env bash

# bun completions
[ -s "/home/luck/.bun/_bun" ] && source "/home/luck/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
