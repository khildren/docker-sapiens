FROM debian:bookworm-slim

# Build-time variable; DO NOT persist DEBIAN_FRONTEND in the final image.
ARG DEBIAN_FRONTEND=noninteractive

# Enable i386 architecture, update, upgrade, and install required packages.
RUN dpkg --add-architecture i386 && \
    apt-get update -qq && \
    apt-get upgrade -y -qq && \
    apt-get install -y -qq software-properties-common && \
    # Add non-free repository
    echo "deb http://ftp.us.debian.org/debian bookworm main non-free" > /etc/apt/sources.list.d/non-free.list && \
    apt-get update -qq && \
    # Pre-accept the Steam license
    echo steam steam/question select "I AGREE" | debconf-set-selections && \
    echo steam steam/license note '' | debconf-set-selections && \
    # Install SteamCMD
    apt-get install -qq -y --install-recommends steamcmd && \
    apt-get autoremove -qq -y && \
    apt-get clean && \
    rm -rf /var/lib/{apt,dpkg,cache,log}

# Create a dedicated user "sapiens" with home directory /home/sapiens.
RUN adduser --disabled-password --gecos "" sapiens --home /home/sapiens

# Switch to the sapiens user and prepare necessary directories.
USER sapiens
RUN mkdir -p /home/sapiens/.local/share/majicjungle/

WORKDIR /home/sapiens

# Copy the entrypoint script into the image.
COPY entrypoint.sh /home/sapiens/

# Switch back to root to adjust permissions (sapiens user might not be able to modify file metadata).
USER root
RUN chmod +x /home/sapiens/entrypoint.sh

# Optionally, expose a port (update the port and protocol if needed).
EXPOSE 21025/udp

# Set the entrypoint; using the JSON (exec) form to ensure proper signal handling.
ENTRYPOINT ["/home/sapiens/entrypoint.sh"]
