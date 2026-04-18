# Use Node.js slim image
FROM node:24-slim

# Install OpenClaw CLI globally
RUN npm install -g openclaw

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
ENV OPENCLAW_GATEWAY_TOKEN=${OPENCLAW_GATEWAY_TOKEN} # Will be set by Render

# Expose the gateway port
EXPOSE 18789

# Run the gateway with allow-unconfigured for initial setup
CMD ["openclaw", "gateway", "--allow-unconfigured"]