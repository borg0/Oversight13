/decl/hierarchy/outfit/job/assistant
	name = OUTFIT_JOB_NAME("Civilian")
	id_type = /obj/item/weapon/card/id/assistant
	uniform = /obj/item/clothing/under/rank/orderly

/decl/hierarchy/outfit/job/assistant/visitor
	name = OUTFIT_JOB_NAME("Visitor")
	id_pda_assignment = "Visitor"
	uniform = /obj/item/clothing/under/suit_jacket/tan

/decl/hierarchy/outfit/job/assistant/socialite
	name = OUTFIT_JOB_NAME("Socialite")
	id_pda_assignment = "Socialite"
	uniform = /obj/item/clothing/under/aristocrat

/decl/hierarchy/outfit/job/assistant/resident
	name = OUTFIT_JOB_NAME("Resident")
	id_pda_assignment = "Resident"
	uniform = /obj/item/clothing/under/scratch

/decl/hierarchy/outfit/job/service
	l_ear = /obj/item/device/radio/headset/headset_service
	hierarchy_type = /decl/hierarchy/outfit/job/service

/decl/hierarchy/outfit/job/service/bartender
	name = OUTFIT_JOB_NAME("Bartender")
	uniform = /obj/item/clothing/under/rank/bartender
	id_type = /obj/item/weapon/card/id/civilian/bartender
	pda_type = /obj/item/device/pda/bar
	backpack_contents = list(/obj/item/clothing/accessory/permit/gun/tier_three/bar = 1)

/decl/hierarchy/outfit/job/service/bartender/post_equip(mob/living/carbon/human/H)
	..()
	for(var/obj/item/clothing/accessory/permit/gun/tier_three/bar/permit in H.back.contents)
		permit.set_name(H.real_name)

/decl/hierarchy/outfit/job/service/bartender/barista
	name = OUTFIT_JOB_NAME("Barista")
	id_pda_assignment = "Barista"
	backpack_contents = null

/decl/hierarchy/outfit/job/service/chef
	name = OUTFIT_JOB_NAME("Chef")
	uniform = /obj/item/clothing/under/rank/chef
	suit = /obj/item/clothing/suit/chef
	head = /obj/item/clothing/head/chefhat
	id_type = /obj/item/weapon/card/id/civilian/chef
	pda_type = /obj/item/device/pda/chef

/decl/hierarchy/outfit/job/service/chef/cook
	name = OUTFIT_JOB_NAME("Cook")
	id_pda_assignment = "Cook"

/decl/hierarchy/outfit/job/service/gardener
	name = OUTFIT_JOB_NAME("Gardener")
	uniform = /obj/item/clothing/under/rank/hydroponics
	suit = /obj/item/clothing/suit/storage/apron
	gloves = /obj/item/clothing/gloves/botanic_leather
	backpack = /obj/item/weapon/storage/backpack/hydroponics
	satchel_one = /obj/item/weapon/storage/backpack/satchel/hyd
	messenger_bag = /obj/item/weapon/storage/backpack/messenger/hyd
	id_type = /obj/item/weapon/card/id/civilian/botanist
	pda_type = /obj/item/device/pda/botanist

/decl/hierarchy/outfit/job/service/janitor
	name = OUTFIT_JOB_NAME("Janitor")
	suit = /obj/item/clothing/suit/storage/toggle/hivisjacket
	uniform = /obj/item/clothing/under/rank/janitor
	id_type = /obj/item/weapon/card/id/civilian/janitor
	pda_type = /obj/item/device/pda/janitor

/decl/hierarchy/outfit/job/civilian/journalist
	name = OUTFIT_JOB_NAME("Journalist")
	uniform = /obj/item/clothing/under/suit_jacket/red
	l_hand = /obj/item/weapon/barcodescanner
	id_type = /obj/item/weapon/card/id/civilian/journalist
	pda_type = /obj/item/device/pda/librarian


/decl/hierarchy/outfit/job/explorer
	name = OUTFIT_JOB_NAME("Explorer")
	shoes = /obj/item/clothing/shoes/boots/winter/explorer
	uniform = /obj/item/clothing/under/explorer
	mask = /obj/item/clothing/mask/gas/explorer
	suit = /obj/item/clothing/suit/storage/hooded/explorer
	gloves = /obj/item/clothing/gloves/black
	l_ear = /obj/item/device/radio/headset
	id_slot = slot_wear_id
	id_type = /obj/item/weapon/card/id/civilian
	pda_slot = slot_belt
	pda_type = /obj/item/device/pda/cargo // Brown looks more rugged
	r_pocket = /obj/item/device/gps/explorer
	id_pda_assignment = "Explorer"

/decl/hierarchy/outfit/job/civilian/barber
	name = OUTFIT_JOB_NAME("Barber")
	id_type = /obj/item/weapon/card/id/civilian/barber
	uniform = /obj/item/clothing/under/rank/barber
	r_pocket = /obj/item/weapon/scissors/barber


/decl/hierarchy/outfit/job/civilian/secretary
	name = OUTFIT_JOB_NAME("Secretary")
	l_ear = /obj/item/device/radio/headset/headset_com
	r_ear = /obj/item/weapon/pen
	shoes = /obj/item/clothing/shoes/brown
	id_type = /obj/item/weapon/card/id/civilian/secretary
	r_hand = /obj/item/weapon/folder
	l_hand = /obj/item/weapon/paper

/decl/hierarchy/outfit/job/civilian/secretary/pre_equip(mob/living/carbon/human/H)
	..()
	if(H.gender == FEMALE)
		uniform = /obj/item/clothing/under/suit_jacket/checkered/skirt
	else
		uniform = /obj/item/clothing/under/suit_jacket/checkered


/decl/hierarchy/outfit/job/civilian/prisoner
	name = OUTFIT_JOB_NAME("Prisoner")
	id_pda_assignment = "Prisoner"
	uniform = /obj/item/clothing/under/color/orange
	shoes = /obj/item/clothing/shoes/orange