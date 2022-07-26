#FROM rocker/r-base:latest
FROM rocker/shiny:4.2.0

RUN apt-get update && apt-get install -y \
    libcurl4-gnutls-dev \
    libssl-dev \
    libxml2-dev

RUN install2.r shiny pkgload remotes devtools bio3d bs4Dash config data.table DT golem NGLVieweR RcppTOML readr rjson shinyalert shinyjs blogdown
#RUN R -e 'devtools::install_github("https://github.com/LBC-LNBio/KVshiny-docker")'

# copy the app directory into the image
COPY ./KVshiny/ /srv/shiny-server/KVshiny/

WORKDIR /srv/shiny-server/KVshiny

EXPOSE 3838

# run app
CMD ["Rscript", "/srv/shiny-server/KVshiny/app.R"]
