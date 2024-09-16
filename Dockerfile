FROM alpine:latest AS builder

# Install 7zip
RUN apk add --update --no-cache p7zip 

FROM alpine:latest

# Set metadata for the image
LABEL maintainer="Zmanda"
LABEL version="1.0"
LABEL description="A Docker image based on Alpine Linux for 7zip"

# Set the working directory
WORKDIR /app

# Create a group and user for the app
RUN addgroup -S zip && adduser -S -G zip zip && chown -R zip:zip /app 

# Copy the 7zip binary from the builder stage
COPY --from=builder /usr/bin/7z* /usr/bin/
COPY --from=builder /usr/lib/* /usr/lib/
COPY --from=builder /lib/* /lib/

USER zip

ENTRYPOINT ["/usr/bin/7z"]
CMD ["--help"]