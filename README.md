# HomeLLM: Your Personal LLM Gateway and chat UI

This project provides a straightforward boilerplate to deploy a powerful combination of Open WebUI and LiteLLM using Docker Compose. It's designed for personal use on your own server or VPS, giving you a private and controlled environment for interacting with various language models, fronted by a secure Traefik reverse proxy.

## What's Inside?

This setup bundles essential tools for your personal LLM stack:

*   **[Open WebUI](https://github.com/open-webui/open-webui):** A feature-rich, self-hosted web interface (similar to ChatGPT) for interacting with your language models.
*   **[LiteLLM](https://github.com/BerriAI/litellm):** A versatile proxy that standardizes API calls to over 100 LLM providers (OpenAI, Anthropic, local models via Ollama, etc.). This allows you to manage all your LLM API keys and model configurations in one place and use a single LiteLLM endpoint in various tools like [Aider](https://github.com/paul-gauthier/aider), [Cursor](https://cursor.sh/), or your own projects.
*   **PostgreSQL:** A shared database backend for both Open WebUI and LiteLLM persistence.
*   **Traefik:** A modern reverse proxy handling secure HTTPS connections (via Let's Encrypt) and routing traffic.
*   **Docker Compose:** The entire stack is defined in `docker-compose.yml` for easy, one-command deployment.

## Prerequisites

*   A Server/VPS (Linux recommended).
*   Docker & Docker Compose installed.
*   A Domain Name you manage. You'll need DNS records pointing to your server for the hostnames you configure.

## Setup Instructions

**1. Clone the Repository**

Get the project files onto your server:

```bash
git clone https://github.com/g1ibby/homellm.git
cd homellm
```

**2. Configure DNS (Cloudflare Recommended)**

*   You need to point DNS A records for the hostnames you intend to use (e.g., `chat.yourdomain.com`, `litellm.yourdomain.com`) to your server's public IP address.
*   We **recommend** using [Cloudflare](https://www.cloudflare.com/) for managing your DNS. Cloudflare can also handle SSL certificates (offering alternatives to Traefik's Let's Encrypt), potentially simplifying setup or providing additional security features. If using Cloudflare for SSL (set to "Full" or "Full (Strict)" mode), ensure Traefik is still configured correctly to serve certificates or handle the internal routing appropriately. For this guide, we assume Traefik handles the Let's Encrypt certificates directly.

**3. Create and Configure `.env` File**

This is crucial for storing your secrets and deployment-specific settings.

*   Copy the template file:
```bash
cp .env.dist .env
```
*   **Edit the `.env` file**.
*   Carefully replace **ALL** placeholder values with your actual secrets and desired hostnames. Pay close attention to the comments in the `.env.dist` file for guidance, especially the required `sk-` prefix for `LITELLM_MASTER_KEY` and `LITELLM_SALT_KEY`.

**4. Launch the Stack**

Start all the services:

```bash
docker-compose up -d
```

Docker Compose will read the configuration, pull images, and start the containers. If the host directories specified in the `volumes` sections of `docker-compose.yml` (like `./postgres-data`, `./open-webui`) don't exist, Docker will typically create them automatically.

**5. Access Your Services**

*   Allow a minute or two for services to fully initialize and for Traefik to obtain SSL certificates if needed.
*   Open your browser and navigate to the hostnames you configured in your `.env` file:
    *   `https://<Your-OpenWebUI-Hostname>` (e.g., `https://chat.yourdomain.com`)
    *   `https://<Your-LiteLLM-Hostname>` (e.g., `https://litellm.yourdomain.com`)

You should be greeted by the respective interfaces, served over HTTPS.

Enjoy your self-hosted LLM gateway and UI!
