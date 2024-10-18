;;;
;;; Space Invaders-ish game in 510 bytes (or less!) of qemu bootable real mode x86 asm
;;;
org 7C00h

;; CONSTANTS ==============================================
SCREEN_WIDTH        equ 320     ; Width in pixels
SCREEN_HEIGHT       equ 200     ; Height in pixels
VIDEO_MEMORY        equ 0A00h
TIMER               equ 046Ch   ; # of timer ticks since midnight

ALIEN_COLOR         equ 02h     ; Green
PLAYER_COLOR        equ 07h     ; Gray
BARRIER_COLOR       equ 27h     ; Red
PLAYER_SHOT_COLOR   equ 0Bh     ; Cyan
ALIEN_SHOT_COLOR    equ 0Eh     ; Yellow

;; SETUP ==================================================
;; Set up video mode - VGA mode 13h, 320x200, 256 colors, 8bpp, linear framebuffer at address B0000h
mov ax, 0013h
int 10h

;; Set up video memory
push VIDEO_MEMORY
pop es              ; ES -> A0000h

;; GAME LOOP ==============================================
game_loop:
    xor ax, ax          ; Clear screen to black first
    xor di, di
    mov cx, SCREEN_WIDTH*SCREEN_HEIGHT
    rep stosb           ; [ES:DI], al cx # of times

    ;; Draw aliens ----------------------------------------
    ;; Draw barriers --------------------------------------
    ;; Draw player ship -----------------------------------
    ;; Check if shot hit anything -------------------------
        ;; Hit player -------------------------------------
        ;; Hit barrier ------------------------------------
        ;; Hit alien --------------------------------------
    ;; Draw shots -----------------------------------------
    ;; Create alien shots ---------------------------------
    ;; Move aliens ----------------------------------------
    ;; Get player input -----------------------------------

    ;; Delay timer - 1 tick delay (1 tick = 18.2 / second)
    delay_timer:
        mov ax, [TIMER] ; # of timer ticks since midnight
        inc ax
        .wait:
            cmp [TIMER], ax
            jl .wait

jmp game_loop

;; END GAME LOOP ==========================================

;; End game & reset TODO:
game_over:
    cli
    hlt

;; Draw a sprite to the screen
draw_sprite:
    ret

;; Get X/Y screen position in DI
get_screen_position:
    ret

;; CODE SEGMENT DATA ======================================
sprite_bitmaps:
    db 10011001b        ; Alien 1 bitmap
    db 01011010b        
    db 00111100b
    db 01000010b

    db 10011001b        ; Alien 2 bitmap
    db 01011010b        
    db 10111101b
    db 00100100b

    db 00011000b        ; Player ship bitmap
    db 00111100b        
    db 00100100b
    db 01100110b

    db 00111100b        ; barrier bitmap
    db 01111110b        
    db 11100111b
    db 11100111b

;section boot_signature start=7DFEh
;; Boot signature
times 510-($-$$) db 0
dw 0AA55h

