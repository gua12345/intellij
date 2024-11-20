#
# InteiilJ IDEA + OpenJDK 8
#
# 使用 ARM64 的 Debian Slim 基础镜像
FROM debian:bullseye-slim

# Get the python script required for "add-apt-repository"
# Configure the openjdk repo
RUN apt-get update \ 
	&& apt-get install -y software-properties-common \
	&& add-apt-repository ppa:openjdk-r/ppa

# Install OpenJDK 8, X11 libraries, and wget
RUN apt-get update \
    && apt-get install -y \
        curl \
        libxext-dev libxrender-dev libxtst-dev \
        openjdk-8-jdk \
        wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

# wget IntelliJ IDEA 
ENV INTELLIJ_URL=https://download.jetbrains.com/idea/ideaIC-2017.2-no-jdk.tar.gz
RUN wget --progress=bar:force $INTELLIJ_URL -O /tmp/intellij.tar.gz \
	&& mkdir /opt/intellij \
	&& tar -xzf /tmp/intellij.tar.gz -C /opt/intellij --strip-components=1 \
	&& rm -rf /tmp/*

CMD ["/opt/intellij/bin/idea.sh"]
