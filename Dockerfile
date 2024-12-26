# Use an OpenJDK base image
FROM openjdk:11-jre-slim

LABEL maintainer="Divyanshu Shubham <me@d1vyanshu.me>"

# Install required packages
RUN apt-get update \
    && apt-get install --no-install-recommends -y wget tesseract-ocr tesseract-ocr-deu tesseract-ocr-eng \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Define environment variable for Tika download location
ENV TIKA_SERVER_FOLDER="/opt/tika-server"
ENV TIKA_SERVER_FILE="tika-server.jar"

# Install required utilities
RUN apt-get update && apt-get install -y wget && apt-get clean

# Create a directory for Tika Server
RUN mkdir -p /opt/tika-server

# Download Tika Server JAR
RUN wget https://dlcdn.apache.org/tika/3.0.0/tika-server-standard-3.0.0.jar -O /opt/tika-server/tika-server.jar

# Expose the Tika Server port
EXPOSE 9998

# Create the systemd service file
RUN echo "[Unit]\n\
Description=Tika Server\n\
After=network.target\n\
\n\
[Service]\n\
User=root\n\
ExecStart=/usr/bin/java -Dserver.host=0.0.0.0 -jar $TIKA_SERVER_FOLDER/$TIKA_SERVER_FILE\n\
Restart=always\n\
\n\
[Install]\n\
WantedBy=multi-user.target" > /etc/systemd/system/tika-server.service

# Set the entrypoint to systemd
CMD ["java", "-jar", "/opt/tika-server/tika-server.jar", "-host", "0.0.0.0"]

