# Use Python 3.10 as the base image for TensorFlow compatibility
FROM python:3.10-slim

# Set the working directory
WORKDIR /app

# Install system dependencies required for Python packages
RUN apt-get update && \
    apt-get install -y \
    gcc g++ gfortran build-essential python3-dev \
    libjpeg-dev zlib1g-dev libopencv-dev liblapack-dev libblas-dev && \
    apt-get clean

# Create and activate a virtual environment
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Upgrade pip, setuptools, and wheel to the latest versions
RUN pip install --upgrade pip setuptools wheel

# Copy the application code and requirements file
COPY . .

# Print the contents of requirements.txt for debugging
RUN cat requirements.txt

# Install Python dependencies and log potential errors
RUN pip install -r requirements.txt || (echo "Error during pip install" && exit 1)

# Expose the port for the application
EXPOSE 8080

# Command to start the application
CMD ["python", "main.py"]
