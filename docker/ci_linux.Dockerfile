FROM stateoftheartio/qt6:6.5-gcc-aqt

LABEL maintainer="krzysztof.tyb@gmail.com" \
    description="Image to build AnimBoom Designer app on the CI" \
    version="1.0"

USER root

RUN apt update; apt install -y wget libgl-dev libgtest-dev libgmock-dev;

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

USER user
WORKDIR /home/user
ENV HOME /home/user
