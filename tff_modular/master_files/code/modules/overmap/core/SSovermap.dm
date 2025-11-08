SUBSYSTEM_DEF(overmap)

	name = "\imporer Overmap core"

	wait =  10

	// All overmap objects
	VAR_PRIVATE/list/all_overmap_objects
	// All overmap objects that's currently processing
	VAR_PRIVATE/list/processed_overmap_objects
	// All static overmap objects
	VAR_PRIVATE/list/static_overmap_objects

	// A assoc list of  [1,1] -> /datum/spatial_overmap_cell
	VAR_PRIVATE/list/space_map

	VAR_PRIVATE/next_id = 1

/datum/controller/subsystem/overmap/Initialize()


/datum/controller/subsystem/overmap/rent_id()
	var/new_id = next_id
	next_id += 1
	return new_id





// Spatial cell datum.
/datum/spatial_overmap_cell
	// Cell coordinates
	var/x
	var/y
	// Key for quick lookup (redundant but for speed)
	var/key
	// Content: list of /datum/overmap_object (weakrefs?)
	var/list/content = list()

/datum/spatial_overmap_cell/New(_x, _y)
	x = _x
	y = _y
	key = "[x],[y]"
	content = list()

/datum/spatial_overmap_cell/Destroy()
	content = null
	return ..()
