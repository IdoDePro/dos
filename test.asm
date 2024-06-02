IDEAL
MODEL small
STACK 100h
DATASEG
    str1 db "This is the test:)", 10, 13, "$"
CODESEG

macro newline 
    mov dl, 10
    mov ah, 2h
    int 21h
endm newline

macro printchar char
    push ax
    mov al, char
    call printcharproc
    pop ax
endm printchar

macro printstring stringoffset
    push dx
    mov dx, stringoffset
    call printstringproc
    pop dx
endm printstring

proc printcharproc
    push ax
    push dx
    mov ah, 2h
    mov dl, al
    int 21h
    pop dx
    pop ax
    ret
endp printcharproc

proc printstringproc
    push ax
    push dx
    mov ah, 9h
    int 21h
    pop dx
    pop ax
    ret
endp printstringproc

start:
    mov ax, @data ; data offset to ax
    mov ds, ax ; data offset to ds register
    
    printchar 61h
    newline
    printchar 62h
    newline
    mov dx, offset str1
    printstring dx
    
exit:
    mov ax, 4c00h
    int 21h
END start