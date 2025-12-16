FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    libstdc++6 \
    libgcc-s1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy server files into /app
COPY . /app

RUN chmod +x /app/SapiensDedicatedServer /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
