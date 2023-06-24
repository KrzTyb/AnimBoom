FROM stateoftheartio/qt6:6.5-gcc-aqt

LABEL maintainer="krzysztof.tyb@gmail.com" \
    description="Image to build AnimBoom Designer app on the CI" \
    version="1.0"

RUN sh -c 'sudo apt update; sudo apt install -y libgl-dev libgtest-dev libgmock-dev;'
