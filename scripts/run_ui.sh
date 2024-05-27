#!/bin/bash -ex

: "${FSCHAT_CONTROLLER_PORT:?}"

# TODO: Port を環境変数で指定する
python3.9 -m fastchat.serve.gradio_web_server_multi \
    --host 0.0.0.0 \
    --port 8080 \
    --controller-url "http://controller:${FSCHAT_CONTROLLER_PORT}"
