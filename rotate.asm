.model small
.data
 
      one db 099h ; 1001 1001
      y db ?      ; count number of 1's

.code         
        mov ax,@data
        mov ds,ax

        mov bl,00 ; initially count is 0
        mov cl,08   ; number of digits in the input
        mov al,one  ; 

repeat:
        ror al,1    ; if carry is 1 inc bl
        jnc next    ; if carry is 0 no change in bl, jnc - jump on no carry
        inc bl      ; continue

next:
        dec cl      ; one digit is shifted out so decrement cl to 7
        jnz repeat  ; as long as cl is  not zero continue 
        mov y,bl    ; cl = 0 so move bl to y, loop terminates
        mov ah,4ch
        int 21h

        end
