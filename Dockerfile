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
    sudo -u pkg gpg --recv A328C3A2C3C45C06
RUN install.sh mingw-w64-headers && \
    install.sh mingw-w64-headers-bootstrap && \
    install.sh mingw-w64-binutils && \
    install.sh osl && \
    install.sh isl && \
    install.sh cloog && \
    install.sh mingw-w64-gcc-base && \
    install.sh mingw-w64-crt && \
    pacman -Rdd --noconfirm mingw-w64-headers-bootstrap && \
    install.sh mingw-w64-winpthreads
RUN sudo -u pkg git clone https://aur.archlinux.org/mingw-w64-gcc && \
    cd mingw-w64-gcc && sudo -u pkg makepkg && \
    pacman -Rdd --noconfirm mingw-w64-gcc-base && \
    pacman -U --noconfirm mingw-w64-gcc-*.tar.xz && \
    cd .. && rm -rf mingw-w64-gcc
RUN install.sh mingw-w64-pkg-config && \
    install.sh mingw-w64-cmake
WORKDIR /
