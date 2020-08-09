@ simple function, use it by bl
.global GetGpioAddress          @ make the label GetGpioAddress
GetGpioAddress:
    ldr r0,=0x20200000          @ loads the physical address of the GPIO region into r0.
    mov pc,lr                   @ lr contains the address of the code that we have to go 
                                @ back to when a method finishes. pc contains the address
                                @ of the next instruction to be run

.global SetGpioFunction
SetGpioFunction:
    cmp r0,#53                  @ GPIO pin number must between 0 and 53
    @ ls means that the command to be executed only if the last comparison 
    @ determined that the first number was less than or the same as the second. Unsigned.
    cmpls r1,#7                 @ Each pin has 8 functions
    @ hi means the command to be executed only if the last comparison determined
    @ that the first number was higher than the second. Unsigned.
    movhi pc,lr                 @ doesn't run only if r0<=53 and r1<=7
    @ Only general purpose registers and lr can be pushed
    push {lr}                   @ store lr onto the top of the stack because we will call GetGpioAddress
    mov r2,r0                   @ only save r0 because fortunately we know GetGpioAddress only changes r0
    bl GetGpioAddress
    @ r0 contains the GPIO address
    @ r1 contains the function code
    @ r2 contains the GPIO pin number
    functionLoop$:
        cmp r2,#9
        subhi r2,#10
        addhi r0,#4
        bhi functionLoop$
    @ r2 contains the remainder of dividing the pin numbers by 10
    @ r0 cotains the address in the GPIO controller of this pin's function settings
    add r2,r2,lsl #1            @ shift an argument before using it
    @ r2 = r2 * 3
    lsl r1,r2
    str r1,[r0]
    pop {pc}                    @ copies the values from the top of the stack into the regisers
    @ pc = stored lr

.global SetGpio
SetGpio:
pinNum .req r0
pinVal .req r1