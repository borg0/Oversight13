#define DEBUG
// Turf-only flags.
#define NOJAUNT 1 // This is used in literally one place, turf.dm, to block ethereal jaunt.

#define TRANSITIONEDGE 7 // Distance from edge to move to another z-level.

// Radiation 'levels'. Used for the geiger counter, for visuals and sound. They are in different files so this goes here.
#define RAD_LEVEL_LOW 0.5 // Around the level at which radiation starts to become harmful
#define RAD_LEVEL_MODERATE 5
#define RAD_LEVEL_HIGH 25
#define RAD_LEVEL_VERY_HIGH 75

// Calculation modes for effective radiation
#define RAD_RESIST_CALC_DIV 0 // Each turf absorbs some fraction of the working radiation level
#define RAD_RESIST_CALC_SUB 1 // Each turf absorbs a fixed amount of radiation

// Invisibility constants.
#define INVISIBILITY_LIGHTING             20
#define INVISIBILITY_LEVEL_ONE            35
#define INVISIBILITY_LEVEL_TWO            45
#define INVISIBILITY_OBSERVER             60
#define INVISIBILITY_EYE		          61

#define SEE_INVISIBLE_LIVING              25
#define SEE_INVISIBLE_NOLIGHTING 15
#define SEE_INVISIBLE_LEVEL_ONE           35
#define SEE_INVISIBLE_LEVEL_TWO           45
#define SEE_INVISIBLE_CULT		          60
#define SEE_INVISIBLE_OBSERVER            61

#define SEE_INVISIBLE_MINIMUM 5
#define INVISIBILITY_MAXIMUM 100

// For the client FPS pref and anywhere else
#define MAX_CLIENT_FPS	200

// Some arbitrary defines to be used by self-pruning global lists. (see master_controller)
#define PROCESS_KILL 26 // Used to trigger removal from a processing list.
#define MAX_GEAR_COST 15 // Used in chargen for accessory loadout limit.

// For secHUDs and medHUDs and variants. The number is the location of the image on the list hud_list of humans.
#define      HEALTH_HUD 1 // A simple line rounding the mob's number health.
#define      STATUS_HUD 2 // Alive, dead, diseased, etc.
#define          ID_HUD 3 // The job asigned to your ID.
#define      WANTED_HUD 4 // Wanted, released, paroled, security status.
#define    IMPLOYAL_HUD 5 // Loyality implant.
#define     IMPCHEM_HUD 6 // Chemical implant.
#define    IMPTRACK_HUD 7 // Tracking implant.
#define SPECIALROLE_HUD 8 // AntagHUD image.
#define  STATUS_HUD_OOC 9 // STATUS_HUD without virus DB check for someone being ill.
#define 	  LIFE_HUD 10 // STATUS_HUD that only reports dead or alive
#define     TOTAL_HUDS 10 // Total number of HUDs. Like body layers, and other things, it comes up sometimes.

#define AREA_FLAG_IS_NOT_PERSISTENT 8 // SSpersistence will not track values from this area.

//	Shuttles.

// These define the time taken for the shuttle to get to the space station, and the time before it leaves again.
#define SHUTTLE_PREPTIME                300 // 5 minutes = 300 seconds - after this time, the shuttle departs centcom and cannot be recalled.
#define SHUTTLE_LEAVETIME               180 // 3 minutes = 180 seconds - the duration for which the shuttle will wait at the station after arriving.
#define SHUTTLE_TRANSIT_DURATION        300 // 5 minutes = 300 seconds - how long it takes for the shuttle to get to the station.
#define SHUTTLE_TRANSIT_DURATION_RETURN 120 // 2 minutes = 120 seconds - for some reason it takes less time to come back, go figure.

// Shuttle moving status.
#define SHUTTLE_IDLE      0
#define SHUTTLE_WARMUP    1
#define SHUTTLE_INTRANSIT 2

// Sound defines for shuttles.
#define HYPERSPACE_WARMUP    0
#define HYPERSPACE_PROGRESS  1
#define HYPERSPACE_END       2

// Ferry shuttle processing status.
#define IDLE_STATE   0
#define WAIT_LAUNCH  1
#define FORCE_LAUNCH 2
#define WAIT_ARRIVE  3
#define WAIT_FINISH  4

// Setting this much higher than 1024 could allow spammers to DOS the server easily.
#define MAX_MESSAGE_LEN       1024
#define MAX_PAPER_MESSAGE_LEN 6144
#define MAX_BOOK_MESSAGE_LEN  24576
#define MAX_RECORD_LENGTH	  24576
#define MAX_LNAME_LEN         64
#define MAX_NAME_LEN          52
#define MAX_TEXTFILE_LENGTH 128000		// 512GQ file

// Event defines.
#define EVENT_LEVEL_MUNDANE  1
#define EVENT_LEVEL_MODERATE 2
#define EVENT_LEVEL_MAJOR    3

//General-purpose life speed define for plants.
#define HYDRO_SPEED_MULTIPLIER 1

#define DEFAULT_JOB_TYPE /datum/job/assistant

//Area flags, possibly more to come
#define RAD_SHIELDED 1 //shielded from radiation, clearly

// Convoluted setup so defines can be supplied by Bay12 main server compile script.
// Should still work fine for people jamming the icons into their repo.
#ifndef CUSTOM_ITEM_OBJ
#define CUSTOM_ITEM_OBJ 'icons/obj/custom_items_obj.dmi'
#endif
#ifndef CUSTOM_ITEM_MOB
#define CUSTOM_ITEM_MOB 'icons/mob/custom_items_mob.dmi'
#endif
#ifndef CUSTOM_ITEM_SYNTH
#define CUSTOM_ITEM_SYNTH 'icons/mob/custom_synthetic.dmi'
#endif

#define WALL_CAN_OPEN 1
#define WALL_OPENING 2

#define DEFAULT_TABLE_MATERIAL "plastic"

#define MAT_STEEL			"steel"
#define MAT_GLASS			"glass"
#define MAT_SILVER			"silver"
#define MAT_GOLD			"gold"
#define MAT_TITANIUM		"titanium"
#define MAT_PHORON			"phoron"
#define MAT_DIAMOND			"diamond"
#define MAT_SNOW			"snow"
#define MAT_WOOD			"wood"
#define MAT_LOG				"log"
#define MAT_SIFWOOD			"alien wood"
#define MAT_SIFLOG			"alien log"

#define BOMBCAP_DVSTN_RADIUS (max_explosion_range/4)
#define BOMBCAP_HEAVY_RADIUS (max_explosion_range/2)
#define BOMBCAP_LIGHT_RADIUS max_explosion_range
#define BOMBCAP_FLASH_RADIUS (max_explosion_range*1.5)

// Special return values from bullet_act(). Positive return values are already used to indicate the blocked level of the projectile.
#define PROJECTILE_CONTINUE   -1 //if the projectile should continue flying after calling bullet_act()
#define PROJECTILE_FORCE_MISS -2 //if the projectile should treat the attack as a miss (suppresses attack and admin logs) - only applies to mobs.


// Vending stuff
#define CAT_NORMAL 1
#define CAT_HIDDEN 2
#define CAT_COIN   4

//Antag Faction Visbility
#define ANTAG_HIDDEN	"Hidden"
#define ANTAG_SHARED	"Shared"
#define ANTAG_KNOWN		"Known"

// Job groups
#define ROLE_COMMAND			"command"
#define ROLE_SECURITY			"security"
#define ROLE_ENGINEERING		"engineering"
#define ROLE_MEDICAL			"medical"
#define ROLE_RESEARCH			"research"
#define ROLE_CARGO				"cargo"
#define ROLE_CIVILIAN			"civilian"
#define ROLE_SYNTHETIC			"synthetic"
#define ROLE_UNKNOWN			"unknown"
#define ROLE_EVERYONE			"everyone"

// Canonical spellings of TSCs, so typos never have to happen again due to human error.
#define TSC_NT		"NanoTrasen"
#define TSC_HEPH	"Hephaestus" // Because everyone misspells it
#define TSC_VM		"Vey Med"
#define TSC_ZH		"Zeng-Hu"
#define TSC_WT		"Ward-Takahashi"
#define TSC_BC		"Bishop Cybernetics"
#define TSC_MORPH	"Morpheus"
#define TSC_XION	"Xion" // Not really needed but consistancy I guess.
#define TSC_GIL 	"Gilthari"

#define MIDNIGHT_ROLLOVER		864000	//number of deciseconds in a day

// Maploader bounds indices
#define MAP_MINX 1
#define MAP_MINY 2
#define MAP_MINZ 3
#define MAP_MAXX 4
#define MAP_MAXY 5
#define MAP_MAXZ 6

// /atom/proc/use_check flags
#define USE_ALLOW_NONLIVING 1
#define USE_ALLOW_NON_ADV_TOOL_USR 2
#define USE_ALLOW_DEAD 4
#define USE_ALLOW_INCAPACITATED 8
#define USE_ALLOW_NON_ADJACENT 16
#define USE_FORCE_SRC_IN_USER 32
#define USE_DISALLOW_SILICONS 64

#define USE_SUCCESS 0
#define USE_FAIL_NON_ADJACENT 1
#define USE_FAIL_NONLIVING 2
#define USE_FAIL_NON_ADV_TOOL_USR 3
#define USE_FAIL_DEAD 4
#define USE_FAIL_INCAPACITATED 5
#define USE_FAIL_NOT_IN_USER 6
#define USE_FAIL_IS_SILICON 7

#define CLICK_CD_FILL 3
#define CLICK_CD_MELEE 8
#define CLICK_CD_RANGE 4
#define CLICK_CD_BREAKOUT 100
#define CLICK_CD_HANDCUFFED 10
#define CLICK_CD_TKSTRANGLE 10
#define CLICK_CD_RESIST 20

// This creates a consistant definition for creating global lists, automatically inserting objects into it when they are created, and removing them when deleted.
// It is very good for removing the 'in world' junk that exists in the codebase painlessly.
// First argument is the list name/path desired, e.g. 'all_candles' would be 'var/list/all_candles = list()'.
// Second argument is the path the list is expected to contain. Note that children will also get added to the global list.
// If the GLOB system is ever ported, you can change this macro in one place and have less work to do than you otherwise would.
#define GLOBAL_LIST_BOILERPLATE(LIST_NAME, PATH)\
var/global/list/##LIST_NAME = list();\
##PATH/initialize(mapload, ...)\
	{\
	##LIST_NAME += src;\
	return ..();\
	}\
##PATH/Destroy(force, ...)\
	{\
	##LIST_NAME -= src;\
	return ..();\
	}\

//'Normal'ness						 v								 v								 v
//Various types of colorblindness	R2R		R2G		R2B		G2R		G2G		G2B		B2R		B2G		B2B
#define MATRIX_Monochromia 		list(0.33,	0.33,	0.33,	0.59,	0.59,	0.59,	0.11,	0.11,	0.11)
#define MATRIX_Protanopia 		list(0.57,	0.43, 	0,		0.56, 	0.44, 	0, 		0, 		0.24,	0.76)
#define MATRIX_Protanomaly 		list(0.82,	0.18, 	0,		0.33,	0.67, 	0, 		0, 		0.13,	0.88)
#define MATRIX_Deuteranopia 	list(0.63,	0.38, 	0,		0.70, 	0.30, 	0, 		0, 		0.30, 	0.70)
#define MATRIX_Deuteranomaly 	list(0.80, 	0.20, 	0,		0.26,	0.74,	0, 		0, 		0.14,	0.86)
#define MATRIX_Tritanopia 		list(0.95, 	0.05, 	0,		0,		0.43, 	0.57,	0, 		0.48, 	0.53)
#define MATRIX_Tritanomaly 		list(0.97,	0.03, 	0,		0,		0.73, 	0.27,	0, 		0.18,	0.82)
#define MATRIX_Achromatopsia 	list(0.30,	0.59, 	0.11, 	0.30, 	0.59, 	0.11, 	0.30, 	0.59, 	0.11)
#define MATRIX_Achromatomaly 	list(0.62,	0.32, 	0.06, 	0.16, 	0.78, 	0.06, 	0.16, 	0.32, 	0.52)
#define MATRIX_Vulp_Colorblind 	list(0.50,	0.40,	0.10,	0.50,	0.40,	0.10,	0,		0.20,	0.80)
#define MATRIX_Taj_Colorblind 	list(0.40,	0.20,	0.40,	0.40,	0.60,	0,		0.20,	0.20,	0.60)

#define NTNET_SOFTWAREDOWNLOAD 1 	// Downloads of software from NTNet
#define NTNET_PEERTOPEER 2			// P2P transfers of files between devices
#define NTNET_COMMUNICATION 3		// Communication (messaging)
#define NTNET_SYSTEMCONTROL 4		// Control of various systems, RCon, air alarm control, etc.

// NTNet transfer speeds, used when downloading/uploading a file/program.
#define NTNETSPEED_LOWSIGNAL 0.025	// GQ/s transfer speed when the device is wirelessly connected and on Low signal
#define NTNETSPEED_HIGHSIGNAL 0.1	// GQ/s transfer speed when the device is wirelessly connected and on High signal
#define NTNETSPEED_ETHERNET 0.5		// GQ/s transfer speed when the device is using wired connection

// Program bitflags
#define PROGRAM_ALL 		0x1F
#define PROGRAM_CONSOLE 	0x1
#define PROGRAM_LAPTOP 		0x2
#define PROGRAM_TABLET 		0x4
#define PROGRAM_TELESCREEN 	0x8
#define PROGRAM_PDA 		0x10

#define PROGRAM_STATE_KILLED 0
#define PROGRAM_STATE_BACKGROUND 1
#define PROGRAM_STATE_ACTIVE 2

// Caps for NTNet logging. Less than 10 would make logging useless anyway, more than 500 may make the log browser too laggy. Defaults to 100 unless user changes it.
#define MAX_NTNET_LOGS 500
#define MIN_NTNET_LOGS 10

//https://secure.byond.com/docs/ref/info.html#/atom/var/mouse_opacity
#define MOUSE_OPACITY_TRANSPARENT 0
#define MOUSE_OPACITY_ICON 1
#define MOUSE_OPACITY_OPAQUE 2

#define PREF_SAVELOAD_COOLDOWN 5

#ifndef WINDOWS_HTTP_POST_DLL_LOCATION
#define WINDOWS_HTTP_POST_DLL_LOCATION "lib/byhttp.dll"
#endif

#ifndef UNIX_HTTP_POST_DLL_LOCATION
#define UNIX_HTTP_POST_DLL_LOCATION "lib/libbyhttp.so"
#endif

#ifndef HTTP_POST_DLL_LOCATION
#define HTTP_POST_DLL_LOCATION (world.system_type == MS_WINDOWS ? WINDOWS_HTTP_POST_DLL_LOCATION : UNIX_HTTP_POST_DLL_LOCATION)
#endif

#define DMM_IGNORE_AREAS (1<<0)
#define DMM_IGNORE_TURFS (1<<1)
#define DMM_IGNORE_OBJS (1<<2)
#define DMM_IGNORE_NPCS (1<<3)
#define DMM_IGNORE_PLAYERS (1<<4)
#define DMM_IGNORE_MOBS (1<<5)
#define DMM_USE_JSON (1<<6)

// Paperwork categories

#define PAPERWORK_MISC "Miscellaneous"
#define PAPERWORK_POLICE "Police"
#define PAPERWORK_COUNCIL "Council"
#define PAPERWORK_LEGAL "Legal"
#define PAPERWORK_SCIENCE "Science"
#define PAPERWORK_BUSINESS "Business"
#define PAPERWORK_MEDICAL "Medical"
#define PAPERWORK_GOVERNMENT "Government"

//

#define MAX_WARRANTS 50
#define MAX_FINGERPRINTS 20