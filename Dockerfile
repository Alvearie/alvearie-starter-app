# Watson  Health secured image
FROM us.icr.io/cdt-common-rns/base-images/ubi8

ARG maintainer=changeme
LABEL maintainer=${maintainer}
LABEL description="Sample node js application"

# Install Yum
RUN microdnf update &&\
  microdnf install yum &&\
  microdnf clean all

# Install version 12 of nodejs
RUN yum -y module reset nodejs && yum -y module enable nodejs:12 &&\
  yum -y install nodejs &&\
  yum -y clean all

# Install tools
RUN yum -y install wget &&\
  yum -y clean all

# Install the application
ADD package.json /app/package.json
RUN cd /app && npm install
ADD app.js /app/app.js
ENV WEB_PORT 8088
EXPOSE  8088

# Define command to run the application when the container starts
CMD ["node", "/app/app.js"]
