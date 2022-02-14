#FROM rocker/r-base:latest
FROM rocker/shiny:4.1.1

RUN apt-get update && apt-get install -y \
    libcurl4-gnutls-dev \
    libssl-dev \
    libxml2-dev

RUN install2.r shiny pkgload remotes devtools
RUN R -e 'devtools::install_github("https://github.com/LBC-LNBio/KVshiny", auth_token = "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")'

# copy the app directory into the image
COPY ../KVshiny-docker/ /srv/shiny-server/KVshiny/

WORKDIR /srv/shiny-server/KVserver

EXPOSE 3838

# run app
CMD ["Rscript", "/srv/shiny-server/KVshiny/app.R"]
