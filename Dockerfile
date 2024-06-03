FROM nvidia/cuda:12.2.2-devel-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive

# 基本的な依存パッケージ, コマンド
RUN apt-get update -y && \
    apt-get install -y python3.9 python3.9-distutils python3.9-dev gcc curl git && \
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3.9 get-pip.py && \
    rm get-pip.py

# FastChat
RUN git clone -b patch https://github.com/harsssh/FastChat.git && \
    pip3 install -e 'FastChat[model_worker,webui]'

# 追加
RUN pip3 install vllm torch packaging ninja && pip3 install flash-attn --no-build-isolation
RUN pip3 install accelerate plotly
