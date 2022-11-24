FROM ubuntu:latest
LABEL "com.github.actions.name"="GitHub Action for Pushing Changes to your Coder Template"
LABEL "com.github.actions.description"="An action to deploy changes to your coder template automatically"
LABEL "com.github.actions.icon"="arrow-up"
LABEL "com.github.actions.color"="purple"
LABEL "repository"="http://github.com/matifali/update-coder-template"
LABEL "maintainer"="Muhammad Atif Ali <matifali@live.com>"

# Install curl
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Install the coder binary
RUN curl -L https://coder.com/install.sh | sh

# Entry point
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
