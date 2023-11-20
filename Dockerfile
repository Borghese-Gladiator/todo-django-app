# Use the official Python image as the base image
FROM python:3.10
LABEL org.opencontainers.image.source=https://github.com/Borghese-Gladiator/todo-django-app
LABEL org.opencontainers.image.description="Sample image description"
LABEL org.opencontainers.image.licenses=MIT

# Set environment variables
ENV POETRY_NO_INTERACTION 1
ENV POETRY_VIRTUALENVS_IN_PROJECT 1
ENV POETRY_VIRTUALENVS_CREATE 1
ENV POETRY_CACHE_DIR /tmp/poetry_cache
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install Poetry
RUN pip install poetry==1.6.1

# Set working directory in the container
WORKDIR /app

# Copy the pyproject.toml and poetry.lock files to the container
COPY pyproject.toml poetry.lock /app/

# Install project dependencies using Poetry
RUN poetry install --without dev --no-root && rm -rf $POETRY_CACHE_DIR

# Copy the Django project files to the container
COPY . /app/

# Install your project in virtual envrionment (useful for installing any custom script)
RUN poetry install --without dev

# Expose the port the Django app runs on
EXPOSE 8000

# Run the Django development server
ENTRYPOINT ["poetry", "run", "python", "manage.py", "runserver", "0.0.0.0:8000"]

### Collect static files
## RUN python manage.py collectstatic --noinput
### Run the Gunicorn production server
## CMD ["poetry", "run", "gunicorn", "todo-django-app.wsgi", "--bind", "0.0.0.0:8000"]
### Run the Waitress production server
## ENTRYPOINT ["waitress-serve", "--call", "'flaskr:create_app'"]
