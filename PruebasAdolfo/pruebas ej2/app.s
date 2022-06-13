.include "data.s"
.include "graphics.s"
.include "background.s"
.include "logic.s"
.include "entry.s"


.globl main
main:
	// X0 contiene la direccion base del framebuffer
	mov x25,SCREEN_WIDTH
	ldr x26,=buffer_secundary
 	mov x27,x0	// Guardamos la dirección base del framebuffer en x27
	//---------------- CODE HERE ------------------------------------
	bl entry_ships
animation:
	bl background

	bl bullet_draw
	
	bl draw_player_ship

	bl draw_all_enemy_ships
	
	bl frame_update
	
	bl update_playership
	
	bl update_bullet
	bl shoot_logic
	
	bl delay

	b animation
//---------------------------------------------------------------
	// Infinite Loop 

InfLoop: 
	b InfLoop
