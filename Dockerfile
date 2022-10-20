FROM docker:20.10.20-dind-alpine3.16

# Update and install jdk+maven
RUN apk update \
    add openjdk8 \
    add maven