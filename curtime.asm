assume cs:code
code segment
start:
        mov ah,2ch
        int 21h
        
        mov al,ch
        call hex_bcd
        call disp

        mov dl,':'

        mov ah,2
        int 21h
        mov al,cl
        call hex_bcd
        call disp

        mov ah,4ch
        int 21h

        disp proc
                push cx
                mov ah,00h
                mov cx,4

            ndd:shl ax,1
                loop ndd
                mov cx,04

            ndx:shr al,1
                loop ndx
                mov cx,04

                add ax,3030h
                push ax
                mov dl,ah
                mov ah,2
                int 21h
                pop ax
                mov ah,2
                mov dl,al
                int 21h
                pop cx
                ret
                disp endp

        hex_bcd proc
                push cx
                mov cl,al
                mov ch,00
                mov al,00
           next:add al,1
                daa
                loop next
                pop cx
                ret
                hex_bcd endp

code ends
end start
