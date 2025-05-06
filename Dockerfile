FROM alpine:3.18

# Install base tools
RUN apk add --no-cache \
    bash \
    curl \
    git \
    jq \
    py3-pip \
    python3 \
    openssh-client \
    ca-certificates \
    openssl \
    unzip \
    tzdata

# Install yq
RUN pip3 install --no-cache-dir yq

# Install AWS CLI
RUN pip3 install --no-cache-dir awscli

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/

# Install Helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && \
    chmod 700 get_helm.sh && \
    ./get_helm.sh && \
    rm get_helm.sh

# Install Helmfile
RUN HELMFILE_VERSION=$(curl -s https://api.github.com/repos/helmfile/helmfile/releases/latest | grep tag_name | cut -d '"' -f 4) && \
    curl -Lo helmfile https://github.com/helmfile/helmfile/releases/download/${HELMFILE_VERSION}/helmfile_linux_amd64 && \
    chmod +x helmfile && \
    mv helmfile /usr/local/bin/helmfile

# Set default shell to bash
SHELL ["/bin/bash", "-c"]