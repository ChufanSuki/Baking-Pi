.section .init      @ where to put our code
.globl _start       @ 
_start:
@ 0x20200000 is the base address of GPIO Function Select registers.
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

@ waiting
mov r2,#0x3F0000
wait1$:
sub r2,#1           @ sub reg,#val subtracts the number val from the value in reg
cmp r2,#0           @ cmp reg,#val compares the value in reg with the number val.
bne wait1$          @ bne means the command to be executed once if the last comparison 
                    @ determined that the numbers were not equal
str r1,[r0,#28]     @ Set GPIO 16 to high, causing the LED to turn off.
mov r2,#0x3F0000
b wait1$
@ @ The new line at the end of the block is intentional.
@ loop$:              @ name: labels the next line name.
@ b loop$             @ b label causes the next line to be executed to be label.
