# Use Python as base image
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y \
    gcc g++ gfortran build-essential python3-dev \
    libjpeg-dev zlib1g-dev libopencv-dev && \
    apt-get clean

# Create virtual environment
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Upgrade pip and set compiler flags
RUN pip install --upgrade pip
ENV CFLAGS="-Wno-stringop-overflow"
ENV CXXFLAGS="-Wno-stringop-overflow"

# Copy application code
COPY . .

# Print requirements.txt for debugging
RUN cat requirements.txt

# Install Python dependencies
RUN pip install -r requirements.txt

# Expose port
EXPOSE 8080

# Start application
CMD ["python", "main.py"]
