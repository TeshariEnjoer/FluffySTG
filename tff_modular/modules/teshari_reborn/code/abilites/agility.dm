<<<<<<< HEAD
#define AGILITY_DEFAULT_COOLDOWN_TIME 4 SECONDS
=======
#define AGILITY_DEFAULT_COOLDOWN_TIME 1 SECONDS
>>>>>>> master
#define AGILITY_MODE_ABOVE "agility_mode_above"
#define AGILITY_MODE_BELOW "agility_mode_below"
#define AGILITY_MODE_IGNORE "agility_mode_ignore"

/datum/action/cooldown/teshari/agility
	name = "Toggle agility"
	desc = "Toggle you agility"
	cooldown_time = AGILITY_DEFAULT_COOLDOWN_TIME
<<<<<<< HEAD
=======

/datum/action/cooldown/teshari/agility/New(Target, original)
	. = ..()
>>>>>>> master
	current_mode = AGILITY_MODE_IGNORE
	button_icon_state = AGILITY_MODE_IGNORE

/datum/action/cooldown/teshari/agility/Activate(atom/target)
	. = ..()
<<<<<<< HEAD

	if(current_mode == AGILITY_MODE_IGNORE)
		update_button_state(AGILITY_MODE_ABOVE)
		owner.balloon_alert(owner, "Moving above!")
		passtable_on(owner, INNATE_TRAIT)
		current_mode = AGILITY_MODE_ABOVE

	else if(current_mode == AGILITY_MODE_ABOVE)
		update_button_state(AGILITY_MODE_IGNORE)
		owner.balloon_alert(owner, "Ignoring!")
		passtable_off(owner, INNATE_TRAIT)
		current_mode = AGILITY_MODE_IGNORE

=======
	var/list/modes = list(
		AGILITY_MODE_ABOVE = image(icon = 'tff_modular/modules/teshari_reborn/icons/actions.dmi', icon_state = AGILITY_MODE_ABOVE),
		AGILITY_MODE_BELOW = image(icon = 'tff_modular/modules/teshari_reborn/icons/actions.dmi', icon_state = AGILITY_MODE_BELOW),
		AGILITY_MODE_IGNORE = image(icon = 'tff_modular/modules/teshari_reborn/icons/actions.dmi', icon_state = AGILITY_MODE_IGNORE),
	)
	var/selected_mode = show_radial_menu(owner, owner, modes, require_near = TRUE)
	if(!selected_mode || selected_mode == current_mode)
		owner.balloon_alert(owner, "Disabled!")
		owner.pass_flags = initial(owner.pass_flags)
		owner.layer = initial(owner.layer)
		update_button_state(AGILITY_MODE_IGNORE)
		current_mode = AGILITY_MODE_IGNORE
		return TRUE

	switch(selected_mode)
		if(AGILITY_MODE_IGNORE)
			update_button_state(AGILITY_MODE_IGNORE)
			owner.balloon_alert(owner, "Ignoring!")
			owner.pass_flags = initial(owner.pass_flags)
			owner.layer = initial(owner.layer)

		if(AGILITY_MODE_ABOVE)
			update_button_state(AGILITY_MODE_ABOVE)
			owner.balloon_alert(owner, "Moving above!")
			owner.layer = initial(owner.layer)
			owner.pass_flags += PASSTABLE

		if(AGILITY_MODE_BELOW)
			update_button_state(AGILITY_MODE_BELOW)
			owner.balloon_alert(owner, "Moving below!")
			if(!(owner.pass_flags & PASSTABLE))
				owner.pass_flags += PASSTABLE
			owner.layer = ABOVE_NORMAL_TURF_LAYER

	current_mode = selected_mode
>>>>>>> master
	return TRUE

#undef AGILITY_DEFAULT_COOLDOWN_TIME
#undef AGILITY_MODE_ABOVE
#undef AGILITY_MODE_BELOW
#undef AGILITY_MODE_IGNORE

