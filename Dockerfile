FROM rocker/shiny:3.5.1

RUN apt-get update && apt-get install libcurl4-openssl-dev libv8-3.14-dev -y &&\
  mkdir -p /var/lib/shiny-server/bookmarks/shiny


# Download and install library
RUN R -e "install.packages(c('shinydashboard', 'shinyjs', 'V8', 'dplyr', 'knitr', 'readr', 'tidyr', 'shinydashboard', 'ggplot2', 'dplyr', 'rmarkdown'))"

# copy the app to the image COPY shinyapps /srv/shiny-server/
# make all app files readable (solves issue when dev in Windows, but building in Ubuntu)
RUN chmod -R 755 /srv/shiny-server/

EXPOSE 3838

# Copy the app to the image
COPY app /srv/shiny-server/

# Make all app files readable
RUN chmod -R +r /srv/shiny-server/


CMD ["/usr/bin/shiny-server.sh"]

