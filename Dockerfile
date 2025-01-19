# Use Python as base image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
    gcc g++ gfortran build-essential python3-dev \
    libjpeg-dev zlib1g-dev libopencv-dev liblapack-dev libblas-dev && \
    apt-get clean

# Create virtual environment
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Upgrade pip and install utilities
RUN pip install --upgrade pip setuptools wheel

# Copy application code
COPY . .

# Debugging step: Log the requirements file
RUN cat requirements.txt

# Install Python dependencies
RUN pip install -r requirements.txt

# Expose port
EXPOSE 8080

# Start application
CMD ["python", "main.py"]
