# Create Docker image of fastapi api server using github actions

## Python Server

FastAPI is a modern, fast (high-performance) web framework for building APIs with Python 3.7+.

### `main.py`
```python
from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {"message": "Hello, FastAPI running in Docker!"}

```

### Python Requirements
`requirements.txt`
```text
fastapi
uvicorn
```

## Dockerfile for Image Building / Containerization of App

`Dockerfile`
```dockerfile
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

```


## GitHub Actions for Docker Image Creation

`.github/workflows/DockerBuild.yml`
```yaml
name: Docker Image Build & Push

on: push

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v2

      - name: Login to Docker Hub
        run: echo "${{ secrets.DOCKERTOKEN }}" | docker login -u "aryan1524" --password-stdin

      - name: Build and Push Docker Image
        run: |
          docker build -t aryan1524/fastapi-app:latest .
          docker push aryan1524/fastapi-app:latest

```

## Docker Token
To generate a token for a Docker registry, follow these steps based on your specific registry type:

### Docker Hub (Public Registry)
Docker Hub uses Personal Access Tokens (PATs) instead of passwords for authentication.

#### Steps:
1. Go to [Docker Hub](https://hub.docker.com/)
2. Sign in with your Docker account.
3. Click on your profile (top-right corner) → Account Settings.
4. Navigate to **Security → Access Tokens**.
5. Click **Generate Token**.
6. Give it a name, set the permissions, and click **Generate**.
7. Copy the token (it will not be shown again).


#### Use the Token for Login:
```sh
docker login -u aryan1524 
```
Then, enter the token when prompted.

<!-- ![Example Image](https://github.com/Anugrah2334/Fast_API/blob/main/Screenshot2.png) -->

#### Add the Repository secret:
Go to the Settings--> Secrets and Variables--> Actions--> Create New Repository Secrets contaning the Docker Hub username and Docker Hub password that contains the Token generated

<!-- ![Example Image](https://github.com/Anugrah2334/Fast_API/blob/main/Screenshot3.png) -->

#### Steps to push the .github folder and files in your GitHub Repository
1. Go to the Terminal and run the command to initialize git
```sh
git init
```
<!-- ![Example Image](https://github.com/Anugrah2334/Fast_API/blob/main/Screenshot4.png) -->

2. Add your remote repository
```sh
git remote add origin 
```
<!-- ![Example Image](https://github.com/Anugrah2334/Fast_API/blob/main/Screenshot5.png) -->

3. Add files for the commit
```sh
git add file-name
```
<!-- ![Example Image](https://github.com/Anugrah2334/Fast_API/blob/main/Screenshot6.png) -->

4. Commit the changes
```sh
git commit -m "Added files"
```

5. Push the files to github
```sh
git push -u origin main
```
<!-- ![Example Image](https://github.com/Anugrah2334/Fast_API/blob/main/Screenshot7.png) -->

#### Check that the image has been build or not?
1. Go to the Repository--> Actions Tab. You will see that 1 workflow will be running. Wait unitl it build successfully.

<!-- ![Example Image](https://github.com/Anugrah2334/Fast_API/blob/main/Screenshot8.png)

![Example Image](https://github.com/Anugrah2334/Fast_API/blob/main/Screenshot9.png) -->

2. Now check you Docker Hub account. The images will be created in your account.

<!-- ![Example Image](https://github.com/Anugrah2334/Fast_API/blob/main/Screenshot10.png) -->

---