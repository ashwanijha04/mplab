assume cs:code,ds:data
data segment
        x db 10h
        y db 20h
data ends
code segment
start:  mov ax,data
        mov ds,ax
        mov al,x
        mov cl,y
        mov x,cl
        mov y,al
        mov ah,4ch
        int 21h
code ends
end start
