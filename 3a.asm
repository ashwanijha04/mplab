assume cs:code,ds:data
disp macro mesg
        lea dx,mesg
        mov ah,9
        int 21h
        endm

data segment
        p1 db "sleep"
        l1 db (l1-p1)
        p2 db 10 dup(?)
        l2 db ?

        msg1 db 0ah,0dh,"Password match$"
        msg2 db 0ah,0dh,"Password does not match$"
        msg3 db 0ah,0dh,"Enter password : $"
        msg4 db 0ah,0dh,"Exceeded 3 attempts. Oops$"
data ends
code segment
start:
        mov ax,data
        mov ds,ax
        mov es,ax
        mov bl,0
rpt:
        call read
        call match
        inc bl
        cmp bl,3
        jb rpt
        disp msg4
        mov ah,4ch
        int 21h

        read proc near
                disp msg3
                mov bh,0
                lea si,p2
          again:
                mov ah,8
                int 21h
                cmp al,0dh
                je next
                mov [si],al
                inc si
                inc bh
                mov dl,'*'
                mov ah,02
                int 21h
                jmp again
           next:
                mov l2,bh
                ret
                read endp

       match proc near
                mov cl,l1
                cmp cl,l2
                je matchstr
                jmp mismatch
       matchstr:
                lea si,p1
                lea di,p2
                cld
                mov ah,00
                rep cmpsb
                jnz mismatch

                disp msg1
                mov ah,4ch
                int 21h
      mismatch:
                disp msg2
                ret

                match endp

code ends
end start
