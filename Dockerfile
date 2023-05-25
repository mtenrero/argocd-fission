FROM argoproj/argocd:v2.5.17

# Switch to root for the ability to perform install
USER root

# Install tools needed for your repo-server to retrieve & decrypt secrets, render manifests 
# (e.g. curl, awscli, gpg, sops)
RUN apt-get update
RUN apt-get install -y \
        curl
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -Lo fission https://github.com/fission/fission/releases/download/v1.19.0/fission-v1.19.0-linux-amd64
RUN chmod +x fission && mv fission /usr/local/bin/

# Switch back to non-root user
USER $ARGOCD_USER_ID