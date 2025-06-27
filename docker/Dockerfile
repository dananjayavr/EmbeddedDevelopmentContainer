## Base Docker Image
FROM bitnami/minideb:bookworm

## Set default platform values
ENV TARGETPLATFORM="linux/amd64"
ENV CONTAINER_PLATFORM=$TARGETPLATFORM

## Base setup and package installation
RUN set -ex \
  && apt update \
  && apt -y upgrade \
  && apt install -y \
     build-essential \
     gcc-arm-none-eabi \
     libnewlib-arm-none-eabi \
     coreutils \
     gcc \
     gdb \
     libc-dev \
     locales \
     nano \
     ruby=1:3.1 \
     zsh \
     gcovr \
     git-all \
     ncurses-bin \
     subversion \
     unzip \
     valgrind \
     ninja-build \
     udev \
     cmake \
     --no-install-recommends \
  && apt autoremove \
  && apt clean \
  && rm -rf /var/lib/apt/lists/*

## Locale configuration
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

RUN set -ex \
  && sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen \
  && locale-gen

## Copy assets
COPY MadScienceLabDocker/build/base/assets /assets/base
COPY MadScienceLabDocker/build/plugins/assets /assets/plugins  
COPY scripts/welcome /assets/standard/shell/welcome
COPY scripts/welcome /assets/arm-none-eabi-plugins/shell/welcome

## Ruby gems and Ceedling setup
RUN set -ex \
  && echo -e "---\ngem: --no-ri --no-rdoc\n...\n" > .gemrc \
  && gem install --force --local /assets/base/gems/*.gem \
  && gem install bundler \
  && bundle install --gemfile=/assets/base/gems/Gemfile \
  && rm .gemrc

## Platform-specific packages
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then set -ex \
   && apt update \
   && apt install -y gcc-multilib --no-install-recommends \
   && apt clean \
   && rm -rf /var/lib/apt/lists/* ; fi 

RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then set -ex \
   && dpkg -i /assets/plugins/dotnet/packages-microsoft-prod.deb \
   && apt update \
   && apt install -y dotnet-sdk-8.0 --no-install-recommends \
   && apt clean \
   && rm -rf /var/lib/apt/lists/* ; fi 

RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then set -ex \
  && dotnet tool install --global dotnet-reportgenerator-globaltool \
  && echo '[[ -d "$HOME/.dotnet/tools" ]] && export PATH="$PATH:$HOME/.dotnet/tools"' >> /root/.bashrc ; fi

## Create non-root user with matching host UID/GID
ARG HOST_UID=1000
ARG HOST_GID=1000

RUN groupadd -g ${HOST_GID} nonroot \
  && useradd -m -u ${HOST_UID} -g nonroot -s /bin/bash dev

## Set up dev user and clean up
RUN set -ex \
  && mkdir -p /home/dev \
  && chown dev:nonroot /home/dev \
  && chmod -R ug+rwx /home/dev \
  && cp /assets/arm-none-eabi-plugins/shell/welcome /home/dev/.welcome \
  && chown dev:nonroot /home/dev/.welcome \
  && rm -rf /assets

## Set user context
USER dev
ENV HOME=/home/dev

## Ensure .bashrc exists and sources welcome script
RUN touch /home/dev/.bashrc \
  && echo 'source ~/.welcome' >> /home/dev/.bashrc

## Default working directory and shell
WORKDIR /home/dev
CMD ["/bin/bash", "-i"]
