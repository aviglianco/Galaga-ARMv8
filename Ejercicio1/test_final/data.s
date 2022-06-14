.ifndef data_s
.equ data_s, 0

/*
    Este archivo contiene toda la información relacionada con valores 
    que se utilizan en diversos puntos a lo largo del programa
*/

.data
// Arreglos de posiciones
/*
    Las naves estarán asociadas a un arreglo de posiciones.
    Estos se organizan de la siguiente forma:
    ship_player <ejex>,<ejey>
    ship_enemyX <ejex>,<ejey>

    "dead" se inicializa en 0 e indica si hay que pintar o no la correspondiente nave.
    Cuando el campo <dead>==1, la nave no se pintará más.
*/
ship_player: .word  240,400
ship_enemy1: .word 135,120
ship_enemy2: .word 270,80
ship_enemy3: .word 405,80
ship_enemy4: .word 540,120

// Balas
/*
    Tenemos un arreglo para cada bala. 
    La estructura se organiza de la siguiente forma:
    bullet_X: <ejex>,<ejey>
*/
bullet_1:  .word 270,340
bullet_2:  .word 540,180
bullet_3:  .word 405,260

// Colores
white: .word        0xFFFFFF
red: .word          0xFF0000
green: .word        0x66CC00
light_green: .word  0x32A86D
purple: .word       0x990099
yellow: .word       0xFFFF00
grey: .word         0x808080
blue: .word         0x001933
light_blue: .word   0x3B83BD
orange: .word       0xF54505

// Pantalla 
/*
    Algunas constantes relacionadas con el tamaño de los píxeles y la pantalla.
*/
.equ SCREEN_WIDTH, 		640
.equ SCREEN_HEIGH, 		480
.equ BITS_PER_PIXEL,  	32
.equ BYTES_PER_PIXEL,    4

.endif
