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
RUN install.sh mingw-w64-headers
RUN install.sh mingw-w64-headers-bootstrap
RUN install.sh mingw-w64-binutils
RUN install.sh osl
RUN install.sh isl
RUN install.sh cloog
RUN install.sh mingw-w64-gcc-base
RUN install.sh mingw-w64-crt
RUN pacman -Rdd --noconfirm mingw-w64-headers-bootstrap
RUN install.sh mingw-w64-winpthreads
RUN sudo -u pkg git clone https://aur.archlinux.org/mingw-w64-gcc
RUN cd mingw-w64-gcc && sudo -u pkg makepkg
RUN pacman -Rdd --noconfirm mingw-w64-gcc-base
RUN pacman -U mingw-w64-gcc-*.tar.xz
RUN cd .. && rm -rf mingw-w64-gcc
RUN install.sh mingw-w64-pkg-config
RUN install.sh mingw-w64-cmake
WORKDIR /
