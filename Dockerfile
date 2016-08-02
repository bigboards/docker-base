FROM __base-img__:14.04

MAINTAINER bigboards

USER root

# -- create the bigboards directory structure
RUN mkdir -p /opt/bb \
    && groupadd -r bigboards \
    && useradd bb -m -G bigboards \
    && chown bb /opt/bb \
    && echo 'bb:bigboards' | chpasswd \
    && cp /etc/sudoers /etc/sudoers.orig \
    && sed -i -e '/Defaults\s\+env_reset/a Defaults\texempt_group=bigboards' /etc/sudoers \
    && echo '%bigboards ALL=NOPASSWD:ALL' >> /etc/sudoers

# install curl
RUN apt-get update \
    && apt-get install -y curl apt-transport-https \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/archives/*.deb /var/cache/apt/archives/partials/*

# Define default command.
CMD ["bash"]