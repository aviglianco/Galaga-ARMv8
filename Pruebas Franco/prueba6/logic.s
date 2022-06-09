.ifndef logic_s
.equ logic_s,0
.include "data.s"

update_playership:
	ldr x10,=ship_player
	ldur w0,[x10]
	ldur w1,[x10,4]
	add w0,w0,1
	stur w0,[x10]
	stur w1,[x10,4]
	br lr
delay:
        ldr x9, delay_time
    delay_loop:
        subs x9, x9, 1
        b.ne delay_loop
        br lr

frame_update:
        mov x9, SCREEN_WIDTH
        mov x10, SCREEN_HEIGH
    frame_loop:
		madd x12,x10,x25,x9 
        ldr w11, [x26,x12,lsl 2] // copio el color de cada pixel del frame secundario
        str w11, [x27,x12,lsl 2] // lo pego en el principal
		sub x9,x9,1
		cbnz x9, frame_loop
		//si x9 es 0, entonces vuelvo x9 a la derecha de la linea	
		mov x9, SCREEN_WIDTH
		sub x10,x10,1
		cbnz x10,frame_loop
        br lr // return
.endif
