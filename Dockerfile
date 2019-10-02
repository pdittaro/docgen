FROM ubuntu

WORKDIR /app

# Install nodejs
RUN apt install nodejs npm

# Install libreoffice
RUN wget https://downloadarchive.documentfoundation.org/libreoffice/old/5.3.2.2/deb/x86_64/LibreOffice_5.3.2.2_Linux_x86-64_deb.tar.gz
RUN apt install libxinerama1 libfontconfig1 libdbus-glib-1-2 libcairo2 libcups2 libglu1-mesa libsm6

RUN tar -zxvf LibreOffice_5.3.2.2_Linux_x86-64_deb.tar.gz /opt
RUN cd LibreOffice_5.3.2.2_Linux_x86-64_deb/DEBS


# Install microsoft fonts
RUN apk --no-cache add msttcorefonts-installer fontconfig && \
    update-ms-fonts && \
    fc-cache -f

# Install app dependencies
COPY package.json package-lock.json ./

RUN npm ci

COPY . .

CMD [ "npm", "start" ]