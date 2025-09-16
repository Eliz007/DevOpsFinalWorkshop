#!/bin/sh

set -e

cd /opt/status-page-app/statuspage/

echo "Applying database migrations..."
python manage.py migrate --noinput

echo "Collecting static files..."
python manage.py collectstatic --noinput

echo "Starting Gunicorn..."
exec gunicorn statuspage.wsgi:application --bind 0.0.0.0:8000 --workers 3
