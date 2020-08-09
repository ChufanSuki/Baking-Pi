.section .init      @ where to put our code
.globl _start       @ 
_start:
@ 0x20200000 is the address of GPIO Function Select 0 register
ldr r0,=0x20200000  @ ldr reg,=val puts the number val into the register named reg
@ r1=0x00020000, GPIO Function Select 1 register=r1
@ Enable output to the 16th PGIO pin
move r1,#1          @ move reg,#val puts the number val into the register named reg
lsl r1,#18          @ lsl reg,#val shifts the binary representation of the number
                    @ in reg by val places to the left
str r1,[r0,#4]      @ str reg,[dest,#val] stores the number in reg at the address 
                    @ given by dest+val
@ Turn pin 16 off to have the LED turn on
mov r1,#1           @ r1=1
lsl r1,#16          
str r1,[r0,#40]     @ GPIO Pin Output Clear 00x 7E20 0028
@ The new line at the end of the block is intentional.
loop$:              @ name: labels the next line name.
b loop$             @ b label causes the next line to be executed to be label.
