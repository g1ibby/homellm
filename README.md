# HomeLLM: Personal LLM Gateway and Chat UI

A complete, production-ready Docker Compose setup for deploying your own private LLM infrastructure. Get a ChatGPT-like interface that works with any LLM provider - OpenAI, Anthropic, Google, local models, and more. Pay per token across multiple providers while managing all your API keys and usage from one centralized dashboard.

**What you get:**
- ChatGPT-style web interface for any LLM provider
- Unified API endpoint for all your language models
- Centralized token usage tracking and billing management
- Self-hosted, private alternative to ChatGPT Plus

## What's Included

- **[Open WebUI](https://github.com/open-webui/open-webui)** - Feature-rich web interface for interacting with language models
- **[LiteLLM](https://github.com/BerriAI/litellm)** - Unified API gateway for 100+ LLM providers (OpenAI, Anthropic, local models)
- **PostgreSQL** - Shared database for persistence
- **Traefik** - Reverse proxy with automatic HTTPS via Let's Encrypt
- **Optional S3 Backup** - Automated database backups

## Server Requirements

- **Memory**: Minimum 1GB RAM
- **Storage**: 50GB disk space (for Docker images and data)
- **OS**: Linux (Debian/Ubuntu recommended)
- **Domain**: DNS records pointing to your server

## Deployment Methods

You can deploy HomeLLM in two ways:

### Method 1: Automated GitHub Actions Deployment (Recommended)

Fork this repository and deploy automatically on every push to main.

#### Setup Steps

1. **Fork this repository** to your GitHub account

2. **Configure Repository Secrets** in your forked repo:
   Go to Settings → Secrets and Variables → Actions, then add all the secrets from the table below.

3. **Configure Repository Variables**:
   - Set `COMPOSE_PROFILES` to `backup` if you want automated backups (optional)

4. **Push to main branch** - deployment happens automatically!

The deployment uses [DCD (Deploy Docker Compose)](https://github.com/g1ibby/dcd) tool for fast, reliable deployments to your server.

### Method 2: Manual Deployment

Deploy directly on your server using Docker Compose.

#### Setup Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/g1ibby/homellm.git
   cd homellm
   ```

2. **Configure environment**
   ```bash
   cp .env.dist .env
   # Edit .env with your values (see table below)
   ```

3. **Deploy**
   ```bash
   docker-compose up -d
   ```

## Environment Variables

Both deployment methods require the same environment variables. For GitHub Actions, set these as **Repository Secrets**. For manual deployment, configure them in your `.env` file.

### Required Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `POSTGRES_USER` | PostgreSQL username | `postgres` |
| `POSTGRES_PASSWORD` | PostgreSQL password | `your_strong_password` |
| `LITELLM_HOSTNAME` | LiteLLM domain | `litellm.yourdomain.com` |
| `LITELLM_MASTER_KEY` | LiteLLM API key (must start with `sk-`) | `sk-your_master_key` |
| `LITELLM_SALT_KEY` | LiteLLM encryption key (must start with `sk-`) | `sk-your_salt_key` |
| `LITELLM_UI_USERNAME` | LiteLLM admin username | `admin` |
| `LITELLM_UI_PASSWORD` | LiteLLM admin password | `your_admin_password` |
| `OPENWEBUI_HOSTNAME` | Open WebUI domain | `chat.yourdomain.com` |
| `WEBUI_SECRET_KEY` | Open WebUI secret key | `your_secret_key` |

### GitHub Actions Only

| Variable | Description | Example |
|----------|-------------|---------|
| `DEPLOY_TARGET` | SSH connection string | `user@your-server.com:22` |
| `SSH_PRIVATE_KEY` | SSH private key content | `-----BEGIN OPENSSH PRIVATE KEY-----...` |

### Optional (S3 Backups)

| Variable | Description | Example |
|----------|-------------|---------|
| `COMPOSE_PROFILES` | Enable backup service | `backup` |
| `S3_BUCKET` | S3 bucket name | `your-backup-bucket` |
| `S3_ID` | S3 access key ID | `AKIAIOSFODNN7EXAMPLE` |
| `S3_SECRET` | S3 secret access key | `wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY` |
| `S3_REGION` | S3 region | `us-east-1` |
| `S3_ENDPOINT` | S3 endpoint (for non-AWS) | `https://s3.amazonaws.com` |

## DNS Configuration

Point these A records to your server's IP address:
- `chat.yourdomain.com` (or your chosen OpenWebUI hostname)
- `litellm.yourdomain.com` (or your chosen LiteLLM hostname)

**Cloudflare users**: Set SSL mode to "Full" or "Full (Strict)" for optimal compatibility.

## Access Your Services

After deployment (allow 1-2 minutes for initialization):

- **Chat Interface**: `https://chat.yourdomain.com`
- **LiteLLM API**: `https://litellm.yourdomain.com`

## Database Backups

When `COMPOSE_PROFILES=backup` is set, the system automatically:
- Backs up both databases daily at midnight
- Retains backups for 7 days
- Stores backups in your configured S3 bucket

## Monitoring

View logs for troubleshooting:
```bash
# All services
docker-compose logs

# Specific service
docker-compose logs traefik
docker-compose logs litellm
docker-compose logs open-webui
```

## Security Notes

- All secrets should be randomly generated
- LiteLLM keys must start with `sk-` prefix
- Use strong passwords for all accounts
- Keep your server and Docker images updated
- Consider setting up fail2ban for SSH protection

---

**Note**: This setup is designed for personal/small team use. For production environments with high traffic, consider additional security hardening and scaling strategies.
