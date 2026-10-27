FROM debian:bookworm-slim
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential git wget curl ca-certificates cpio unzip rsync file bc \
    python3 libncurses-dev perl patch gzip bzip2 xz-utils tar sed make \
    bash findutils diffutils && rm -rf /var/lib/apt/lists/*
WORKDIR /workspace
COPY . /workspace/
RUN chmod +x /workspace/scripts/*.sh
CMD ["bash", "scripts/build.sh"]
