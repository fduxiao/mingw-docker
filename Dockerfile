ARG tag=latest
FROM archlinux/base:$tag
RUN useradd pkg -m
WORKDIR /home/pkg
ADD install.sh /bin
# base tools
RUN pacman -Sy --needed --noconfirm base-devel cmake git gcc-ada ppl \
    texlive-bin texlive-core
# headers
RUN sudo -u pkg gpg --recv 93BDB53CD4EBC740 && \
    sudo -u pkg gpg --recv 13FCEF89DD9E3C4F && \
    install.sh mingw-w64-headers && \
    install.sh mingw-w64-headers-bootstrap && \
    install.sh mingw-w64-binutils && \
    install.sh osl && \
    install.sh isl && \
    install.sh cloog && \
    install.sh mingw-w64-gcc-base && \
    install.sh mingw-w64-crt && \
    install.sh mingw-w64-winpthreads.git && \
    install.sh mingw-w64-gcc && \
    install.sh mingw-w64-pkg-config && \
    install.sh mingw-w64-cmake

