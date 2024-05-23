#!/bin/bash -ex

# 変数の存在チェック
: "${FSCHAT_API_HOST:?}"
: "${FSCHAT_API_PORT:?}"
: "${FSCHAT_CONTROLLER_PORT:?}"

python3.9 -m fastchat.serve.openai_api_server \
  --host "$FSCHAT_API_HOST" \
  --port "$FSCHAT_API_PORT" \
  --controller-address "http://controller:$FSCHAT_CONTROLLER_PORT"