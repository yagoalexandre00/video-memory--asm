xor ax, ax
mov ds, ax
mov es, ax

; set video mode
mov al, 0x13
int 0x10

; AX -> AH, AL 
; BX -> BH, BL
; CX -> CH, CL
; DX -> DH, DL
; SI -> Fonte
; DI -> Destino
; BP -> Ponteiro base
; SP -> Ponteiro do topo da pilha
; IP -> Ponteiro que aponta p prox instrucao

; Memoria de video: 0xA0000
xor di, di
mov ax, 0xa000
mov es, ax

mov cx, 0x140
mov ax, 0x0000

writePixelLoop:
mov [es:di], al
inc di
inc al
dec cx
cmp cx, 0
jne writePixelLoop
jmp $

times 510 - ($ - $$) db 0
dw 0xAA55