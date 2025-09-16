# Base image עם Python 3.10
FROM python:3.10-slim

# משתני סביבה לדאנג'ו
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# התקנת תלויות מערכת נדרשות
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# הגדרת תיקיית עבודה
WORKDIR /opt/status-page-app

# התקנת דרישות
COPY requirements.txt /opt/status-page-app/
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# העתקת כל קבצי הפרויקט
COPY . /opt/status-page-app

# Expose פורט 8000
EXPOSE 8000

# Entrypoint script (כדי להריץ migrate ו־collectstatic)
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
