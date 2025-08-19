#!/bin/bash
set -e

cd /workspace/ComfyUI

# Always pull the latest ComfyUI
git pull
pip install -r requirements.txt --upgrade
pip install comfyui-frontend-package --upgrade
pip install insightface onnxruntime-gpu --upgrade

# Symlink models from network storage (mounted by RunPod)
mkdir -p models/checkpoints models/loras models/vae models/controlnet
ln -sfn /workspace/storage/checkpoints models/checkpoints
ln -sfn /workspace/storage/loras models/loras
ln -sfn /workspace/storage/vae models/vae
ln -sfn /workspace/storage/controlnet models/controlnet

# Start ComfyUI
exec python3 main.py --listen 0.0.0.0 --port 8188
