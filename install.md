There are many choices for linux user to install arm toolchain.
1. Prebuilt
You can download a prebuilt toolchain using the following commands:
```
$ wget http://www.cl.cam.ac.uk/freshers/raspberrypi/tutorials/os/downloads/arm-none-eabi.tar.bz2
--2012-08-16 18:26:29--  http://www.cl.cam.ac.uk/freshers/raspberrypi/tutorials/os/downloads/arm-none-eabi.tar.bz2
Resolving www.cl.cam.ac.uk (www.cl.cam.ac.uk)... 128.232.0.20, 2001:630:212:267::80:14
Connecting to www.cl.cam.ac.uk (www.cl.cam.ac.uk)|128.232.0.20|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 32108070 (31M) [application/x-bzip2]
Saving to: `arm-none-eabi.tar.bz2'

100%[======================================>] 32,108,070   668K/s   in 67s

2012-08-16 18:27:39 (467 KB/s) - `arm-none-eabi.tar.bz2' saved [32108070/32108070]

$ tar xjvf arm-none-eabi.tar.bz2
arm-2008q3/arm-none-eabi/
arm-2008q3/arm-none-eabi/lib/
arm-2008q3/arm-none-eabi/lib/libsupc++.a
arm-2008q3/arm-none-eabi/lib/libcs3arm.a
...
arm-2008q3/share/doc/arm-arm-none-eabi/info/gprof.info
arm-2008q3/share/doc/arm-arm-none-eabi/info/cppinternals.info
arm-2008q3/share/doc/arm-arm-none-eabi/LICENSE.txt

$ export PATH=$PATH:$HOME/arm-2008q3/bin
```
2. apt-get
Some Linux distributions including Ubunutu offer the ARM GNU Toolchain via apt-get. Run the following command:
```
$ sudo apt-get install gcc-arm-none-eabi
```
3. Build from source
Linux users may wish to build their own cross-compiler toolchain. This will require downloading and building the binutils and gcc packages from GNU. The binutils package contains the basic tools for building executables, including the assembler, the linker, a disassembler, and tools to manipulate object and binary files. These two packages are built separately but should be installed into the same destination directory. Make an area in your home directory to build your development kit.
```
$ cd
$ mkdir devkit
$ mkdir devkit-build
$ cd devkit-build
```
Download the binutils-X.XX.tar.bz2 package from GNU binutils into the devkit-build directory and uncompress it with the tar jxv binutils-X.XX.tar.bz2 command. Replace the X.XX with the current version number, such as 2.24 or 2.25 which have both been used successfully for this course. A note about make commands: if your development system has multiple processors or cores, you can use then to build and compile in parallel by adding -j #cores A note about the --program-prefix option: the trailing dash (-) is necessary to make sure the command names match helper templates used later in the course. Build the tools with these steps, replacing X.XX with your specific binutils version number:
```
$ cd $HOME/devkit-build
$ mkdir binutils-build
$ cd binutils-build
$ ../binutils-X.XX/configure --prefix=$HOME/devkit/ \
--program-prefix=arm-none-eabi- --target=arm-none-eabi --disable-nls
$ make
$ make check
$ make install
$ cd ..
```
The gcc package contains a C compiler. Download the gcc-X.XX.tar.bz2 package from GCC, The GNU Compiler Collection into the devkit-build directory and uncompress it with the tar jxv gcc-X.XX.tar.bz2 command. Replace the X.XX with the current version number, such as 4.8.2 or 5.1 which have both been used successfully for this course. Build the tools with these steps, replacing X.XX with your specific gcc version number, and add the -j #cores option, if desired
```
$ cd $HOME/devkit-build
$ mkdir gcc-build
$ cd gcc-build
$ ../gcc-X.XX/configure --prefix=$HOME/devkit/ \
--program-prefix=arm-none-eabi- --target=arm-none-eabi --disable-nls \
--without-headers --with-newlib --with-as=$HOME/devkit/bin/arm-none-eabi-as \
--with-ld=$HOME/devkit/bin/arm-none-eabi-ld --enable-languages=c
$ make all-gcc
$ make check all-gcc
$ make install-gcc
$ make all-target-libgcc
$ make check all-target-libgcc
$ make install-target-libgcc
$ cd ..
```
Now that you have a custom cross-compiler in your $HOME/devkit directory, you will need to add this directory to your shell's PATH environment variable to be able to run the tools later in the course. Each time you are ready to use the toolchain, run the following shell command:
```
$ export PATH=$PATH:$HOME/devkit/bin
```