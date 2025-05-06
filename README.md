# cd-tools

A Docker image for Continuous Deployment pipelines with Kubernetes support.

## Overview

This image contains essential tools for deployment automation in CI/CD environments, particularly focused on Kubernetes deployments with Helm and Helmfile.

## Included Tools

- **bash** - For robust shell scripting
- **git** - Version control and change detection
- **curl** - Network interactions and API calls
- **jq** - JSON parsing and manipulation
- **yq** - YAML parsing and manipulation
- **kubectl** - Kubernetes CLI
- **helm** - Kubernetes package manager
- **helmfile** - Declarative Helm chart management
- **aws-cli** - AWS command line interface
- **Supporting utilities**: Python, SSH client, OpenSSL

## Usage

### GitLab CI Example

```yaml
deploy-job:
  image: evilgn0me/cd-tools:latest
  script:
    - helmfile apply -f helmfile.yaml
```

### GitHub Actions Example

```yaml
steps:
  - name: Deploy to Kubernetes
    uses: docker://evilgn0me/cd-tools:latest
    with:
      args: kubectl apply -f manifests/
```

### Building Locally

```bash
# Clone the repository
git clone https://github.com/evilgn0me/cd-tools.git
cd cd-tools

# Build the image
docker build -t cd-tools:local .

# Run the image
docker run --rm cd-tools:local kubectl version --client
```

## Tags

- **latest** - Most recent build
- **YYYYMMDD** - Date-based tags for versioning
