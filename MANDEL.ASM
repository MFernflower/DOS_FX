
; Mandelbrot Set - fasm example program
; tweaked by mfernflower 
; requires FPU

        use16
	org 0x100
	mov	ax,13h
	int	10h
	push	0A000h
	pop	es
	xor	di,di
	xor	dx,dx
	finit
	fld	[y_top]
	fstp	[y]
   screen:
	xor	bx,bx
	fld	[x_left]
	fstp	[x]
   row:
	finit
	fldz
	fldz
	mov	cx,63
    iterate:
	fld	st0
	fmul	st0,st0
	fxch	st1
	fmul	st0,st2
	fadd	st0,st0
	fxch	st2
	fmul	st0,st0
	fsubp	st1,st0
	fxch	st1
	fadd	[y]
	fxch	st1
	fadd	[x]
	fld	st1
	fmul	st0,st0
	fld	st1
	fmul	st0,st0
	faddp	st1,st0
	fsqrt
	fistp	[i]
	cmp	[i],2
	ja	over
	loop	iterate
    over:
	mov	al,cl
	stosb
	fld	[x]
	fadd	[x_step]
	fstp	[x]
	inc	bx
	cmp	bx,320
	jb	row
	fld	[y]
	fsub	[y_step]
	fstp	[y]
	inc	dx
	cmp	dx,200
	jb	screen
        mov     dx,exit_text 
        mov     ah,0x09
        int     21h
	xor	ax,ax
	int	16h
        nop
	ret

x_left dd -2.2
y_top dd 1.25

x_step dd 0.009375
y_step dd 0.0125

x dd ?
y dd ?

i dw ?

exit_text db 'BEER AND TEQUILA FOREVER',0x21,0x24
