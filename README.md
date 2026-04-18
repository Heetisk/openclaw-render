# OpenClaw on Render

Customized deployment configuration for running OpenClaw on Render.

## Deployment

Click to deploy:

[![Deploy to Render](https://render.com/images/deploy_to_render.svg)](https://render.com/deploy?repo=https://github.com/openclaw/openclaw)

## Fix for "No Open Ports Found" Error

This repository contains a fixed `render.yaml` that resolves the "no open ports found" error.

### The Problem
The original OpenClaw render.yaml had two issues:
1. `OPENCLAW_GATEWAY_PORT` was set to `8080` but the gateway runs on port `18789` by default
2. The gateway binds to `127.0.0.1` (localhost) by default for security, making it inaccessible from outside the container

### The Fix
The fixed render.yaml sets:
- `OPENCLAW_GATEWAY_PORT=18789` - matches the actual gateway port
- `OPENCLAW_GATEWAY_BIND=0.0.0.0` - binds to all interfaces so Render can access it

## After Deployment

1. Get your service URL: `https://<service-name>.onrender.com`
2. Get the `OPENCLAW_GATEWAY_TOKEN` from Dashboard → Environment
3. Access the dashboard at your service URL and login with the token

## Troubleshooting

### Still getting "no open ports found"?
- The deployment may need more time. Check the build logs in Render Dashboard.
- Ensure the build completes successfully before the health check runs.

### Service won't start
- Verify `OPENCLAW_GATEWAY_TOKEN` is set in Dashboard → Environment
- Check the deployment logs for errors

### Slow cold starts (free tier)
- Free tier services spin down after 15 minutes of inactivity.
- Upgrade to Starter plan for always-on.