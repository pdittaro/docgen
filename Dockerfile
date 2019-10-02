FROM alpine:3.10

WORKDIR /app

# Install dependencies
RUN apk update && \
    apk upgrade && \
    apk add bash nodejs npm libreoffice-writer openjdk8-jre

# Install microsoft fonts
RUN apk --no-cache add msttcorefonts-installer fontconfig && \
    update-ms-fonts && \
    fc-cache -f

# Bind carbone python
COPY python bindPython.sh ./
RUN chmod a+rx bindPython.sh && ./bindPython.sh

# Install app dependencies
COPY package.json package-lock.json ./

RUN npm ci

COPY . .
RUN chmod a+x docker-entrypoint.sh

ENTRYPOINT [ "/app/docker-entrypoint.sh" ]