.ifndef background_s
.equ background_s, 0

.include "data.s"
.include "graphics.s"

/* 
    Dibuja un cuadrado del color del fondo.

    Parámetros:
        
        x0 = Posición del cuadrado horizontalmente, puede ser 0, 1, 2 o 3
        x1 = Posición del cuadrado verticalmente, puede ser 0, 1 o 2


    Retorno:
        Se modifican los registros 
*/    
background_color:
    //Save return address
	sub sp,sp,#8
	stur lr,[sp]
    
    mov x2, #160 //Ancho
    mov x3, x2 //Alto
    mov x4, blue //Color de fondo

    lsr x9, x2, #1 //Mitad del lado del cuadrado
    madd x0, x0,x2, x9 //Posicion x = pos_x * 160 + 80
    madd x1, x1,x2, x9 //Posicion y = pos_y * 160 + 80
    
    bl rectangle

    ldur lr, [sp]
    add sp,sp,#8
    br lr


/* 
    Dibuja el diseño 1 del fondo.

    Parámetros:
        x0 = Posición del diseño, puede ser 0, 1, 2 o 3
        x1 = Posición del diseño, puede ser 0, 1, o 2
*/
background_part1:
    //Save return address, x19 y x20 (Para salvar la posición del diseño)
	sub sp,sp,#24
	stur lr,[sp]
    stur x19,[sp,#8]
    stur x20,[sp,#16]
    mov x19, x0
    mov x20, x1

    //Color del fondo
    bl background_color

    mov x9, #160
    mul x19,x9,x19
    mul x20,x9,x20

    //Estrellas
    add x0, x19, #16
    add x1, x20, #16
    mov x2, #3
    mov x3, red
    bl circulo

    add x0, x19, #37
    add x1, x20, #48
    mov x2, #2
    ldr w3, green
    bl circulo

    add x0, x19, #78
    add x1, x20, #102
    mov x2, #4
    ldr w3, purple
    bl circulo

    add x0, x19, #150
    add x1, x20, #56
    mov x2, #3
    ldr w3, yellow
    bl circulo

    add x0, x19, #30
    add x1, x20, #140
    mov x2, #5
    mov x3, red
    bl circulo

    mov x0,x19
    mov x1,x20

    ldur lr, [sp]
    ldur x19, [sp,#8]
    ldur x20, [sp,#16]
    add sp,sp,#24
    br lr

/* 
    Dibuja el diseño 2 del fondo.

    Parámetros:
        x0 = Posición del diseño, puede ser 0, 1, 2 o 3
        x1 = Posición del diseño, puede ser 0, 1, o 2
*/
background_part2:
    //Save return address, x19 y x20 (Para salvar la posición del diseño)
    sub sp,sp,#24
    stur lr,[sp]
    stur x19,[sp,#8]
    stur x20,[sp,#16]
    mov x19, x0
    mov x20, x1

    //Color del fondo
    bl background_color

    mov x9, #160
    mul x19,x9,x19
    mul x20,x9,x20

    //Estrellas
    add x0, x19, #16
    add x1, x20, #16
    mov x2, #3
    ldr w3, green
    bl circulo

    add x0, x19, #69
    add x1, x20, #69
    mov x2, #2
    ldr w3, green
    bl circulo

    add x0, x19, #107
    add x1, x20, #102
    mov x2, #4
    ldr w3, yellow
    bl circulo

    add x0, x19, #59
    add x1, x20, #20
    mov x2, #3
    ldr w3, yellow
    bl circulo

    add x0, x19, #130
    add x1, x20, #150
    mov x2, #5
    mov x3, red
    bl circulo

    ldur lr, [sp]
    ldur x19, [sp,#8]
    ldur x20, [sp,#16]
    add sp,sp,#24
    br lr

/* 
    Dibuja el diseño 3 del fondo.

    Parámetros:
        x0 = Posición del diseño, puede ser 0, 1, 2 o 3
        x1 = Posición del diseño, puede ser 0, 1, o 2
*/
background_part3:
    //Save return address, x19 y x20 (Para salvar la posición del diseño)
	sub sp,sp,#24
	stur lr,[sp]
    stur x19,[sp,#8]
    stur x20,[sp,#16]
    mov x19, x0
    mov x20, x1

    //Color del fondo
    bl background_color

    mov x9, #160
    mul x19,x9,x19
    mul x20,x9,x20

    //Estrellas
    add x0, x19, #73
    add x1, x20, #16
    mov x2, #3
    ldr w3, purple
    bl circulo

    add x0, x19, #90
    add x1, x20, #140
    mov x2, #2
    ldr w3, green
    bl circulo

    add x0, x19, #61
    add x1, x20, #102
    mov x2, #4
    ldr w3, purple
    bl circulo

    add x0, x19, #50
    add x1, x20, #20
    mov x2, #3
    ldr w3, yellow
    bl circulo

    add x0, x19, #150
    add x1, x20, #130
    mov x2, #4
    mov x3, red
    bl circulo
    
    ldur lr, [sp]
    ldur x19, [sp,#8]
    ldur x20, [sp,#16]
    add sp,sp,#24
    br lr

/* 
    Dibuja el  fondo.

    Parámetros: -
*/
background:
    //Save return address
	sub sp,sp,#24
    stur lr,[sp]
    stur x19,[sp,#8]
	stur x20,[sp,#16]
    mov x0,xzr
    mov x1,xzr

    mov x15,#4
    background_loop:
        mov x19,x0
        mov x20,x1
        bl background_part1
        mov x0,x19
        mov x1,x20
        cmp x0,#3
        csinc x0,xzr,x0,EQ
        csinc x1,x1,x1,NE

        mov x19,x0
        mov x20,x1
        bl background_part2
        mov x0,x19
        mov x1,x20
        cmp x0,#3
        csinc x0,xzr,x0,EQ
        csinc x1,x1,x1,NE

        mov x19,x0
        mov x20,x1
        bl background_part3
        mov x0,x19
        mov x1,x20
        cmp x0,#3
        csinc x0,xzr,x0,EQ
        csinc x1,x1,x1,NE

        subs x15,x15,#1
        b.ne background_loop

    ldur lr, [sp]
    ldur x19, [sp,#8]
    ldur x20, [sp,#16]
    add sp,sp,#24
    br lr

.endif
