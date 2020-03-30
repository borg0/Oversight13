/datum/category_item/player_setup_item/player_global/ooc
	name = "OOC"
	sort_order = 4

/datum/category_item/player_setup_item/player_global/ooc/load_preferences(var/savefile/S)
	S["ignored_players"]	  >> pref.ignored_players
	S["first_seen"]		  >> pref.first_seen
	S["last_seen"]		  >> pref.last_seen
	S["ips_associated"]  	  >> pref.ips_associated
	S["cids_associated"]   	  >> pref.cids_associated
	S["characters_created"]   >> pref.characters_created
	
/datum/category_item/player_setup_item/player_global/ooc/save_preferences(var/savefile/S)
	S["ignored_players"]	  << pref.ignored_players
	S["first_seen"]		  << pref.first_seen
	S["last_seen"]		  << pref.last_seen
	S["ips_associated"]  	  << pref.ips_associated
	S["cids_associated"]   	  << pref.cids_associated
	S["characters_created"]   << pref.characters_created
	
/datum/category_item/player_setup_item/player_global/ooc/sanitize_preferences()
	if(isnull(pref.ignored_players))
		pref.ignored_players = list()

	if(!pref.first_seen)
		pref.first_seen = full_real_time()
	if(!pref.last_seen)
		pref.last_seen = full_real_time()

	if(isnull(pref.cids_associated) || !islist(pref.cids_associated))
		pref.cids_associated = list()

	if(isnull(pref.ips_associated) || !islist(pref.ips_associated))
		pref.ips_associated = list()

	if(isnull(pref.characters_created))
		pref.characters_created = list()
/*
/datum/category_item/player_setup_item/player_global/ooc/content(var/mob/user)
	. += "<b>OOC:</b><br>"
	. += "Ignored Players<br>"
	for(var/ignored_player in pref.ignored_players)
		. += "[ignored_player] (<a href='?src=\ref[src];unignore_player=[ignored_player]'>Unignore</a>)<br>"
	. += "(<a href='?src=\ref[src];ignore_player=1'>Ignore Player</a>)"

/datum/category_item/player_setup_item/player_global/ooc/OnTopic(var/href,var/list/href_list, var/mob/user)
	if(href_list["unignore_player"])
		if(CanUseTopic(user))
			pref.ignored_players -= href_list["unignore_player"]
			return TOPIC_REFRESH

	if(href_list["ignore_player"])
		if(CanUseTopic(user))
			var/player_to_ignore = input(user, "Who do you want to ignore?","Ignore") as null|text
			if(player_to_ignore)
				player_to_ignore = sanitize(ckey(player_to_ignore))
				if(player_to_ignore == user.ckey)
					user <<"<span class='notice'>You can't ignore yourself.</span>"
					return TOPIC_REFRESH
				pref.ignored_players |= player_to_ignore
			return TOPIC_REFRESH

	return ..()
*/
