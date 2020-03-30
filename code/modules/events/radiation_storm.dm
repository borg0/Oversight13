/datum/event/radiation_storm
	var/const/enterBelt		= 30
	var/const/radIntervall 	= 5	// Enough time between enter/leave belt for 10 hits, as per original implementation
	var/const/leaveBelt		= 80
	var/const/revokeAccess	= 165
	startWhen				= 2
	announceWhen			= 1
	endWhen					= revokeAccess
	var/postStartTicks 		= 0

/datum/event/radiation_storm/announce()
	command_announcement.Announce("High levels of radiation detected near the city. Please stay indoors.", "Anomaly Alert", new_sound = 'sound/AI/radiation.ogg')

/datum/event/radiation_storm/start()
	make_maint_all_access()

/datum/event/radiation_storm/tick()
	if(activeFor == enterBelt)
		command_announcement.Announce("The radiation storm has arrived. Please remain in a sheltered area until the storm has passed.", "Anomaly Alert")
		for(var/datum/planet/planet in SSplanets.planets)
			planet.weather_holder.change_weather(WEATHER_RADSTORM)
		radiate()

	if(activeFor >= enterBelt && activeFor <= leaveBelt)
		postStartTicks++

	if(postStartTicks == radIntervall)
		postStartTicks = 0
		radiate()

	else if(activeFor == leaveBelt)
		command_announcement.Announce("The radiation storm has cleared the city. Please allow for up to one minute while radiation levels dissipate, and report to the hospital if you experience any unusual symptoms.", "Anomaly Alert")
		for(var/datum/planet/planet in SSplanets.planets)
			planet.weather_holder.change_weather(WEATHER_ACID_RAIN)

/datum/event/radiation_storm/proc/radiate()
	var/radiation_level = rand(15, 35)
	for(var/z in using_map.station_levels)
		SSradiation.z_radiate(locate(1, 1, z), radiation_level, 1)

	for(var/mob/living/carbon/C in living_mob_list)
		var/area/A = get_area(C)
		if(!A)
			continue
		if(A.flags & RAD_SHIELDED)
			continue
		if(istype(C,/mob/living/carbon/human))
			var/mob/living/carbon/human/H = C
			if(prob(5))
				if (prob(75))
					randmutb(H) // Applies bad mutation
					domutcheck(H,null,MUTCHK_FORCED)
				else
					randmutg(H) // Applies good mutation
					domutcheck(H,null,MUTCHK_FORCED)

/datum/event/radiation_storm/end()
	revoke_maint_all_access()

/datum/event/radiation_storm/syndicate/radiate()
	return
