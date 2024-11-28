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
cmp cl, 0x14
je changeColorLoop
jmp mainLoop
