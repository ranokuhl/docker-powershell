FROM node:14.21.2
ENV LSB_RELEASE=20.04
WORKDIR /app
USER root
RUN apt-get update
RUN apt-get install -y wget apt-transport-https software-properties-common
RUN apt-get install wget
RUN wget -q https://packages.microsoft.com/config/ubuntu/$LSB_RELEASE/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN apt-get update
RUN apt-get install -y powershell
COPY package*.json ./
RUN yarn install
COPY . .
EXPOSE 3000
CMD ["node", "server.js"]
#RUN apt-get update
#RUN apt-get install -y wget apt-transport-https software-properties-common
#RUN apt-get install wget
#RUN wget -q https://packages.microsoft.com/config/ubuntu/$LSB_RELEASE/packages-microsoft-prod.deb
#RUN dpkg -i packages-microsoft-prod.deb
#RUN apt-get update
#RUN apt-get install -y powershell
#COPY script.ps1 /app/
#CMD pwsh script.ps1
