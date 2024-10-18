;;;
;;; Space Invaders-ish game in 510 bytes (or less!) of qemu bootable real mode x86 asm
;;;
org 7C00h

;; SETUP ===============================
;; Set up video mode - VGA mode 13h, 320x200, 256 colors, 8bpp, linear framebuffer at address B0000h
mov ax, 0013h
int 10h

;; Set up video memory
push 0A000h
pop es              ; ES -> A0000h

;; GAME LOOP ==========================
game_loop:
    mov al, 04h         ; VGA RED
    mov cx, 320*200
    xor di, di
    rep stosb           ; [ES:DI], al cx # of times

    mov di, 320*100 + 160
    test_loop:
    mov ax, 01h ; al = 1 - VGA blue

    ;; Delay timer - 1 tick delay (1 tick = 18.2 / second)
    delay_timer:
        mov ax, [046Ch] ; # of timer ticks since midnight
        inc ax
        .wait:
            cmp [046h], ax
            jl .wait
    stosb
    jmp test_loop
jmp game_loop

;; End game & reset TODO:
game_over:
    cli
    hlt

times 510-($-$$) db 0

;section boot_signature start=7DFEh
;; Boot signature
dw 0AA55h

