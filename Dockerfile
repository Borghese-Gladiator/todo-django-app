# Use the official Python image as the base image
FROM python:3.10

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python -

# Set working directory in the container
WORKDIR /app

# Copy the pyproject.toml and poetry.lock files to the container
COPY pyproject.toml poetry.lock /app/

# Install project dependencies using Poetry
RUN poetry config virtualenvs.create false \
    && poetry install --no-interaction --no-ansi

# Copy the Django project files to the container
COPY . /app/

# Expose the port the Django app runs on
EXPOSE 8000

# Run the Django development server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
