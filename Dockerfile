# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container at /app
COPY requirements.txt .

# Install any dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Make port 8080 available to the world outside this container
EXPOSE 8080

# Define environment variable (if needed, Render can override)
ENV PORT=8080

# Run the application
# Replace 'main:app' with your actual entry point if different.
# For example, if you have a file named `app.py` with a Flask app named `app`, use `app:app`.
# If OpenClaw is a CLI agent, you might run a different command.
CMD ["python", "-m", "openclaw", "--host", "0.0.0.0", "--port", "8080"]