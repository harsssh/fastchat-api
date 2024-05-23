#!/bin/bash -ex

# 変数の存在チェック
: "${FSCHAT_WORKER_MODEL_NAMES:?}"  # TODO: 必須にするかどうか検討
: "${FSCHAT_WORKER_MODEL_PATHS:?}"  # TODO: 必須にするかどうか検討
: "${FSCHAT_WORKER_HOST:?}"
: "${FSCHAT_WORKER_PORT:?}"
: "${FSCHAT_CONTROLLER_PORT:?}"
: "${FSCHAT_WORKER_NUM_GPUS:?}"
: "${FSCHAT_WORKER_CONV_TEMPLATE:?}"

IFS=',' read -r -a model_paths <<< "$FSCHAT_WORKER_MODEL_PATHS"
IFS=',' read -r -a model_names <<< "$FSCHAT_WORKER_MODEL_NAMES"

for i in "${!model_paths[@]}"; do
  # TODO: ポート番号の決め方を見直す
  worker_port=$((FSCHAT_WORKER_PORT + i))

  # TODO: デバイスの振り分け方を見直す
  CUDA_VISIBLE_DEVICES="$i" python3.9 -m fastchat.serve.vllm_worker \
    --host "$FSCHAT_WORKER_HOST" \
    --port "$worker_port" \
    --model-path "${model_paths[$i]}" \
    --model-name "${model_names[$i]}" \
    --worker-address "http://model-worker:$worker_port" \
    --controller-address "http://controller:$FSCHAT_CONTROLLER_PORT" \
    --num-gpus "$FSCHAT_WORKER_NUM_GPUS" \
    --conv-template "$FSCHAT_WORKER_CONV_TEMPLATE" &
done

wait
