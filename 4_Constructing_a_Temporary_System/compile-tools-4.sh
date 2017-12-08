#!/bin/bash
export MAKEFLAGS='-j 8'
cd $LFS/sources

# Diffutils
tar -xf diffutils-3.6.tar.xz
pushd diffutils-3.6

time {
	./configure --prefix=/tools \
	&& make \
	&& make install
}

popd
rm -rf diffutils-3.6

# File
tar -xf file-5.31.tar.gz
pushd file-5.31

time {
	./configure --prefix=/tools \
	&& make \
	&& make install
}

popd
rm -rf file-5.31

# Findutils
tar -xf findutils-4.6.0.tar.gz
pushd findutils-4.6.0

time {
	./configure --prefix=/tools \
	&& make \
	&& make install
}

popd
rm -rf findutils-4.6.0

# Gawk
tar -xf gawk-4.1.4.tar.xz
pushd gawk-4.1.4

time {
	./configure --prefix=/tools \
	&& make \
	&& make install
}

popd
rm -rf gawk-4.1.4

# Gettext
tar -xf gettext-0.19.8.1.tar.xz
pushd gettext-0.19.8.1

time {
	cd gettext-tools; \
	EMACS="no" ./configure --prefix=/tools --disable-shared; \
	make -C gnulib-lib \
	&& make -C intl pluralx.c \
	&& make -C src msgfmt \
	&& make -C src msgmerge \
	&& make -C src xgettext
}
cp -v src/{msgfmt,msgmerge,xgettext} /tools/bin

popd
rm -rf gettext-0.19.8.1

# Grep
tar -xf grep-3.1.tar.xz
pushd grep-3.1

time {
	./configure --prefix=/tools \
	&& make \
	&& make install
}

popd
rm -rf grep-3.1

# Gzip
tar -xf gzip-1.8.tar.xz
pushd gzip-1.8

time {
	./configure --prefix=/tools \
	&& make \
	&& make install
}

popd
rm -rf gzip-1.8

# M4
tar -xf m4-1.4.18.tar.xz
pushd m4-1.4.18

time {
	./configure --prefix=/tools \
	&& make \
	&& make install
}

popd
rm -rf m4-1.4.18

# Make
tar -xf make-4.2.1.tar.bz2
pushd make-4.2.1

time {
	./configure --prefix=/tools --without-guile \
	&& make \
	&& make install
}

popd
rm -rf make-4.2.1

# Patch
tar -xf patch-2.7.5.tar.xz
pushd patch-2.7.5

time {
	./configure --prefix=/tools \
	&& make \
	&& make install
}

popd
rm -rf patch-2.7.5

# Perl
tar -xf perl-5.26.0.tar.bz2
pushd perl-5.26.0

sed -e '9751 a#ifndef PERL_IN_XSUB_RE' \
    -e '9808 a#endif' \
    -i regexec.c

time {
	sh Configure -des -Dprefix=/tools -Dlibs=-lm \
	&& make \
	&& cp -v perl cpan/podlators/scripts/pod2man /tools/bin \
	&& mkdir -pv /tools/lib/perl5/5.26.0 \
	&& cp -Rv lib/* /tools/lib/perl5/5.26.0
}

popd
rm -rf perl-5.26.0

# Sed
tar -xf sed-4.4.tar.xz
pushd sed-4.4

time {
	./configure --prefix=/tools \
	&& make \
	&& make install
}

popd
rm -rf sed-4.4

# Tar
tar -xf tar-1.29.tar.xz
pushd tar-1.29

time {
	./configure --prefix=/tools \
	&& make \
	&& make install
}

popd
rm -rf tar-1.29

# Texinfo
tar -xf texinfo-6.4.tar.xz
pushd texinfo-6.4

time {
	./configure --prefix=/tools \
	&& make \
	&& make install
}

popd
rm -rf texinfo-6.4

# Util-linux
tar -xf util-linux-2.30.1.tar.xz
pushd util-linux-2.30.1

time {
	./configure --prefix=/tools \
	--without-python \
	--disable-makeinstall-chown \
	--without-systemdsystemunitdir \
	--without-ncurses \
	PKG_CONFIG="" \
	&& make \
	&& make install
}

popd
rm -rf util-linux-2.30.1

# Xz
tar -xf xz-5.2.3.tar.xz
pushd xz-5.2.3

time {
	./configure --prefix=/tools \
	&& make \
	&& make install
}

popd
rm -rf xz-5.2.3

# Done!!!

# Stripping (optional, but nice)
strip --strip-debug /tools/lib/*
/usr/bin/strip --strip-unneeded /tools/{,s}bin/*
#rm -rf /tools/{,share}/{info,man,doc}
