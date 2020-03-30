/obj/structure/reinforcement
	name = "wall reinforcement"
	desc = "A flimsy lattice of metal rods, with screws to secure it to the floor."
	icon = 'icons/obj/grille.dmi'
	icon_state = "reinforced"
	density = 1
	opacity = 0
	anchored = 1
	layer = 2.9
	explosion_resistance = 1
	var/health = 10
	var/destroyed = 0

/obj/item/weapon/wallreinforcer
	name = "wall reinforcer"
	icon = 'icons/obj/grille.dmi'
	icon_state = "reinforcedroll"
	throwforce = 10
	w_class = ITEMSIZE_NORMAL
	throw_speed = 2
	throw_range = 10
	force = 10
	matter = list(DEFAULT_WALL_MATERIAL = 90)
	attack_verb = list("slammed", "whacked", "bashed", "thunked", "battered", "bludgeoned", "thrashed")
	drop_sound = 'sound/items/drop/metalboots.ogg'