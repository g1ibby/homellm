#!/bin/bash

# Wait for PostgreSQL to be ready
/wait-for-it.sh postgres:5432 --timeout=30 --strict -- echo "Postgres is up."

# Execute the original entrypoint command
exec litellm --port 4000 --run_gunicorn --config /app/config.yaml
