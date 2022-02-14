FROM rocker/r-base:latest

RUN apt-get update && apt-get install -y \
    libcurl4-gnutls-dev \
    libssl-dev \
    libxml2-dev

RUN install.r shiny pkgload remotes devtools
RUN R -e 'devtools::install_github("https://github.com/helder-ribeiro/KVserver", auth_token = "auth_token")'

# copy the app directory into the image
COPY ./KVserver/ /srv/shiny-server/KVserver

WORKDIR /srv/shiny-server/KVserver


RUN echo "local(options(shiny.port = 3838, shiny.host = '0.0.0.0'))" > /usr/lib/R/etc/Rprofile.site


EXPOSE 3838

# run app
CMD ["Rscript", "/srv/shiny-server/KVserver/app.R"]
