; This libary is based on code from MIKEOS - go check them out!
; Copyright (C) 2006 - 2020 MikeOS Developers - www.mikeos.sourceforge.net/LICENSE.TXT

; LIB FILE BEGINS DOWN BELOW: 

; os_print_string -- Displays text
; IN: SI = message location (zero-terminated string)
; OUT: Nothing (registers preserved)
os_print_string:
	pusha

	mov ah, 0Eh			; int 10h teletype function

.repeat:
	lodsb				; Get char from string
	cmp al, 0
	je .done			; If char is zero, end of string

	int 10h				; Otherwise, print it
	jmp .repeat			; And move on to next char

.done:
	popa
	ret


; ------------------------------------------------------------------
; os_clear_screen -- Clears the screen to background
; IN/OUT: Nothing (registers preserved)

os_clear_screen:
	pusha

	mov dx, 0			; Position cursor at top-left
	call os_move_cursor

	mov ah, 6			; Scroll full-screen
	mov al, 0			; Normal white on black
	mov bh, 7			;
	mov cx, 0			; Top-left
	mov dh, 24			; Bottom-right
	mov dl, 79
	int 10h

	popa
	ret


; ------------------------------------------------------------------
; os_move_cursor -- Moves cursor in text mode
; IN: DH, DL = row, column; OUT: Nothing (registers preserved)

os_move_cursor:
	pusha

	mov bh, 0
	mov ah, 2
	int 10h				; BIOS interrupt to move cursor

	popa
	ret


; ------------------------------------------------------------------
; os_get_cursor_pos -- Return position of text cursor
; OUT: DH, DL = row, column

os_get_cursor_pos:
	pusha

	mov bh, 0
	mov ah, 3
	int 10h				; BIOS interrupt to get cursor position

	mov [.tmp], dx
	popa
	mov dx, [.tmp]
	ret


	.tmp dw 0


; ------------------------------------------------------------------
; os_print_horiz_line -- Draw a horizontal line on the screen
; IN: AX = line type (1 for double (-), otherwise single (=))
; OUT: Nothing (registers preserved)

os_print_horiz_line:
	pusha

	mov cx, ax			; Store line type param
	mov al, 196			; Default is single-line code

	cmp cx, 1			; Was double-line specified in AX?
	jne .ready
	mov al, 205			; If so, here's the code

.ready:
	mov cx, 0			; Counter
	mov ah, 0Eh			; BIOS output char routine

.restart:
	int 10h
	inc cx
	cmp cx, 80			; Drawn 80 chars yet?
	je .done
	jmp .restart

.done:
	popa
	ret


; ------------------------------------------------------------------
; os_show_cursor -- Turns on cursor in text mode
; IN/OUT: Nothing

os_show_cursor:
	pusha

	mov ch, 6
	mov cl, 7
	mov ah, 1
	mov al, 3
	int 10h

	popa
	ret


; ------------------------------------------------------------------
; os_hide_cursor -- Turns off cursor in text mode
; IN/OUT: Nothing

os_hide_cursor:
	pusha

	mov ch, 32
	mov ah, 1
	mov al, 3			; Must be video mode for buggy BIOSes!
	int 10h

	popa
	ret


; ------------------------------------------------------------------
; os_draw_block -- Render block of specified colour
; IN: BL/DL/DH/SI/DI = colour/start X pos/start Y pos/width/finish Y pos

os_draw_block:
	pusha

.more:
	call os_move_cursor		; Move to block starting position

	mov ah, 09h			; Draw colour section
	mov bh, 0
	mov cx, si
	mov al, ' '
	int 10h

	inc dh				; Get ready for next line

	mov ax, 0
	mov al, dh			; Get current Y position into DL
	cmp ax, di			; Reached finishing point (DI)?
	jne .more			; If not, keep drawing

	popa
	ret
; ------------------------------------------------------------------
; os_draw_background -- Clear screen with white top and bottom bars
; containing text, and a coloured middle section.
; IN: AX/BX = top/bottom string locations, CX = colour

os_draw_background:
	pusha

	push ax				; Store params to pop out later
	push bx
	push cx

	mov dl, 0
	mov dh, 0
	call os_move_cursor

	mov ah, 09h			; Draw white bar at top
	mov bh, 0
	mov cx, 80
	mov bl, 01110000b
	mov al, ' '
	int 10h

	mov dh, 1
	mov dl, 0
	call os_move_cursor

	mov ah, 09h			; Draw colour section
	mov cx, 1840
	pop bx				; Get colour param (originally in CX)
	mov bh, 0
	mov al, ' '
	int 10h

	mov dh, 24
	mov dl, 0
	call os_move_cursor

	mov ah, 09h			; Draw white bar at bottom
	mov bh, 0
	mov cx, 80
	mov bl, 01110000b
	mov al, ' '
	int 10h

	mov dh, 24
	mov dl, 1
	call os_move_cursor
	pop bx				; Get bottom string param
	mov si, bx
	call os_print_string

	mov dh, 0
	mov dl, 1
	call os_move_cursor
	pop ax				; Get top string param
	mov si, ax
	call os_print_string

	mov dh, 1			; Ready for app text
	mov dl, 0
	call os_move_cursor

	popa
	ret


; ------------------------------------------------------------------
; os_print_newline -- Reset cursor to start of next line
; IN/OUT: Nothing (registers preserved)

os_print_newline:
	pusha

	mov ah, 0Eh			; BIOS output char code

	mov al, 13
	int 10h
	mov al, 10
	int 10h

	popa
	ret


; ------------------------------------------------------------------
; os_dump_registers -- Displays register contents in hex on the screen
; IN/OUT: AX/BX/CX/DX = registers to show

os_dump_registers:
	pusha

	call os_print_newline

	push di
	push si
	push dx
	push cx
	push bx

	mov si, .ax_string
	call os_print_string
	call os_print_4hex

	pop ax
	mov si, .bx_string
	call os_print_string
	call os_print_4hex

	pop ax
	mov si, .cx_string
	call os_print_string
	call os_print_4hex

	pop ax
	mov si, .dx_string
	call os_print_string
	call os_print_4hex

	pop ax
	mov si, .si_string
	call os_print_string
	call os_print_4hex

	pop ax
	mov si, .di_string
	call os_print_string
	call os_print_4hex

	call os_print_newline

	popa
	ret


	.ax_string		db 'AX:', 0
	.bx_string		db ' BX:', 0
	.cx_string		db ' CX:', 0
	.dx_string		db ' DX:', 0
	.si_string		db ' SI:', 0
	.di_string		db ' DI:', 0
	
; ------------------------------------------------------------------
; os_print_space -- Print a space to the screen
; IN/OUT: Nothing

os_print_space:
	pusha

	mov ah, 0Eh			; BIOS teletype function
	mov al, 20h			; Space is character 20h
	int 10h

	popa
	ret


; ------------------------------------------------------------------
; os_dump_string -- Dump string as hex bytes and printable characters
; IN: SI = points to string to dump

os_dump_string:
	pusha

	mov bx, si			; Save for final print

.line:
	mov di, si			; Save current pointer
	mov cx, 0			; Byte counter

.more_hex:
	lodsb
	cmp al, 0
	je .chr_print

	call os_print_2hex
	call os_print_space		; Single space most bytes
	inc cx

	cmp cx, 8
	jne .q_next_line

	call os_print_space		; Double space centre of line
	jmp .more_hex

.q_next_line:
	cmp cx, 16
	jne .more_hex

.chr_print:
	cmp cx, 16			; full line?
	jae .chr_cont
	mov ax, 16			; no, partial line, pad hex display with spaces
	sub ax, cx
	mov cx, ax
	mov dx, ax
	shl ax, 1
	add cx, ax
	cmp dx, 8			; less than 1/2 line?
	jbe .chr_c1
	inc cx				; yes, add space
.chr_c1:
	call os_print_space
	loop .chr_c1
.chr_cont:
	call os_print_space
	mov ah, 0Eh			; BIOS teletype function
	mov al, '|'                     ; Break between hex and character
	int 10h
	call os_print_space

	mov si, di			; Go back to beginning of this line
	mov cx, 0

.more_chr:
	lodsb
	cmp al, 0
	je .done

	cmp al, ' '
	jae .tst_high

	jmp short .not_printable

.tst_high:
	cmp al, '~'
	jbe .output

.not_printable:
	mov al, '.'

.output:
	mov ah, 0Eh
	int 10h

	inc cx
	cmp cx, 16
	jl .more_chr

	call os_print_newline		; Go to next line
	jmp .line

.done:
	call os_print_newline		; Go to next line

	popa
	ret


; ------------------------------------------------------------------
; os_print_digit -- Displays contents of AX as a single digit
; Works up to base 37, ie digits 0-Z
; IN: AX = "digit" to format and print

os_print_digit:
	pusha

	cmp ax, 9                       ; There is a break in ASCII table between 9 and A
	jle .digit_format

	add ax, 'A'-'9'-1		; Correct for the skipped punctuation

.digit_format:
	add ax, '0'			; 0 will display as '0', etc.	

	mov ah, 0Eh			; May modify other registers
	int 10h

	popa
	ret


; ------------------------------------------------------------------
; os_print_1hex -- Displays low nibble of AL in hex format
; IN: AL = number to format and print

os_print_1hex:
	pusha

	and ax, 0Fh			; Mask off data to display
	call os_print_digit

	popa
	ret


; ------------------------------------------------------------------
; os_print_2hex -- Displays AL in hex format
; IN: AL = number to format and print

os_print_2hex:
	pusha

	push ax				; Output high nibble
	shr ax, 4
	call os_print_1hex

	pop ax				; Output low nibble
	call os_print_1hex

	popa
	ret


; ------------------------------------------------------------------
; os_print_4hex -- Displays AX in hex format
; IN: AX = number to format and print

os_print_4hex:
	pusha
	push ax				; Output high byte
	mov al, ah
	call os_print_2hex
	pop ax				; Output low byte
	call os_print_2hex
	popa
	ret
	
	;signature db "videolibary",0x24
