/obj/machinery/electronic_display_case
	name = "electronic display case"
	desc = "A display case for selling wares. A business owner's pride."
	icon = 'icons/obj/display_case.dmi'
	icon_state = "preview"
	anchored = TRUE
	density = TRUE
	circuit = /obj/item/weapon/circuitboard/display_case

	// A composite display case that is much more attuned than a regular vending machine and easier on persistence/customisation without snowflake code.

	//products
	var/list/stored_products = list()

	// aesthetics
	var/static_icon = "" // if you don't want a composite icon and just wish to use a custom icon. Just in case.

	var/base_icon = "display"
	var/glass_icon = "display_glass"
	var/frame_icon = "display_frame"
	var/slot_icon = "display_slot"
	var/maint_icon = "display_maintenance"

	var/glass_color = COLOR_BLUE_GRAY
	var/frame_color = COLOR_SILVER

	// owner info
	var/owner_name = ""
	var/owner_uid = ""
	var/staff_pin = 0

	var/bank_id = ""
	var/owner_message = ""	// a message by the owner left behind for the customers

	//other
	var/obj/currently_vending
	var/maint_mode = FALSE
	var/atmpt_maint_mode = FALSE

	var/max_items = 30

	unique_save_vars = list("anchored","glass_color", "frame_color", "owner_name", "owner_uid", "staff_pin", "bank_id", "owner_message", "maint_mode", "atmpt_maint_mode")

/obj/machinery/electronic_display_case/New()
	. = ..()
	update_icon()
	if(!staff_pin)
		staff_pin = rand(1111,9999)

/obj/machinery/electronic_display_case/on_persistence_load()
	if(!isemptylist(contents))
		stored_products = contents

/obj/machinery/electronic_display_case/examine(mob/user)
	..()
	if(owner_name)
		to_chat(user, "[name] belongs to <b>[owner_name]</b>, report any issues with the machine to the owner.")


/obj/machinery/electronic_display_case/update_icon()
	overlays.Cut()
	icon_state = null

	if(static_icon)
		icon_state = static_icon
		return

	if(glass_icon)
		// add glass first
		var/image/G =  image(icon, glass_icon)
		G.color = glass_color
		overlays |= G

	if(frame_icon)
		// add frame
		var/image/F =  image(icon, frame_icon)
		F.color = frame_color
		overlays |= F

	if(slot_icon)
		var/image/S =  image(icon, slot_icon)
		overlays |= S

	if(maint_mode && maint_icon)
		var/image/M =  image(icon, maint_icon)
		overlays |= M


/obj/machinery/electronic_display_case/attack_hand(mob/user as mob)
	add_fingerprint(usr)


	if(istype(user, /mob/living/silicon))
		to_chat (user, "<span class='warning'>A firewall prevents you from interfacing with this device!</span>")
		return

	interact(user)
	updateDialog()


/obj/machinery/electronic_display_case/interact(mob/user as mob)
	var/dat

	dat = get_vend_data(user)

	var/datum/browser/popup = new(user, "electronic_display", "[src]", 550, 650, src)
	popup.set_content(jointext(dat,null))
	popup.open()

	onclose(user, "electronic_display")

/obj/machinery/electronic_display_case/proc/get_vend_data(mob/user as mob)
	var/dat

	//title
	dat += "<b>[name]</b><br>"

	if(!owner_uid)
		dat += "Please swipe your ID to claim ownership of this machine.<br>"
		return dat


	if(atmpt_maint_mode)
		dat += "Please swipe the initial ID you used to register this machine, or enter a staff pin code.<br>"

		dat += "<br><br><a href='?src=\ref[src];enter_pin=1'>Enter Staff Pin</a>"
		dat += "<a href='?src=\ref[src];cancel=1'>Cancel &#8617</a>"

		return dat

	//owner message left
	if(owner_message)
		dat += "<div class='statusDisplay'><i>[owner_message]</i></div><br>"

	if(!maint_mode)
		if(check_account_exists(bank_id))
			if(currently_vending)
				dat += "<div class='statusDisplay'>"

				dat += "<b>Current Product:</b> [currently_vending.name] | [cash2text( currently_vending.get_item_cost(), FALSE, TRUE, TRUE )]"
				if(currently_vending.post_tax_cost())
					dat += "<br><b>Full Price:</b> [cash2text( currently_vending.get_full_cost(), FALSE, TRUE, TRUE )] \
					<i>([cash2text( currently_vending.post_tax_cost(), FALSE, TRUE, TRUE )] tax incl)<br>"

				dat += "<br><i>Please swipe a card or cash to pay for this item</i>"

				dat += "</div><br>"

				dat += "<a href='?src=\ref[src];cancel=1'>Cancel &#8617</a>"
				return dat

			else
				//actual products
				dat += "<div class='statusDisplay'>"

				if(isemptylist(stored_products))
					dat += "No products found."
				else
					for(var/obj/O in stored_products)

						dat += "<a href='?src=\ref[src];choice=buy;item=\ref[O]''>Buy &#127980;</a> <b>[O.name]</b> - [cash2text( O.get_full_cost(), FALSE, TRUE, TRUE )]"
						if(O.post_tax_cost())
							dat += " (Includes [cash2text( O.post_tax_cost(), FALSE, TRUE, TRUE )] tax)"
						dat += "<br>"

				dat += "</div><br>"
		else
			dat += "<i>There appears to be an issue with the payment account of this vendor. Please contact the owner.</i>"


		dat += "<a href='?src=\ref[src];maint_mode=1'>Enter Maintenance Mode</a>"
	else
		dat += "Welcome to Maintenance mode. You can add any item by entering it into the machine. Additionally, you can remove any \
		item or change the staff's pin code. Remember to Exit Maintenance Mode when you are done, to lock and secure your machine.<br>"

		if(!check_account_exists(bank_id))
			dat += "<br><b>There is currently an issue with your bank details. Please update your linked bank account to enable the machine.</b>"

		dat += "<div class='statusDisplay'>"
		for(var/obj/O in stored_products)
			dat += "<a href='?src=\ref[src];choice=remove_item;item=\ref[O]'>Remove</a> <b>[O.name]</b> - [cash2text( O.get_item_cost(), FALSE, TRUE, TRUE )] \
			(Adds [cash2text( O.post_tax_cost(), FALSE, TRUE, TRUE )] tax)"
			dat += "<br>"
		dat += "</div><br>"
		dat += "<a href='?src=\ref[src];change_pin=1'>Change Staff Pin</a> "
		dat += "<a href='?src=\ref[src];edit_name=1'>Edit Name</a> "
		dat += "<a href='?src=\ref[src];edit_owner_message=1'>Edit Owner Message</a> "
		dat += "<a href='?src=\ref[src];edit_bank=1'>Update Bank Details</a> "
		dat += "<a href='?src=\ref[src];toggle_anchor=1'>Toggle Anchors</a> "
		dat += "<a href='?src=\ref[src];exit_maint_mode=1'>Exit Maintenance Mode</a> "
	return dat



/obj/machinery/electronic_display_case/proc/set_new_owner(obj/item/weapon/card/id/I)
	owner_name = I.registered_name
	owner_uid = I.unique_ID
	bank_id = I.associated_account_number
	visible_message("<span class='info'>New owner set to '[I.registered_name]'.</span>")
	playsound(src, 'sound/machines/chime.ogg', 25)

/obj/machinery/electronic_display_case/attackby(obj/item/weapon/W as obj, mob/user as mob)
	var/obj/item/weapon/card/id/I = W.GetID()

	if(!owner_uid && I)
		if(!I.unique_ID || !I.registered_name || !I.associated_account_number || !check_account_exists(I.associated_account_number))
			visible_message("<span class='notice'>There is an issue with setting your ownership on this message, it could be due to a lack of details on the card like \
			a unique id, name, or valid bank details. Please contact a technician for more details.</span>")
			return
		else
			set_new_owner(I)
			to_chat(user, "<span class='info'>A message displays on the screen: \"Your staff pin code is <b>[staff_pin]</b> - Please keep this safe and only share to those you trust\" \
		 	 You can change this at any time.</span>")
			maint_mode = TRUE
			update_icon()
		return

	if(currently_vending)
		var/paid = FALSE

		if(I) //for IDs and PDAs and wallets with IDs
			if(pay_with_card(I,user))
				paid = TRUE

		if(istype(W, /obj/item/weapon/spacecash/ewallet))
			var/obj/item/weapon/spacecash/ewallet/C = W
			if(pay_with_ewallet(C, user))
				paid = TRUE

		if(istype(W, /obj/item/weapon/spacecash))
			var/obj/item/weapon/spacecash/C = W
			if(pay_with_cash(C, user))
				paid = TRUE

		if(paid)
			vend(currently_vending, user)
		return

	if(maint_mode)
		if(istype(W, /obj/item))
			add_to_storage(W, user)
			return TRUE

	if(atmpt_maint_mode)
		if(I.unique_ID == owner_uid)
			atmpt_maint_mode = FALSE
			maint_mode = TRUE
			update_icon()
		else
			visible_message("<span class='notice'>Error: Unrecognised unique ID or authorization mismatch.</span>")
			return TRUE

	updateDialog()



/obj/machinery/electronic_display_case/proc/vend(obj/O, mob/user)
	if(O.get_item_cost() && !currently_vending)
		return
	if(O.get_item_cost())
		charge_to_account(bank_id, "[src]", "[currently_vending] Purchase", "[src]", O.get_item_cost())
	if(O.post_tax_cost())
		SSeconomy.charge_main_department(O.post_tax_cost(), "[src] Tax Transfer: [O.name] ([O.post_tax_cost()])")

	remove_from_storage(O, user)
	return TRUE


/obj/machinery/electronic_display_case/proc/pay_with_card(obj/item/weapon/card/id/I, mob/user)
	if(!currently_vending)
		return

	if(!I)
		to_chat(user, "<span class='notice'>Error: Unable to find valid ID card.")

	var/datum/money_account/customer_account = get_account(I.associated_account_number)
	if(!customer_account)
		visible_message("<span class='notice'>Error: Unable to access account. Please contact technical support if problem persists.</span>")
		return

	if(customer_account.suspended)
		visible_message("<span class='notice'>Unable to access account: account suspended.")
		return

	// Have the customer punch in the PIN before checking if there's enough money. Prevents people from figuring out acct is
	// empty at high security levels
	if(customer_account.security_level != 0) //If card requires pin authentication (ie seclevel 1 or 2)
		var/attempt_pin = input("Enter pin code", "Vendor transaction") as num
		customer_account = attempt_account_access(I.associated_account_number, attempt_pin, 2)

		if(!customer_account)
			visible_message("Unable to access account: incorrect credentials.")
			return

	if(currently_vending.get_full_cost() > customer_account.money)
		visible_message("Insufficient funds in account.")
		return

	// debit money from the purchaser's account
	customer_account.money -= currently_vending.get_full_cost()
	customer_account.add_transaction_log("[owner_name] (via [name])", "Purchase of [currently_vending.name]", currently_vending.get_full_cost(), name)

	return TRUE

/obj/machinery/electronic_display_case/proc/pay_with_cash(var/obj/item/weapon/spacecash/cashmoney, mob/user)
	if(currently_vending.get_full_cost() > cashmoney.worth)

		// This is not a status display message, since it's something the character
		// themselves is meant to see BEFORE putting the money in
		to_chat(user, "\icon[cashmoney] <span class='warning'>That is not enough money.</span>")
		return 0

	if(istype(cashmoney, /obj/item/weapon/spacecash))

		visible_message("<span class='info'>\The [usr] inserts some cash into \the [src].</span>")
		cashmoney.worth -= currently_vending.get_full_cost()

		if(cashmoney.worth <= 0)
			usr.drop_from_inventory(cashmoney)
			qdel(cashmoney)
		else
			cashmoney.update_icon()

	return TRUE

/obj/machinery/electronic_display_case/proc/pay_with_ewallet(var/obj/item/weapon/spacecash/ewallet/wallet, user)
	visible_message("<span class='info'>[user] swipes \the [wallet] through \the [src].</span>")
	if(currently_vending.get_full_cost() > wallet.worth)
		visible_message("Insufficient funds on chargecard.")
		return 0
	else
		wallet.worth -= currently_vending.get_full_cost()
		return TRUE

/obj/machinery/electronic_display_case/proc/add_to_storage(var/obj/O, mob/user)
	if(!O || O.dont_save)
		to_chat(user, "You were unable to load the item into [name].")
		return

	if(!isemptylist(stored_products))
		if((stored_products.len + 1) > max_items)
			to_chat(user, "You may have no more than [max_items] in your display case.")
			return

	user.drop_from_inventory(O, src)
	O.forceMove(src)
	stored_products += O
	src.visible_message("\icon[O] [user] places [O] into [src].")
	updateDialog()
	return

/obj/machinery/electronic_display_case/proc/remove_from_storage(var/obj/O, mob/user)
	if(!O || !(O in stored_products))
		to_chat(user, "You were unable to remove this item from [name].")
		return

	if(maint_mode)
		to_chat(user, "You remove [O] from \the [src]!")

	O.forceMove(get_turf(src))
	stored_products -= O
	currently_vending = null
	updateDialog()
	return

/obj/machinery/electronic_display_case/proc/try_staff_pin(mob/user)
	var/attempt_pin = input("Enter staff pin code", "Vendor transaction") as num

	if((attempt_pin != staff_pin))
		to_chat(user, "<span class='warning'>ERROR: Incorrect pin number.</span>")
	else
		atmpt_maint_mode = FALSE
		maint_mode = TRUE
		update_icon()


/obj/machinery/electronic_display_case/Topic(href, href_list)
	if(..())
		return 1

	if(href_list["cancel"])
		currently_vending = null
		maint_mode = FALSE
		atmpt_maint_mode = FALSE
		update_icon()

	if(href_list["maint_mode"])
		atmpt_maint_mode = TRUE

	if(href_list["exit_maint_mode"])
		maint_mode = FALSE
		update_icon()

	if(href_list["enter_pin"])
		if(!atmpt_maint_mode || maint_mode)
			return

		try_staff_pin(usr)

	if(href_list["change_pin"])
		if(!maint_mode)
			return

		var/new_pin = input("Enter new staff pin code", "Vendor transaction") as num
		if(!new_pin)
			return

		staff_pin = new_pin

		to_chat(usr, "<span class='info'>Pin successfully changed to [new_pin].</span>")

	if(href_list["edit_owner_message"])
		if(!maint_mode)
			return

		var/new_msg = sanitize(input("Enter a short new greeting message for the electronic display case. (200 chars max)", "Set Message", owner_message) as message, 200)

		if(!new_msg)
			owner_message = ""

		owner_message = new_msg


	if(href_list["edit_name"])
		if(!maint_mode)
			return

		var/new_name = sanitize(input("Enter a new name for this display case (100 characters max)", "Set Name", name) as text, 100)

		if(!new_name)
			name = initial(name)

		name = new_name
		alert("New name \"[new_name]\" has been set to this machine.")

	if(href_list["edit_bank"])
		if(!maint_mode)
			return

		var/new_bank = sanitize(input("Please enter the bank id you wish to replace the former. Leave blank to cancel.", "Set Bank", bank_id) as text, 100)

		if(!new_bank)
			return

		if(!check_account_exists(new_bank))
			alert("#[new_bank] does not appear to link to any bank ID in the database. Please try again.")

		bank_id = new_bank
		alert("New bank account ID set to #[new_bank].")

	if(href_list["toggle_anchor"])
		if(!maint_mode)
			return

		anchored = !anchored
		playsound(src, 'sound/items/drill_use.ogg', 25)

		if(anchored)
			to_chat(usr, "<b>The anchors tether themselves back into the floor. It is now secured.</b>")
		else
			to_chat(usr, "<b>You toggle the anchors of the display case. It can now be moved.</b>")


	if(href_list["choice"])
		switch(href_list["choice"])

			if("buy")
				var/item = locate(href_list["item"])
				if(!item || !(item in stored_products))
					return

				var/obj/O = item

				if(!O.get_item_cost())
					vend(O, usr)
				else
					currently_vending = O

			if("remove_item")
				var/item = locate(href_list["item"])
				if(!(item in stored_products))
					return

				var/obj/O = item
				remove_from_storage(O, usr)

	updateDialog()



