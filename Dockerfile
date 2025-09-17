ן# Use official Python image
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Copy requirements and install
COPY requirements.txt .

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    libpq-dev \
    libjpeg-dev \
    zlib1g-dev \
    libyaml-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements and install
RUN pip install --upgrade pip setuptools wheel cython
RUN pip install --no-cache-dir -r requirements.txt

# Copy project code
COPY . .

# Expose port
EXPOSE 8000

# Command to run
CMD ["gunicorn", "myapp.wsgi:application", "--bind", "0.0.0.0:8000"]

