FROM alpine:3.21.3

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

ARG TARGETARCH

# Install yq
RUN pip3 install --no-cache-dir yq

# Install AWS CLI
RUN pip3 install --no-cache-dir awscli

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/${TARGETARCH}/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/kubectl

# Install Helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && \
    chmod 700 get_helm.sh && \
    ./get_helm.sh && \
    rm get_helm.sh

# Install Helmfile
RUN HELMFILE_VERSION="0.170.1" && \
    curl -sSL -o helmfile.tar.gz "https://github.com/helmfile/helmfile/releases/download/v${HELMFILE_VERSION}/helmfile_${HELMFILE_VERSION}_linux_${TARGETARCH}.tar.gz" && \
    tar -xzf helmfile.tar.gz -C /usr/local/bin && \
    rm helmfile.tar.gz

# Install Helm diff plugin
RUN helm plugin install https://github.com/databus23/helm-diff

# Set default shell to bash
SHELL ["/bin/bash", "-c"]