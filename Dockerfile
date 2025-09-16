# Use official Python image
FROM python:3.12-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y build-essential gcc

# Upgrade pip, setuptools, wheel
RUN pip install --upgrade pip setuptools wheel

# Copy requirements and install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy project code
COPY . .

# Expose port
EXPOSE 8000

# Command to run
CMD ["gunicorn", "myapp.wsgi:application", "--bind", "0.0.0.0:8000"]

