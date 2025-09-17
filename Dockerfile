# Use official Python image
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Copy requirements first (for better layer caching)
COPY requirements.txt .

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    libjpeg-dev \
    zlib1g-dev \
    libyaml-dev \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip, setuptools, wheel, cython
RUN pip install --upgrade --force-reinstall pip setuptools wheel cython

# Install Python dependencies using only pre-built wheels
RUN pip install --no-cache-dir --only-binary :all: -r requirements.txt

# Copy project code
COPY . .

# Expose application port
EXPOSE 8000

# Command to run the app with Gunicorn
CMD ["gunicorn", "myapp.wsgi:application", "--bind", "0.0.0.0:8000"]

