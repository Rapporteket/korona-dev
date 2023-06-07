FROM rapporteket/dev:nightly

LABEL maintainer "Lena Ringstad Olsen <Lena.Ringstad.Olsen@helse-nord.no>"

ARG GH_PAT
ENV GITHUB_PAT=${GH_PAT}

# hadolint ignore=DL3008

# add registry dev config and R pkg dependencies
COPY --chown=rstudio:rstudio db.yml /home/rstudio/rap_config/
RUN cat /home/rstudio/rap_config/db.yml >> /home/rstudio/rap_config/dbConfig.yml \
    && rm /home/rstudio/rap_config/db.yml \
    && R -e "remotes::install_github(c('Rapporteket/rapbase', 'Rapporteket/rapFigurer', 'Rapporteket/raplog', 'Rapporteket/sship', 'Rapporteket/intensivberedskap'))" \
    && R -e "install.packages(c('digest', \
                                'DT', \
                                'enc', \
                                'forcats', \
                                'ggplot2', \
                                'kableExtra', \
                                'knitr', \
                                'lubridate', \
                                'plyr', \
                                'readr', \
                                'shiny', \
                                'shinyalert', \
                                'shinyjs', \
                                'tibble', \
                                'tidyr', \
                                'xtable', \
                                'zip', \
                                'zoo', \
                                'dplyr (>= 1.1.1)'))"
