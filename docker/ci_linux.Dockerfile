FROM ubuntu:22.04

LABEL maintainer="krzysztof.tyb@gmail.com" \
    description="Image to build AnimBoom Designer app on the CI" \
    version="1.0"

ARG QT_VERSION=6.5.1
ARG QT_PATH=/opt/Qt
ARG AQT_VERSION=3.1.6

ARG PACKAGES="sudo git build-essential ninja-build openssh-client ca-certificates \
    curl python3 locales patchelf mesa-common-dev libgl1-mesa-dev libfontconfig1 libxkbcommon0 libfreetype6 \
    libdbus-1-3 wget libgtest-dev libgmock-dev clang clang-format clang-tidy"

ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true \
    QT_PATH=${QT_PATH} \
    QT_GCC=${QT_PATH}/${QT_VERSION}/gcc_64 \
    PATH=${QT_PATH}/Tools/CMake/bin:${QT_PATH}/Tools/Ninja:${QT_PATH}/${QT_VERSION}/gcc_64/bin:$PATH

COPY installPackages.sh installQt_GCC.sh /tmp/

# Install all packages
RUN /tmp/installPackages.sh

# Install Qt
RUN /tmp/installQt_GCC.sh

# Rust
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUST_ARCH="x86_64-unknown-linux-gnu" \
    RUSTUP_VERSION="1.26.0" \
    RUST_VERSION="1.70.0"
RUN set -eux; \
    url="https://static.rust-lang.org/rustup/archive/$RUSTUP_VERSION/$RUST_ARCH/rustup-init"; \
    wget "$url"; \
    chmod +x rustup-init; \
    ./rustup-init -y --no-modify-path --profile minimal --default-toolchain $RUST_VERSION --default-host $RUST_ARCH; \
    rm rustup-init; \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME;

RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales
RUN groupadd -r user && useradd --create-home --gid user user && echo 'user ALL=NOPASSWD: ALL' > /etc/sudoers.d/user

USER user
WORKDIR /home/user
ENV HOME /home/user
