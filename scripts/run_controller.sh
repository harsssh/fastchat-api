#!/bin/bash -ex

# 変数の存在チェック
: "${FSCHAT_CONTROLLER_HOST:?}"
: "${FSCHAT_CONTROLLER_PORT:?}"

python3.9 -m fastchat.serve.controller \
  --host "$FSCHAT_CONTROLLER_HOST" \
  --port "$FSCHAT_CONTROLLER_PORT"