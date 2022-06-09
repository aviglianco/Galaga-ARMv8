.ifndef graphics_s
.equ graphics_s,0
.include "data.s"

/* 
    Este archivo contiene todas las funciones relacionadas con
    los gráficos que se realizan en el programa.
*/

/*
    Realiza los cálculos necesarios para generar un "puntero" al pixel deseado.

    Parámetros:
        x0 = Posición deseada en x
        x1 = Posición deseada en y
    Retorno:
        x0 = Puntero al pixel en las coordenadas deseadas
*/
pixel:
	madd x0, x1, x25, x0 //fila.|Columnas| + columna
	add x0,x26,x0, lsl #2 //baseArray + (fila.|Columnas| + columna)*4
	br lr //return

/* 
    Dibuja un rectángulo en pantalla.

    Parámetros:
        
        x0 = Posición x del centro
        x1 = Posición y del centro
        x2 = Ancho del rectángulo
        x3 = Alto del rectángulo
        x4 = Color del rectángulo
*/
rectangle:
	sub sp,sp,#8
	stur lr,[sp]

    sub x0,x0,x2,lsr #1
	sub x1,x1,x3,lsr #1
    
	bl pixel

	mov x9,x0
	rectangle_row_loop:
		mov x10,x2
		rectangle_col_loop:
			stur w4,[x9]
			add x9,x9,4
			sub x10,x10,#1
			cbnz x10, rectangle_col_loop
			sub x9,x9,x2, lsl #2
			add x9,x9,x25, lsl #2
			sub x3,x3,#1
			cbnz x3, rectangle_row_loop
	ldur lr,[sp]
	add sp,sp,8
    br lr

/* 
    Dibuja un círculo en la pantalla.

    Parámetros:
        x0 = posicion del centro en x
        x1 = posicion del centro en y
        x2 = radio del circulo
        x3 = color del circulo
*/
circle:
            sub sp,sp,8
            stur lr,[sp]

            mov x4, x0
            mov x5, x1

            sub x9, x4,x2 
            sub x10, x5,x2

            mul x6,x2,x2
            add x7,x2,x2
            add x8,x2,x2
    circle_loop:
            sub x0,x9,x4
            sub x1,x10,x5
            madd x0,x0,x0,xzr
            madd x0,x1,x1,x0
            cmp x0,x6
            B.LE circle_loop2
            sub x7,x7,1
            add x9,x9,1
            cbnz x7,circle_loop
    circle_mov_y:
            add x10,x10,1
            sub x9,x4,x2
            sub x8,x8,1
            add x7,x2,x2
            cbnz x8, circle_loop
    circle_ret:
        ldur lr,[sp]
        add sp,sp,8
        BR LR
    
    circle_loop2: 
            mov x0,x9
            mov x1,x10
            BL pixel
            stur w3,[x0]
            add x9,x9,1
            sub x7,x7,1
            cbz x7, circle_mov_y
            b circle_loop

/* 
    Dibuja un triangulo en la pantalla.

    Parámetros:
        x0 = posicion del centro en x
        x1 = posicion del centro en y
        x2 = mitad de la altura del triangulo
        x3 = color del triangulo
*/
triangle:
    sub sp,sp,#8
    stur lr,[sp]
    
    sub x1, x1, x2
    mov x13, x0
    mov x10, x2, lsl 1
    mov x11, 1
    triangle_row_loop:
        mov x12, x11
        mov x0, x13
        bl pixel
        mov x9, x0
        triangle_col_loop:
            stur w3, [x9]
            add x9, x9, 4
            sub x12, x12, 1
            cbnz x12, triangle_col_loop
            add x11, x11, 2
            sub x10, x10, 1
            add x1, x1, 1
            sub x13, x13, 1
            cbnz x10, triangle_row_loop
    ldur lr,[sp]
    add sp,sp,8
    br lr

draw_player_ship:
    sub sp,sp,8
    stur lr,[sp]

    ldr x17,=ship_player

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2,8
    mov x3,25
    ldr x4,grey
    sub x0,x0,30
    sub x1,x1,5
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2,2
    mov x3,25
    ldr x4,red
    sub x0,x0,30
    sub x1,x1,5
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2,8
    mov x3,25
    ldr x4,grey
    add x0,x0,30
    sub x1,x1,5
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2,2
    mov x3,20
    ldr x4,red
    add x0,x0,30
    sub x1,x1,7
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2,10
    mov x3,35
    ldr x4,grey
    add x0,x0,57
    add x1,x1,15
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2,2
    mov x3,25
    ldr x4,red
    add x0,x0,57
    add x1,x1,10
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2,10
    mov x3,35
    ldr x4,grey
    sub x0,x0,57
    add x1,x1,15
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2,2
    mov x3,25
    ldr x4,red
    sub x0,x0,57
    add x1,x1,10
    bl rectangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2,30
    ldr x3,white
    bl triangle

    ldur w0,[x17]
    ldur w1,[x17,4]
    mov x2,30
    mov x3,15
    ldr x4,red
    sub x1,x1,5
    bl rectangle

    ldur lr,[sp]
    add sp,sp,8
    br lr //retrun

        
.endif
