Install GNU ARM toolchain
For Mac OS X, you can use the [YAGARTO](http://www.yagarto.org/) packages.
For Linux, see [instruction](install.md)
```
cd template
make
```
If any errors occur, please refer to the troubleshooting section. 
If not, you will have generated three files. `kernel.img` is the compiled image of your operating system. `kernel.list` is a listing of the assembly code you wrote, as it was actually generated. This is useful to check that things were generated correctly in future. The `kernel.map` file contains a map of where all the labels ended up, which can be useful for chasing around values.
To install your operating system, first of all get a Raspberry PI SD card which has an operating system installed already. If you browse the files in the SD card, you should see one called `kernel.img`. Rename this file to something else, such as `kernel_linux.img`. Then, copy the file `kernel.img` that make generated onto the SD Card. You've just replaced the existing operating system with your own. To switch back, simply delete your `kernel.img` file, and rename the other one back to `kernel.img`. I find it is always helpful to keep a backup of you original Raspberry Pi operating system, in case you need it again.
Put the SD card into a Raspberry Pi and turn it on.