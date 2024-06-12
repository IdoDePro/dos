IDEAL
MODEL small
STACK 100h
DATASEG
    str1 db "Start", 10, 13, "$"
    time db ?
CODESEG
include "printf.asm"

start:
    mov ax, @data ; data offset to ax
    mov ds, ax ; data segment offset to ds register
    
    mov dx, offset str1
    printstring dx
    
    xor bh, bh
timeloop:
    mov [time], dh

    mov ah, 2ch
    int 21h

    cmp dh, [time]
    je repeat
    
    add bh, 'a'
    printchar bh
    newline
    inc bh

repeat:
    jmp timeloop
    
exit:
    mov ax, 4c00h
    int 21h
END start