FROM rocker/shiny:4.2.2

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-gnutls-dev \
    libssl-dev \
    libxml2-dev

# Install R depedencies
RUN install2.r shiny pkgload remotes devtools bio3d bs4Dash config data.table DT golem NGLVieweR RcppTOML readr rjson shinyjs blogdown colourpicker shinyfullscreen shinycssloaders shinyWidgets

# Copy the app directory into the image
COPY ./KVFinderWebPortal/ /srv/shiny-server/KVFinderWebPortal/

# Define work directory
WORKDIR /srv/shiny-server/KVFinderWebPortal

# Expose port 3838
EXPOSE 3838

# Run Shiny Web App
CMD ["Rscript", "/srv/shiny-server/KVFinderWebPortal/app.R"]
