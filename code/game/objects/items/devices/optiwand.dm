/obj/item/device/optiwand
	name = "\improper optiwand"
	desc = "a piece of equipment which allows you to check a room without exposing yourself. Can't detect human heat, mostly used by law enforcers."
	icon_state = "optiwand"
	item_state = "optiwand"
	slot_flags = SLOT_BELT
	w_class = ITEMSIZE_NORMAL
	matter = list(DEFAULT_WALL_MATERIAL = 150)
	origin_tech = list(TECH_MAGNET = 1, TECH_ENGINEERING = 3)
	var/enables_planes = VIS_MESONS
	plane_slots

/obj/item/device/optiwand/equipped(var/mob/user,var/slot)
	..()
	if(enables_planes)
		user.recalculate_vis()

/obj/item/device/optiwand/dropped(var/mob/user)
	..()
	if(enables_planes)
		user.recalculate_vis()