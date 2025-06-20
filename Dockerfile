FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt update && \
    apt install -y software-properties-common wget curl git openssh-client python3 python3-pip && \
    curl -sL https://github.com/tmate-io/tmate/releases/download/2.4.0/tmate-2.4.0-static-linux-amd64.tar.xz | tar -xJ && \
    mv tmate-*/tmate /usr/local/bin/ && \
    chmod +x /usr/local/bin/tmate && \
    apt clean

# Create dummy app dir and index page
WORKDIR /app
RUN echo "Tmate Session Running..." > index.html

# Expose a fake port to keep Railway alive
EXPOSE 6080

# Start tmate and dummy HTTP server
CMD bash -c "python3 -m http.server 6080 & tmate -F"
