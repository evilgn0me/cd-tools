FROM alpine:3.21.3

ARG TARGETARCH

# Combine all installation steps into a single layer
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
    tzdata \
    yq \
    aws-cli && \
    # Install kubectl
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/${TARGETARCH}/kubectl" && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/kubectl && \
    # Install Helm
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 && \
    chmod 700 get_helm.sh && \
    ./get_helm.sh && \
    rm get_helm.sh && \
    # Install Helmfile
    HELMFILE_VERSION="0.170.1" && \
    curl -sSL -o helmfile.tar.gz "https://github.com/helmfile/helmfile/releases/download/v${HELMFILE_VERSION}/helmfile_${HELMFILE_VERSION}_linux_${TARGETARCH}.tar.gz" && \
    tar -xzf helmfile.tar.gz -C /usr/local/bin && \
    rm helmfile.tar.gz && \
    # Install Helm diff plugin
    helm plugin install https://github.com/databus23/helm-diff

# Set default shell to bash
SHELL ["/bin/bash", "-c"]