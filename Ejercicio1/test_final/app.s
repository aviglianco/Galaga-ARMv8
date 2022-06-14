.include "background.s"
.include "data.s"
.include "graphics.s"


.globl main
main:
	// X0 contiene la direccion base del framebuffer
	mov x25,SCREEN_WIDTH
 	mov x27,x0	// Guardamos la dirección base del framebuffer en x27
	//---------------- CODE HERE ------------------------------------
animation:
	bl background

	bl draw_player_ship
	bl draw_all_enemy_ships

	bl paint_bullets

//---------------------------------------------------------------
	// Infinite Loop

InfLoop:
	b InfLoop
