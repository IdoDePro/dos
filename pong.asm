    stack segment para stack
    db 64 dup(' ')
    stack ends

    data segment para 'data'

    time_aux db 0 ; variable used when checking if time has changed
    
    ball_x dw 10h ; x coordinate of ball
    ball_y dw 10h ; y coordinate of ball
    ball_size dw 04h ; size of the ball
    ball_velocity_x dw 05h ; x velocity in horizontal axis
    ball_velocity_y dw 02h ; y velocity in vertical axis

    data ends

    code segment para 'code'

        clear_screen macro

            mov ah, 00h ; set configuration to video mode
            mov al, 13h ; coose the video mode
            int 10h ; execute configuration

            mov ah, 0Bh ; set configuration to
            mov bh, 00h ; background color
            mov bl, 00h ; set background color to black
            int 10h ; execute configuration
        
        endm
    
        main proc far
            
            assume cs:code, ds:data, ss:stack ; assume code, data, stack segments to appropiate registers
            push ds ; push data segment to stack
            sub ax,ax ; clean ax register
            push ax ; push ax to stack
            mov ax, data ; move address of data into ax
            mov ds, ax ; move into data segment register ax
            pop ax ; release top item of stack to ax register
            pop ax ; release top item of stack to ax register

            clear_screen

            check_time:
                mov ah, 2Ch ; get system time
                int 21h ; ch = hour, cl = minute, dh = second, dl = 1/100 second

                cmp dl, time_aux ; is prev time equal to current time?
                je check_time ; if time hasn't changed check time again

                mov time_aux, dl ; update the aux time variable
                call draw_ball ; if time changed draw the ball

                mov ax, ball_velocity_x
                add ball_x, ax
                mov ax, ball_velocity_y
                add ball_y, ax

                clear_screen
                
                jmp check_time ; after all the actions restart the game loop

            ret
        main endp

        draw_ball proc near

            mov cx, ball_x ; initial pixel to draw (x)
            mov dx, ball_y ; initial pixel to draw (y)

            draw_ball_horizontal:
                mov ah, 0Ch ; set the configuration to draw a pixel
                mov al, 03h ; choose white as pixel color
                mov bh, 00h ; set page number to 0
                int 10h ; execute configuration

                inc cx ; same as ball_x = ball_x + 1 increment x value
                mov ax, cx ; (cx - ball_x > ball_size) ? go to next line : draw next column
                sub ax, ball_x
                cmp ax, ball_size

                jng draw_ball_horizontal
                mov cx, ball_X ; reset cx to initial x value

                inc dx ; advance to next line
                mov ax, dx ; (dx - ball_y > ball_size) ? go to next line : draw next line
                sub ax, ball_y
                cmp ax, ball_size

                jng draw_ball_horizontal

            ret

        draw_ball endp
    
    code ends
    ;code ends
    end
