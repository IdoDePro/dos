IDEAL
MODEL small
STACK 100h
DATASEG
    str1 db "Quadratic Equation Solver: Ax^2 + Bx + C$"
CODESEG

macro newline 
    mov dl, 10
    mov ah, 2h
    int 21h
endm newline

macro printchar char
    mov dl, char
    mov ah, 2h
    int 21h
endm printchar

macro printstring start, length
    push bx
    push cx
    push dx
    push ax

    mov cx, length
    cmp cx, 0h
    je exitprintstringmacro
    
    mov bx, start

    printloop:
        mov dl, [bx]
        mov ah, 2h
        int 21h
        inc bx
        loop printloop

    exitprintstringmacro:
        pop ax
        pop dx
        pop cx
        pop bx
    
endm printstring

start:
    mov ax, @data
    mov ds, ax
    
    printchar 61h ; ascii for "a"
    newline
    newline
    printchar 62h ; ascii for "b"
    newline
    printstring [str1], 10h
    
exit:
    mov ax, 4c00h
    int 21h
END start