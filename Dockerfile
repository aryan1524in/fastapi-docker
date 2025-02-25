# Use Ubuntu as base image
FROM ubuntu:latest

# Install Python and dependencies
RUN apt-get update && apt-get install -y python3 python3-pip

# Set the working directory
WORKDIR D:\upes\6th Semester\DEVOPS\docker-fastapi

# Copy application files
COPY . .

# Install dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Expose the FastAPI server port
EXPOSE 8000

# Run the FastAPI server
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
