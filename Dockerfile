FROM gradproj/base:latest AS builder
FROM alpine:3.15

LABEL description="Free5GC open source 5G Core Network" \
    version="Stage 3"

ENV F5GC_MODULE ausf
ARG DEBUG_TOOLS

# Install debug tools ~ 100MB (if DEBUG_TOOLS is set to true)
RUN if [ "$DEBUG_TOOLS" = "true" ] ; then apk add -U vim strace net-tools curl netcat-openbsd ; fi

# Set working dir
WORKDIR /AUSF
RUN mkdir -p config/ log/ config/TLS/

# Copy executable and default certs
COPY --from=builder /AUSF/${F5GC_MODULE} ./
COPY --from=builder /AUSF/config/TLS/${F5GC_MODULE}.pem ./config/TLS/
COPY --from=builder /AUSF/config/TLS/${F5GC_MODULE}.key ./config/TLS/

# Config files volume
VOLUME [ "/AUSF/config" ]

# Certificates (if not using default) volume
VOLUME [ "/AUSF/config/TLS" ]

# Exposed ports
EXPOSE 8000
