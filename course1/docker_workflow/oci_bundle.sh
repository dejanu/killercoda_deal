apt-get update && apt-get install -y cowsay --no-install-recommends && apt-get clean && rm -rf /var/lib/apt/lists/*
ENV PATH $PATH:/usr/games