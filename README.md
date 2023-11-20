# Django Template Project
This project is to test out my local Kubernetes setup and refresh some Django.

# Setup
## Caveats
- on Windows, you can't run the production server `gunicorn` because it has Linux dependencies

# Notes
## Scaffolding
- initialize project with Poetry
  ```
  mkdir todo-django-app
  cd todo-django-app
  poetry init
  poetry add django
  poetry add gunicorn  # production server (does not come with Django)
  ```
- create Django app called todo-django-app (replace `<real_name>`)
  - linux
    ```bash
    # generate app
    poetry run django-admin startproject temp
    # move content to root dir
    mv temp/* temp2
    mv temp2 <real_name>
    rm -r temp
    ```
  - windows (batch)
    ```batch
    # generate app
    poetry run django-admin startproject temp
    # move content to root dir
    move temp\* temp2 /Y
    ren temp2 <real_name>
    rmdir /S /Q temp
    ```
  - windows (powershell)
    ```powershell
    # generate app
    poetry run django-admin startproject temp
    # move content to root dir
    Move-Item -Path ".\temp\*" -Destination ".\temp2" -Force
    Rename-Item -Path ".\temp2" -NewName <real_name>
    Remove-Item -Path ".\temp" -Force -Recurse
    ```
- create Dockerfile
  - check you use the same python version
  - add `LABEL` instructions
- create Models, Views, Controllers
  - linux
    ```bash
    mkdir -p todos/migrations
    mkdir -p todos/templates/todos
    touch todos/__init__.py
    touch todos/admin.py
    touch todos/apps.py
    touch todos/forms.py
    touch todos/models.py
    touch todos/tests.py
    touch todos/urls.py
    touch todos/views.py

    touch todos/templates/todos/todo_list.html
    touch todos/templates/todos/todo_detail.html
    touch todos/templates/todos/todo_form.html
    touch todos/templates/todos/todo_confirm_delete.html
    ```
  - windows (batch)
  ```batch
  mkdir todos\migrations
  mkdir todos\templates\todos
  type nul > todos\__init__.py
  type nul > todos\admin.py
  type nul > todos\apps.py
  type nul > todos\forms.py
  type nul > todos\models.py
  type nul > todos\tests.py
  type nul > todos\urls.py
  type nul > todos\views.py

  type nul > todos\templates\todos\todo_list.html
  type nul > todos\templates\todos\todo_detail.html
  type nul > todos\templates\todos\todo_form.html
  type nul > todos\templates\todos\todo_confirm_delete.html

  ```
  - windows (powershell)
  ```powershell
  New-Item -ItemType Directory -Path todos\migrations
  New-Item -ItemType Directory -Path todos\templates\todos
  New-Item -ItemType File -Path todos\__init__.py
  New-Item -ItemType File -Path todos\admin.py
  New-Item -ItemType File -Path todos\apps.py
  New-Item -ItemType File -Path todos\forms.py
  New-Item -ItemType File -Path todos\models.py
  New-Item -ItemType File -Path todos\tests.py
  New-Item -ItemType File -Path todos\urls.py
  New-Item -ItemType File -Path todos\views.py

  New-Item -ItemType File -Path todos\templates\todos\todo_list.html
  New-Item -ItemType File -Path todos\templates\todos\todo_detail.html
  New-Item -ItemType File -Path todos\templates\todos\todo_form.html
  New-Item -ItemType File -Path todos\templates\todos\todo_confirm_delete.html
  ```
- create GitHub Action to build image and push to DockerHub
  - create DockerHub repository to store images
  - create DockerHub access token
  - go to GitHub repository | Settings | Secrets and variables | Actions | click "New repository secret"
    - `DOCKERHUB_USERNAME: <value>`
    - `DOCKERHUB_TOKEN: <value>`
  - linux
    ```
    mkdir -p .github/workflows
    touch .github/workflows/build_and_push.yaml
    ```
  - windows (batch)
    ```
    mkdir .github\workflows
    type nul > .github\workflows\build_and_push.yaml
    ```
  - windows (powershell)
    ```
    New-Item -ItemType Directory -Path .github\workflows
    New-Item -ItemType File -Path .github\workflows\build_and_push.yaml
    ```
- create Kubernetes manifests in kubernetes/ using Docker Image name
  - linux
    ```
    mkdir kubernetes
    touch kubernetes\build_and_push.yaml
    touch kubernetes\ingress.yaml
    touch kubernetes\service.yaml
    ```
  - windows (batch)
    ```
    mkdir kubernetes
    type nul > kubernetes\build_and_push.yaml
    type nul > kubernetes\ingress.yaml
    type nul > kubernetes\service.yaml
    ```
  - windows (powershell)
    ```
    New-Item -ItemType Directory -Path kubernetes
    New-Item -ItemType File -Path kubernetes\deployment.yaml
    New-Item -ItemType File -Path kubernetes\ingress.yaml
    New-Item -ItemType File -Path kubernetes\service.yaml
    ```

## Deployment
- deploy to Railway
- deploy via Harness to Kubernetes on home server

## References
- https://medium.com/@albertazzir/blazing-fast-python-docker-builds-with-poetry-a78a66f5aed0