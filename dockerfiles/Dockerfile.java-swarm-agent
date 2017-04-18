# Image installs with latest Java 8 OpenJDK on Alpine Linux
FROM openjdk:8-jdk-alpine

USER root

# Update and upgrade apk then install curl, maven, git, and nodejs
RUN apk update && \
	apk upgrade && \
	apk --no-cache add curl && \
	apk --no-cache add maven && \
	apk --no-cache add git && \
	apk --no-cache add docker

# Create workspace directory for Jenkins
RUN mkdir /workspace && \
	chmod 777 /workspace

# Download the latest Jenkins swarm client with curl - version 3.3
# Browse all versions here: https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/
RUN curl -O https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/3.3/swarm-client-3.3.jar
