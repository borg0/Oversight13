/decl/hierarchy/outfit/job/medical
	hierarchy_type = /decl/hierarchy/outfit/job/medical
	l_ear = /obj/item/device/radio/headset/headset_med
	shoes = /obj/item/clothing/shoes/white
	pda_type = /obj/item/device/pda/medical
	pda_slot = slot_l_store
	backpack = /obj/item/weapon/storage/backpack/medic
	satchel_one = /obj/item/weapon/storage/backpack/satchel/med
	messenger_bag = /obj/item/weapon/storage/backpack/messenger/med

/decl/hierarchy/outfit/job/medical/cmo
	name = OUTFIT_JOB_NAME("Chief Medical Officer")
	l_ear  =/obj/item/device/radio/headset/heads/cmo
	uniform = /obj/item/clothing/under/rank/chief_medical_officer
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/cmo
	shoes = /obj/item/clothing/shoes/brown
	l_hand = /obj/item/weapon/storage/firstaid/adv
	r_pocket = /obj/item/device/healthanalyzer
	id_type = /obj/item/weapon/card/id/medical/head
	pda_type = /obj/item/device/pda/heads/cmo
	backpack_contents = list(/obj/item/clothing/accessory/permit/gun = 1)

/decl/hierarchy/outfit/job/medical/cmo/post_equip(mob/living/carbon/human/H)
	..()
	for(var/obj/item/clothing/accessory/permit/gun/permit in H.back.contents)
		permit.set_name(H.real_name)

/decl/hierarchy/outfit/job/medical/doctor
	name = OUTFIT_JOB_NAME("Doctor")
	uniform = /obj/item/clothing/under/rank/medical
	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	l_hand = /obj/item/weapon/storage/firstaid/regular
	r_pocket = /obj/item/device/flashlight/pen
	id_type = /obj/item/weapon/card/id/medical/doctor

/decl/hierarchy/outfit/job/medical/doctor/emergency_physician
	name = OUTFIT_JOB_NAME("Emergency Physician")
	suit = /obj/item/clothing/suit/storage/toggle/fr_jacket

/decl/hierarchy/outfit/job/medical/doctor/surgeon
	name = OUTFIT_JOB_NAME("Surgeon")
	uniform = /obj/item/clothing/under/rank/medical/scrubs
	head = /obj/item/clothing/head/surgery/blue

/decl/hierarchy/outfit/job/medical/doctor/virologist
	name = OUTFIT_JOB_NAME("Virologist")
	uniform = /obj/item/clothing/under/rank/virologist
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/virologist
	mask = /obj/item/clothing/mask/surgical
	backpack = /obj/item/weapon/storage/backpack/virology
	satchel_one = /obj/item/weapon/storage/backpack/satchel/vir

/decl/hierarchy/outfit/job/medical/doctor/nurse
	name = OUTFIT_JOB_NAME("Nurse")
	suit = null

/decl/hierarchy/outfit/job/medical/doctor/nurse/pre_equip(mob/living/carbon/human/H)
	if(H.gender == FEMALE)
		if(prob(50))
			uniform = /obj/item/clothing/under/rank/nursesuit
		else
			uniform = /obj/item/clothing/under/rank/nurse
		head = /obj/item/clothing/head/nursehat
	else
		uniform = /obj/item/clothing/under/rank/medical/scrubs/purple
	..()

/decl/hierarchy/outfit/job/medical/geneticist
	name = OUTFIT_JOB_NAME("Geneticist")
	uniform = /obj/item/clothing/under/rank/geneticist
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/genetics
	backpack = /obj/item/weapon/storage/backpack/genetics
	r_pocket = /obj/item/device/flashlight/pen
	satchel_one = /obj/item/weapon/storage/backpack/satchel/gen
	id_type = /obj/item/weapon/card/id/medical/geneticist
	pda_type = /obj/item/device/pda/geneticist

/decl/hierarchy/outfit/job/medical/paramedic
	name = OUTFIT_JOB_NAME("Paramedic")
	uniform = /obj/item/clothing/under/rank/medical/scrubs/black
	suit = /obj/item/clothing/suit/storage/toggle/fr_jacket
	shoes = /obj/item/clothing/shoes/boots/jackboots
	l_hand = /obj/item/weapon/storage/firstaid/regular
	belt = /obj/item/weapon/storage/belt/medical/emt
	pda_slot = slot_l_store
	id_type = /obj/item/weapon/card/id/medical/paramedic
	flags = OUTFIT_HAS_BACKPACK|OUTFIT_EXTENDED_SURVIVAL

/decl/hierarchy/outfit/job/medical/paramedic/emt
	name = OUTFIT_JOB_NAME("Emergency Medical Technician")
	uniform = /obj/item/clothing/under/rank/medical/paramedic
	suit = /obj/item/clothing/suit/storage/toggle/labcoat/emt