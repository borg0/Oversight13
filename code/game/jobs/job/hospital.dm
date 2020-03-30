/datum/job/cmo
	title = "Medical Director"
	flag = CMO
	head_position = 1
	department_flag = MEDSCI
	department = DEPT_COUNCIL
	faction = "City"
	total_positions = 1
	spawn_positions = 1
	email_domain = "med.gov.nt"
	supervisors = "the Mayor"
	selection_color = "#026865"
	idtype = /obj/item/weapon/card/id/medical/head
	req_admin_notify = 1
	wage = 540
	access = list(access_medical, access_medical_equip, access_morgue, access_genetics, access_heads,
			access_chemistry, access_virology, access_cmo, access_surgery, access_RC_announce,
			access_keycard_auth, access_sec_doors, access_psychiatrist, access_eva, access_external_airlocks, access_maint_tunnels)
	minimal_access = list(access_medical, access_medical_equip, access_morgue, access_genetics, access_heads,
			access_chemistry, access_virology, access_cmo, access_surgery, access_RC_announce,
			access_keycard_auth, access_sec_doors, access_psychiatrist, access_eva, access_external_airlocks, access_maint_tunnels)

	minimum_character_age = 30
	minimal_player_age = 3
	ideal_character_age = 50

	outfit_type = /decl/hierarchy/outfit/job/medical/cmo
	alt_titles = list(
		"Chief of Medicine", "Hospital Administrator")
	clean_record_required = TRUE

/datum/job/cmo/get_job_email()	// whatever this is set to will be the job's communal email. should be persistent.
	return using_map.council_email

/datum/job/doctor
	title = "Physician"
	email_domain = "med.gov.nt"
	flag = DOCTOR
	department_flag = MEDSCI
	department = DEPT_HEALTHCARE
	faction = "City"
	total_positions = 5
	spawn_positions = 3
	supervisors = "the chief medical officer"
	selection_color = "#013D3B"
	idtype = /obj/item/weapon/card/id/medical/doctor
	wage = 80
	minimum_character_age = 25
	access = list(access_medical, access_medical_equip, access_morgue, access_surgery, access_chemistry, access_virology, access_eva)
	minimal_access = list(access_medical, access_medical_equip, access_morgue, access_surgery, access_virology, access_eva)
	outfit_type = /decl/hierarchy/outfit/job/medical/doctor
	alt_titles = list(
		"Surgeon" = /decl/hierarchy/outfit/job/medical/doctor/surgeon,
		"Emergency Physician" = /decl/hierarchy/outfit/job/medical/doctor/emergency_physician,
		"Nurse" = /decl/hierarchy/outfit/job/medical/doctor/nurse,
		"Coroner" = /decl/hierarchy/outfit/job/medical/doctor/surgeon)

	clean_record_required = TRUE

//Chemist is a medical job damnit	//YEAH FUCK YOU SCIENCE	-Pete	//Guys, behave -Erro // Chemistry does more actual science than RnD at this point. But I'm glad you took time to bicker about which file it should go in instead of properly organizing the parenting. - Nappist
/datum/job/geneticist
	title = "Geneticist"
	flag = GENETICIST
	department = DEPT_HEALTHCARE
	department_flag = MEDSCI
//	faction = "City"
	total_positions = 0
	spawn_positions = 0
	supervisors = "your private company director"
	selection_color = "#013D3B"
	idtype = /obj/item/weapon/card/id/medical/geneticist
	wage = 60
	access = list(access_genetics)
	minimal_access = list(access_genetics)

	outfit_type = /decl/hierarchy/outfit/job/medical/geneticist

/datum/job/paramedic
	title = "Paramedic"
	email_domain = "cityworks.gov.nt"
	flag = PARAMEDIC
	department_flag = MEDSCI
	department = DEPT_HEALTHCARE
	faction = "City"
	total_positions = 2
	spawn_positions = 2
	supervisors = "the medical director"
	selection_color = "#5B4D20"
	idtype = /obj/item/weapon/card/id/medical/paramedic
	wage = 80
	access = list(access_medical, access_medical_equip, access_morgue, access_surgery, access_chemistry, access_virology, access_eva)
	minimal_access = list(access_medical, access_medical_equip, access_morgue, access_surgery, access_virology, access_eva)
	outfit_type = /decl/hierarchy/outfit/job/medical/paramedic
	alt_titles = list("Emergency Medical Technician" = /decl/hierarchy/outfit/job/medical/paramedic/emt)