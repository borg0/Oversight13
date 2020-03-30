/decl/hierarchy/outfit/job/science
	hierarchy_type = /decl/hierarchy/outfit/job/science
	l_ear = /obj/item/device/radio/headset/headset_sci
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	shoes = /obj/item/clothing/shoes/white
	pda_type = /obj/item/device/pda/science
	backpack = /obj/item/weapon/storage/backpack/toxins
	satchel_one = /obj/item/weapon/storage/backpack/satchel/tox
	messenger_bag = /obj/item/weapon/storage/backpack/messenger/tox

/decl/hierarchy/outfit/job/science/rd
	name = OUTFIT_JOB_NAME("Research Director")
	l_ear = /obj/item/device/radio/headset/heads/rd
	uniform = /obj/item/clothing/under/rank/research_director
	shoes = /obj/item/clothing/shoes/brown
	l_hand = /obj/item/weapon/clipboard
	id_type = /obj/item/weapon/card/id/science/head
	pda_type = /obj/item/device/pda/heads/rd
	backpack_contents = list(/obj/item/clothing/accessory/permit/gun = 1)

/decl/hierarchy/outfit/job/science/rd/post_equip(mob/living/carbon/human/H)
	..()
	for(var/obj/item/clothing/accessory/permit/gun/permit in H.back.contents)
		permit.set_name(H.real_name)

/decl/hierarchy/outfit/job/science/scientist
	name = OUTFIT_JOB_NAME("Scientist")
	uniform = /obj/item/clothing/under/rank/scientist
	id_type = /obj/item/weapon/card/id/science/scientist
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/science