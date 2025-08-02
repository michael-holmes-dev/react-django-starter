#!/bin/bash

echo "Starting entrypoint.sh"

# Install dependencies from requirements.txt
echo "Installing dependencies"
pip install -r requirements.txt

# Wait for the PostgreSQL service to be ready
echo "Waiting for PostgreSQL"
while ! nc -z db 5432; do
  echo "Waiting for database connection..."
  sleep 2
done
echo "PostgreSQL is ready"

# Then run migrations
echo "Running migrations"
python manage.py makemigrations
python manage.py migrate
echo "Migrations complete"

# Start Django development server
echo "Starting Django development server"
python manage.py runserver 0.0.0.0:8000