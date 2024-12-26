# Tika Server Docker Image

This Docker image runs the Apache Tika Server inside a slimmed-down OpenJDK 11 environment. It includes the necessary packages for OCR functionality, such as Tesseract OCR for both English and German languages. The container is pre-configured to download and run the Tika Server on port 9998, with systemd service support to keep the server running indefinitely.

## Use Case
This server i am using with Ollama to parse documents and feed it to LLM.

## Features

- **Base Image**: OpenJDK 11 (slim variant)
- **Dependencies**: Tesseract OCR (with English and German language support)
- **Tika Version**: Apache Tika Server 3.0.0
- **Service Management**: Configured with a systemd service to ensure the Tika server runs as a persistent service
- **Port Exposed**: 9998, for accessing the Tika API

## Usage

### Build Image
- docker build -t tika-server .

### Pull Image
- docker pull defenderds/tika-server:tagname

### Next Steps
After pulling the image, the Tika server will be accessible on port 9998, allowing you to use it for document parsing, text extraction, and other functionalities provided by Apache Tika. Simply run the container and access it via:
- docker run -d -p 9998:9998 tika-server:latest
- http://<container_ip>:9998 or "Localhost" or "HostIP" or "127.0.0.1"

### Verify Installation
- netstat -lnvp | grep 9998
- netstat -lnvp | grep 0.0.0.0
- curl http://<container_ip>:9998 or "Localhost" or "HostIP" or "127.0.0.1"


