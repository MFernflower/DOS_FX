                org 0x100
                push bp             ; Work around a stoopid bug in PC/XTs
                mov  ax, 0600h      ; Draw and clear the outer frame
                push ax             ; Save for later
                mov  cx, 050Ah      ; Upper screen coords: CH = ROW
                mov  dx, 0D46h      ; Lower bounds, DH = ROW
                mov  bh, 70h        ; Color is White Background, Black fore
                int  10h            ; Do It.

                pop  ax             ; Draw and clear the inner frame
                mov  cx, 060Ch      ; Upper screen coords: CH = ROW
                mov  dx, 0C44h      ; Lower bounds, DH = ROW
                mov  bh, 0xEF
                int  10h            ; Do It Again
                pop  bp             ; End of stoopid fix