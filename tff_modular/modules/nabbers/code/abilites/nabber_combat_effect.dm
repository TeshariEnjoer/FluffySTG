#define NABBER_THREAT_ICON 'tff_modular/modules/nabbers/icons/effects.dmi'
#define NABBER_THREAT_ICON_STATE "nabber_threat"

/datum/status_effect/nabber_combat
	id = "Nabber combat"
	alert_type = null
	status_type = STATUS_EFFECT_UNIQUE
	tick_interval = -1
	var/image/nabber_image

/datum/status_effect/nabber_combat/on_apply()
	nabber_image = image(NABBER_THREAT_ICON, owner, NABBER_THREAT_ICON_STATE, dir = owner.dir)
	nabber_image.override = TRUE
	nabber_image.alpha = 0
	animate(nabber_image, alpha = 255, 0.2 SECONDS)
	owner.add_alt_appearance(/datum/atom_hud/alternate_appearance/basic/everyone, id, nabber_image)

	RegisterSignal(owner, COMSIG_ATOM_DIR_CHANGE, PROC_REF(on_dir_change))
	RegisterSignal(owner, COMSIG_LIVING_SET_BODY_POSITION, PROC_REF(on_body_position_change))
	return TRUE

/datum/status_effect/nabber_combat/on_remove()
	owner.remove_alt_appearance(id)
	QDEL_NULL(nabber_image)

	UnregisterSignal(owner, list(
		COMSIG_ATOM_DIR_CHANGE,
		COMSIG_LIVING_SET_BODY_POSITION
	))

/datum/status_effect/nabber_combat/proc/on_dir_change(datum/source, old_dir, new_dir)
	SIGNAL_HANDLER

	nabber_image.dir = new_dir

/datum/status_effect/nabber_combat/proc/on_body_position_change(datum/source, new_value, old_value)
	SIGNAL_HANDLER

	if(new_value == LYING_DOWN)
		nabber_image.transform = turn(nabber_image.transform, 90)
	else
		nabber_image.transform = turn(nabber_image.transform, -90)

#undef NABBER_THREAT_ICON
#undef NABBER_THREAT_ICON_STATE
