# Use an official Python runtime as the base image
FROM python:3.11-alpine



# Set the working directory in the container
WORKDIR /code

# Copy the requirements file to the working directory
COPY requirements.txt /code/

# Install psycopg2 dependencies
RUN apt-get update && \
    apt-get install -y libpq-dev && \
    rm -rf /var/lib/apt/lists/*

# Install the Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Django project code to the working directory
COPY . /code/

# Expose the Django app port (optional)
EXPOSE 8000

VOLUME .:/code

# Start Unicorn server
CMD ["gunicorn", "core.wsgi:application","--bind", "0.0.0.0:8000"]
