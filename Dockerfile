FROM ubuntu:22.04

COPY container-root/ /

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update && apt-get dist-upgrade -y \
    && apt-get install -y \
        curl \
        git \
        gzip \
        zip \
        jq \
        openssh-client \
    && curl -s https://raw.githubusercontent.com/scaleway/scaleway-cli/master/scripts/get.sh | sh \
    && LASTK8S=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt) \
    && curl -sL https://storage.googleapis.com/kubernetes-release/release/${LASTK8S}/bin/linux/amd64/kubectl -o kubectl \
    && install -m 755 kubectl /usr/local/bin/kubectl \
    && curl -sL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash \
    && TMPD=$(mktemp -d) && cd $TMPD \
    && OS="$(uname | tr '[:upper:]' '[:lower:]')" \
    && ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" \
    && KREW="krew-${OS}_${ARCH}" \
    && curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" \
    && tar zxvf "${KREW}.tar.gz" \
    && ./"${KREW}" install krew \
    && cd && rm -rf $TMPD \
    && export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH" \
    && kubectl krew install neat get-all slice \
    && mkdir -p /root/.ssh /root/.kube /cli \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /cli