# Get the current date and time as a version tag
$VERSION = Get-Date -Format 'yyyyMMddHHmm'

# Build the Docker image with the new tag
docker-compose build --build-arg IMAGE_TAG=$VERSION

# Optionally, run the containers after building
docker-compose up -d