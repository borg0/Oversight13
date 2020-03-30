/obj/item/weapon/grenade
	name = "grenade"
	desc = "A hand held grenade, with an adjustable timer."
	w_class = ITEMSIZE_SMALL
	icon = 'icons/obj/grenade.dmi'
	icon_state = "grenade"
	item_state = "grenade"
	throw_speed = 4
	throw_range = 20
	flags = CONDUCT
	slot_flags = SLOT_MASK|SLOT_BELT

	var/active = 0
	var/det_time = 50
	var/loadable = 1

	get_tax()
		return WEAPONS_TAX

	is_contraband()
		return CONTRABAND_EXPLOSIVES


/obj/item/weapon/grenade/proc/clown_check(var/mob/living/user)
	if((CLUMSY in user.mutations) && prob(50))
		user << "<span class='warning'>Huh? How does this thing work?</span>"

		activate(user)
		add_fingerprint(user)
		spawn(5)
			prime()
		return 0
	return 1


/*/obj/item/weapon/grenade/afterattack(atom/target as mob|obj|turf|area, mob/user as mob)
	if (istype(target, /obj/item/weapon/storage)) return ..() // Trying to put it in a full container
	if (istype(target, /obj/item/weapon/gun/grenadelauncher)) return ..()
	if((user.get_active_hand() == src) && (!active) && (clown_check(user)) && target.loc != src.loc)
		user << "<span class='warning'>You prime the [name]! [det_time/10] seconds!</span>"
		active = 1
		icon_state = initial(icon_state) + "_active"
		playsound(loc, 'sound/weapons/armbomb.ogg', 75, 1, -3)
		spawn(det_time)
			prime()
			return
		user.set_dir(get_dir(user, target))
		user.drop_item()
		var/t = (isturf(target) ? target : target.loc)
		walk_towards(src, t, 3)
	return*/


/obj/item/weapon/grenade/examine(mob/user)
	if(..(user, 0))
		if(det_time > 1)
			user << "The timer is set to [det_time/10] seconds."
			return
		if(det_time == null)
			return
		user << "\The [src] is set for instant detonation."


/obj/item/weapon/grenade/attack_self(mob/user as mob)
	if(!active)
		if(clown_check(user))
			user << "<span class='warning'>You prime \the [name]! [det_time/10] seconds!</span>"

			activate(user)
			add_fingerprint(user)
			if(iscarbon(user))
				var/mob/living/carbon/C = user
				C.throw_mode_on()
	return


/obj/item/weapon/grenade/proc/activate(mob/user as mob)
	if(active)
		return

	if(user)
		msg_admin_attack("[key_name_admin(user)] primed \a [src.name]")

	icon_state = initial(icon_state) + "_active"
	active = 1
	playsound(loc, 'sound/weapons/armbomb.ogg', 75, 1, -3)

	spawn(det_time)
		prime()
		return


/obj/item/weapon/grenade/proc/prime()
//	playsound(loc, 'sound/items/Welder2.ogg', 25, 1)
	var/turf/T = get_turf(src)
	if(T)
		T.hotspot_expose(700,125)


/obj/item/weapon/grenade/attackby(obj/item/weapon/W as obj, mob/user as mob)
	if(isscrewdriver(W))
		switch(det_time)
			if (1)
				det_time = 10
				user << "<span class='notice'>You set the [name] for 1 second detonation time.</span>"
			if (10)
				det_time = 30
				user << "<span class='notice'>You set the [name] for 3 second detonation time.</span>"
			if (30)
				det_time = 50
				user << "<span class='notice'>You set the [name] for 5 second detonation time.</span>"
			if (50)
				det_time = 1
				user << "<span class='notice'>You set the [name] for instant detonation.</span>"
		add_fingerprint(user)
	..()
	return

/obj/item/weapon/grenade/attack_hand()
	walk(src, null, null)
	..()
	return
