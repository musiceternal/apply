FROM mcr.microsoft.com/devcontainers/php:1-8.2-bullseye

# Install Node.js 20
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs

# Install additional PHP extensions
RUN install-php-extensions pdo_mysql gd zip intl

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

# Install global npm packages
RUN npm install -g npm@latest

# Create workspace directory
RUN mkdir -p /workspaces && chown -R vscode:vscode /workspaces

# Set working directory
WORKDIR /workspaces/apply

# Switch to vscode user
USER vscode
