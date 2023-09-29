# Use an official Python runtime as the base image
FROM python:3.11-alpine

# Set the working directory in the container
WORKDIR /code

# Copy the requirements file to the working directory
COPY requirements.txt /code/

# Install psycopg2 dependencies
RUN apk update && \
    apk add --no-cache postgresql-dev gcc musl-dev

# Install the Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Django project code to the working directory
COPY . /code/

# Start Unicorn server
EXPOSE 8000

CMD ["gunicorn", "core.wsgi:application", "--bind", ":8000"]
