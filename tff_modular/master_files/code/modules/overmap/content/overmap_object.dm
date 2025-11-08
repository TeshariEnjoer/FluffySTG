/datum/overmap_object
	// Unique ID for identification, tracking, and serialization.
	VAR_PROTECTED/id

	// Position in overmap space (2D vector for simplicity; assume z=0 or handle in subclasses).
	VAR_PROTECTED/datum/vector2/origin

	// Velocity vector (speed and direction).
	VAR_PROTECTED/datum/vector2/velocity

	// Acceleration vector (for forces like thrust, gravity).
	VAR_PROTECTED/datum/vector2/acceleration

	// Mass for physics calculations (affects momentum, gravity).
	var/mass = 1

	// Radius or size for collision detection (simple circle approx).
	var/radius = 1

	// Flags for behavior (e.g., static, movable, gravitational source).
	var/flags = NONE

	var/id_prefix = "overmap"

/datum/overmap_object/New(datum/vector2/_origin, datum/vector2/_velocity, _id)
	if(!_id)
		id = "[id_prefix]_[SSovermap.rent_id()]"
	else
		id = _id
	origin = _origin || new /datum/vector2(0, 0)
	velocity = _velocity || new /datum/vector2(0, 0)
	acceleration = new /datum/vector2(0, 0)


.
/datum/overmap_object/proc/Initialize()
	RegisterWithSubsystem()
	RegisterSignals()


/datum/overmap_object/proc/RegisterWithSubsystem()



/datum/overmap_object/proc/RegisterSignals()
	RegisterSignal(src, COMSIG_OVERMAP_FORCE, PROC_REF(apply_force))



/datum/overmap_object/proc/process(delta_time)
	if(flags & OVERMAP_STATIC)
		return


	velocity.add(acceleration.multiplied(delta_time))
	origin.add(velocity.multiplied(delta_time))
	acceleration.zero()


// Apply external force (e.g., thrust, gravity).
// Force is vector; convert to accel = force / mass.
/datum/overmap_object/proc/apply_force(datum/source, datum/vector2/force)
	SIGNAL_HANDLER
	acceleration.add(force.divided(mass)) // a = F/m.




/datum/overmap_object/proc/check_collision()
	var/list/nearby = SSovermap.GetNearbyObjects(src)
	for(var/datum/overmap_object/other in nearby)
		var/dist_sq = origin.distance_to_squared(other.origin)
		var/rad_sum = radius + other.radius
		if(dist_sq <= (rad_sum * rad_sum))
			SEND_SIGNAL(src, COMSIG_OVERMAP_COLLISION, other)
		else if(dist_sq <= (rad_sum * 2) ** 2) // Arbitrary proximity range.
			SEND_SIGNAL(src, COMSIG_OVERMAP_PROXIMITY, other, sqrt(dist_sq))
