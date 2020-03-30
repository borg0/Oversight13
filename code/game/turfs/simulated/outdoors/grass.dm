var/list/grass_types = list(

)

/turf/simulated/floor/outdoors/grass
	name = "grass"
	icon_state = "grass0"
	edge_blending_priority = 4
	can_build_onto = 1
	initial_flooring = /decl/flooring/grass/outdoors
	turf_layers = list(
		/turf/simulated/floor/outdoors/rocks,
		/turf/simulated/floor/outdoors/dirt
		)
	var/grass_chance = 20
	var/tree_chance = 2
	var/list/grass_types = list(
		/obj/structure/flora/ausbushes/sparsegrass,
		/obj/structure/flora/ausbushes/fullgrass
		)


/turf/simulated/floor/outdoors/grass/sif
	name = "growth"
	icon_state = "grass_sif"
	edge_blending_priority = 4
	grass_chance = 0


	grass_types = list(
		/obj/structure/flora/sif/eyes
		)

/turf/simulated/floor/outdoors/grass/sif/initialize()
	if(tree_chance && prob(tree_chance))
		new /obj/structure/flora/tree/sif(src)
	. = ..()

/turf/simulated/floor/outdoors/grass/initialize()
	icon_state = "grass[pick("0","1","2","3")]"

	if(tree_chance && prob(tree_chance))
		new /obj/structure/flora/tree/jungle(src)
	if(grass_chance && prob(grass_chance))
		var/grass_type = pick(grass_types)
		new grass_type(src)
	. = ..()

/turf/simulated/floor/outdoors/grass/forest
	name = "thick grass"
	icon_state = "grass-dark"
	grass_chance = 80
	tree_chance = 20
	edge_blending_priority = 5

/turf/simulated/floor/outdoors/grass/forest/nogrowth
	grass_chance = 0
	tree_chance = 0

/turf/simulated/floor/outdoors/grass/nogrowth
	grass_chance = 0
	tree_chance = 0

/turf/simulated/floor/outdoors/grass/sif/forest
	name = "thick growth"
	icon_state = "grass_sif_dark"
	edge_blending_priority = 5
	tree_chance = 10
	grass_chance = 0

