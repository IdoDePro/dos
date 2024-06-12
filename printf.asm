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