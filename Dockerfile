# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set the working directory
WORKDIR /app

# Install dependencies for Pillow (zlib, libjpeg)
RUN apt-get update && apt-get install -y \
    zlib1g-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy the current directory contents into the container at /app
COPY . /app/

# Set the environment variable to avoid writing .pyc files
ENV PYTHONUNBUFFERED 1

# Create a virtual environment and install the dependencies
RUN python -m venv /opt/venv
RUN /opt/venv/bin/pip install --upgrade pip
RUN /opt/venv/bin/pip install -r requirements.txt

# Set the path for the virtual environment
ENV PATH="/opt/venv/bin:$PATH"

# Expose the port the app will run on
EXPOSE 8080

# Define the command to run your app
CMD ["gunicorn", "main:app", "--bind", "0.0.0.0:8080"]
