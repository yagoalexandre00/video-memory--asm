mov al, 0x13
int 0x10

push 0xa000
pop es

xor ax, ax
xor bx, bx
xor cx, cx
xor dx, dx
xor di, di

; Contador: cl
; Numero de linhas: ch
; Quadrados X: dh
; Quadrados Y: dl
; Memoria de video: es:di
; Cor: ax

; 320 --> 16 quadros/linha --> 20px
; 192 --> 16 quadros/coluna --> 12px
; 2 bytes por vez

push ax

mainLoop:
mov [es:di], ax
inc di
inc di
inc cl
inc cl
cmp cl, 0x14 ; 14h = 20d 
je changeColorLoop
jmp mainLoop

changeColorLoop:
add ax, 0x0101
inc dl
cmp dl, 0x10 ; 10h = 16d
je endLine
xor cl, cl
jmp mainLoop

endLine:
inc ch
cmp ch, 0x0c ; Ch = 12d
je incSquareY
pop ax
push ax
xor cl, cl
xor dl, dl
jmp mainLoop

incSquareY:
pop ax
add ax, 0x1010 ; 16d16d
push ax
xor cx, cx
xor dl, dl
inc dh
cmp dh, 0x10
je endProgram
jmp mainLoop

endProgram:
jmp $

times 510 - ($ - $$) db 0
dw 0xAA55