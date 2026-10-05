# Small official Python base image
FROM python:3.11-slim

# pydub needs ffmpeg to read and cut audio files
RUN apt-get update \
    && apt-get install -y --no-install-recommends ffmpeg \
    && rm -rf /var/lib/apt/lists/*

# Work inside /app in the container
WORKDIR /app

# Install dependencies first so Docker can cache this layer
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application
COPY . .

# Document the port the app listens on
EXPOSE 5000

# Run the Flask app
CMD ["python", "app.py"]