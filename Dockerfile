# Use Node.js image
FROM node:24-slim

# Install git and build tools
RUN apt-get update && apt-get install -y git ca-certificates && rm -rf /var/lib/apt/lists/*

# Install pnpm (OpenClaw uses pnpm)
RUN npm install -g pnpm

# Clone and build OpenClaw from source
RUN git clone https://github.com/openclaw/openclaw.git /opt/openclaw && \
    cd /opt/openclaw && \
    pnpm install --frozen-lockfile && \
    pnpm build && \
    pnpm link

# Create a non-root user for security
RUN useradd -m appuser
WORKDIR /app
USER appuser

# Set environment variables for OpenClaw
# These can be overridden by Render's render.yaml or dashboard
ENV OPENCLAW_STATE_DIR=/tmp/.openclaw
ENV OPENCLAW_WORKSPACE_DIR=/tmp/workspace
ENV OPENCLAW_GATEWAY_BIND=0.0.0.0
ENV OPENCLAW_GATEWAY_PORT=18789

# Expose the gateway port
EXPOSE 18789

# Run the gateway with allow-unconfigured for initial setup
CMD ["openclaw", "gateway", "--allow-unconfigured"]