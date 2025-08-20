FROM nvidia/cuda:12.2.2-devel-ubuntu22.04

# Set non-interactive to avoid tzdata prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    git python3 python3-venv python3-pip ffmpeg wget curl unzip build-essential && \
    rm -rf /var/lib/apt/lists/*

# Create workspace
WORKDIR /workspace

# Clone ComfyUI
RUN git clone https://github.com/comfyanonymous/ComfyUI.git

# Install ComfyUI requirements
WORKDIR /workspace/ComfyUI
RUN pip install --upgrade pip && pip install -r requirements.txt

# Install ComfyUI frontend package
RUN pip install comfyui-frontend-package --upgrade

# Install InsightFace (for face workflows)
RUN pip install insightface onnxruntime-gpu

# Expose ComfyUI default port
EXPOSE 8188

# Copy in startup script
COPY start.sh /workspace/start.sh
RUN chmod +x /workspace/start.sh

CMD ["/workspace/start.sh"]
