/obj/machinery/dye_generator
	name = "Dye Generator"
	icon = 'icons/obj/vending.dmi'
	icon_state = "barbervend"
	density = 1
	anchored = 1
	use_power = 1
	idle_power_usage = 40
	var/dye_color = "#FFFFFF"
	clicksound = "button"
	circuit = /obj/item/weapon/circuitboard/dye_generator
	var/making = 0

	unique_save_vars = list("dye_color")

/obj/machinery/dye_generator/initialize()
	power_change()

/obj/machinery/dye_generator/power_change()
	if(stat & BROKEN)
		icon_state = "[initial(icon_state)]-broken"
		set_light(0)
	else
		if(powered())
			icon_state = initial(icon_state)
			stat &= ~NOPOWER
			set_light(2, l_color = dye_color)
		else
			spawn(rand(0, 15))
				src.icon_state = "[initial(icon_state)]-off"
				stat |= NOPOWER
				set_light(0)

/obj/machinery/dye_generator/ex_act(severity)
	switch(severity)
		if(1.0)
			qdel(src)
			return
		if(2.0)
			if (prob(50))
				qdel(src)
				return
		if(3.0)
			if(prob(25))
				stat |= BROKEN
				icon_state = "[initial(icon_state)]-broken"

/obj/machinery/dye_generator/attack_hand(mob/user as mob)
	..()
	src.add_fingerprint(user)
	if(stat & (BROKEN|NOPOWER))
		return
	var/temp = input(usr, "Choose a dye color", "Dye Color") as color
	dye_color = temp
	set_light(2, l_color = temp)

/obj/machinery/dye_generator/attackby(obj/item/weapon/W, mob/user, params)
	if(making)
		to_chat(user,"<span class='notice'>[src] is currently busy, try waiting a while.</span>")
		return

	if(default_unfasten_wrench(user, W, time = 60))
		return

	if(istype(W, /obj/item/hair_dye_bottle))
		user.visible_message("<span class='notice'>[user] fills the [W] up with some dye.</span>","<span class='notice'>You fill the [W] up with some hair dye.</span>")
		var/obj/item/hair_dye_bottle/HD = W


		HD.dye_color = dye_color
		HD.update_dye_overlay()
		return

	if(istype(W, /obj/item/stack))
		var/obj/item/stack/S = W
		if(!S.dyeable)
			to_chat(S, "<span class='notice'>It doesn't look like the machine can accept this material.</span>")
		else
			user.visible_message("<span class='notice'>[user] inserts the [W] into [src].</span>","<span class='notice'>You insert [W] into the [src].</span>")
			user.drop_from_inventory(S, src)
			S.forceMove(src)
			making = 1
			playsound(loc, 'sound/effects/bubbles2.ogg', 5, 1, 5)
			S.stack_color = dye_color
			S.update_icon()
			making = 1
			spawn(70)
				S.forceMove(loc)
				making = 0

			return


	if(istype(W, /obj/item/stack/wax))
		user.visible_message("<span class='notice'>[user] inserts [W] into the [src].</span>","<span class='notice'>You insert [W] into the [src].</span>")
		var/obj/item/stack/wax/B = W
		qdel(B)
		playsound(loc, 'sound/effects/bubbles2.ogg', 5, 1, 5)
		making = 1
		spawn(70)
			playsound(loc, 'sound/effects/pop.ogg', 5, 1, 5)
			var/obj/item/weapon/lipstick/lipstick = new /obj/item/weapon/lipstick(loc)
			lipstick.colour = dye_color
			making = 0
		return

	if(istype(W, /obj/item/clothing))
		var/obj/item/clothing/C = W
		if(!C.applies_material_color)
			to_chat(user,"<span class='notice'>[src] cannot be dyed.</span>")
			return
		else
			user.drop_from_inventory(C, src)
			C.forceMove(src)
			playsound(loc, 'sound/effects/bubbles2.ogg', 5, 1, 5)
			W.color = dye_color
			making = 1
			spawn(70)
				C.forceMove(loc)
				making = 0

			return

	..()

//Hair Dye Bottle

/obj/item/hair_dye_bottle
	name = "Hair Dye Bottle"
	desc = "A refillable bottle used for holding hair dyes of all sorts of colors."
	icon = 'icons/obj/cosmetics.dmi'
	icon_state = "hairdyebottle"
	throwforce = 0
	throw_speed = 4
	throw_range = 7
	force = 0
	w_class = 1.0
	var/dye_color = "#FFFFFF"

	unique_save_vars = list("dye_color")


/obj/item/hair_dye_bottle/New()
	..()
	update_dye_overlay()

/obj/item/hair_dye_bottle/proc/update_dye_overlay()
	overlays.Cut()
	var/image/I = new('icons/obj/cosmetics.dmi', "hairdyebottle-overlay")
	I.color = dye_color
	overlays += I

/obj/item/hair_dye_bottle/attack(mob/living/carbon/M as mob, mob/user as mob)
	if(user.a_intent != "help")
		..()
		return
	if(!(M in view(1)))
		..()
		return
	if(ishuman(M))
		var/mob/living/carbon/human/H = M

		var/dye_list = list("hair")

		if(H.gender == MALE)
			dye_list += "facial hair"


		var/what_to_dye = input(user, "Choose an area to apply the dye","Dye Application") in dye_list

		user.visible_message("<span class='notice'>[user] starts dying [M]'s [what_to_dye]!</span>", "<span class='notice'>You start dying [M]'s [what_to_dye]!</span>")
		if(do_after(user, 50, target = H))
			switch(what_to_dye)
				if("hair")
					var/r_hair = hex2num(copytext(dye_color, 2, 4))
					var/g_hair = hex2num(copytext(dye_color, 4, 6))
					var/b_hair = hex2num(copytext(dye_color, 6, 8))
					if(H.change_hair_color(r_hair, g_hair, b_hair))
						H.update_dna()
				if("facial hair")
					var/r_facial = hex2num(copytext(dye_color, 2, 4))
					var/g_facial = hex2num(copytext(dye_color, 4, 6))
					var/b_facial = hex2num(copytext(dye_color, 6, 8))
					if(H.change_facial_hair_color(r_facial, g_facial, b_facial))
						H.update_dna()


		user.visible_message("<span class='notice'>[user] finishes dying [M]'s [what_to_dye]!</span>", "<span class='notice'>You finish dying [M]'s [what_to_dye]!</span>")