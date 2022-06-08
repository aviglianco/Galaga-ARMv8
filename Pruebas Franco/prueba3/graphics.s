.ifndef graphics_s
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
	add x0,x27,x0, lsl #2 //baseArray + (fila.|Columnas| + columna)*4
	br lr //return

/* 
    Dibuja un rectángulo en pantalla.

    Se utilizan los registros x9 y x10 como registros internos para las operaciones

    Parámetros:
        
        x0 = Posición x del centro
        x1 = Posición y del centro
        x2 = Ancho del rectángulo
        x3 = Alto del rectángulo
        x4 = Color del rectángulo
    Retorno:
        Se modifican los registros x0, x2, x3, x9 y x10
*/
rectangle:
	//Save return address
	sub sp,sp,#8
	stur lr,[sp]

    //Me muevo hacia la esquina izquierda desde donde voy a pintar
    sub x0,x0,x2,lsr #1 //Me muevo a la izquierda desde donde voy a pintar
	sub x1,x1,x3,lsr #1 //Me muevo hacia arriba desde donde voy a pintar
    
    //Obtengo el pixel en x0
	bl pixel

	mov x9,x0 //Puntero del rectangulo
	rectangle_row_loop:
		mov x10,x2 //Restablezco el ancho de la fila
		rectangle_col_loop:
			stur w4,[x9] //Seteo el color
			add x9,x9,4 //Avanzo a la siguiente posicion
			sub x10,x10,#1 //Resto 1 al ancho restante
			cbnz x10, rectangle_col_loop //Si sigue habiendo ancho restante repito
			sub x9,x9,x2, lsl #2 //Restablezco el puntero a la posicion inicial de la fila
			add x9,x9,x25, lsl #2 //Avanzo una fila al puntero
			sub x3,x3,#1 //Resto 1 a las filas restantes
			cbnz x3, rectangle_row_loop //Si sigue habiendo filas restantes repito
	ldur lr,[sp] //Recupero el return address
	add sp,sp,8
    br lr //return

/* 
    Dibuja un círculo en la pantalla.

    Parámetros:
        x0 = posicion del centro en x
        x1 = posicion del centro en y
        x2 = radio del circulo
        x3 = color del circulo

    Retorno:
        modifica los registros x0,x1,x4,x5,x6,x7,x8,x9 y x10
            
*/
circulo:
            sub sp,sp,8
            stur lr,[sp]
            //guardo la direccion de retorno

            mov x4, x0 //paso x0 a x4 para poder usar x0 como parametro mas tarde
            mov x5, x1 //paso x1 a x5 para poder usar x1 como parametro mas tarde

            sub x9, x4,x2  // calcula la esquina izquierda (en x) del cuadrado a recorrer para pintar el circulo 
            sub x10, x5,x2  // calcula la altura de la esquina izq(en y) para el cuadrado  
            

            mul x6,x2,x2 //radio al cuadrado
            add x7,x2,x2 //contador ancho del cuadrado
            add x8,x2,x2 //contador alto del cuadrado
    loop_c:
            sub x0,x9,x4 //x-a
            sub x1,x10,x5 //y-b
            madd x0,x0,x0,xzr //(x-a)^2
            madd x0,x1,x1,x0 //(x-a)^2 + (y-b)^2
            cmp x0,x6 // (x- a)^2 + (y - b)^2 <= r^2
            B.LE circle_l //si pertenece al circulo pintamos
            sub x7,x7,1
            add x9,x9,1
            cbnz x7,loop_c
    movy:
            add x10,x10,1 //aumento el y
            sub x9,x4,x2 //vuelvo a setear x
            sub x8,x8,1   //le quito uno a mi contador de eje y
            add x7,x2,x2  //vuelvo a setear el ancho 
            cbnz x8, loop_c 
    c_ret:
        ldur lr,[sp]
        add sp,sp,8
        BR LR
    
    circle_l: 
            mov x0,x9
            mov x1,x10
            BL pixel
            stur w3,[x0]
            add x9,x9,1 //me muevo al sig x
            sub x7,x7,1  //actualizo contador del ancho
            cbz x7, movy // si me pase de linea, reseteo al ancho de vuelta y aumento mi 'y' y vuelvo a setear x en el inicio de la linea
            b loop_c
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

    Retorno:
        Se modifican los registros 
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

    Retorno:
        Se modifican los registros 
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

    Retorno:
        Se modifican los registros 
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

    Retorno:
        Se modifican los registros 
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
