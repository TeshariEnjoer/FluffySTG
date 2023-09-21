/datum/action/toggle_welding
	name = "Toggle welding shield"
	desc = "Toggle your eyes welding shield"

	var/obj/item/organ/internal/eyes/robotic/nabber/eyes

/datum/action/toggle_welding/Trigger(trigger_flags)
	. = ..()
	eyes.toggle_shielding()
<<<<<<< HEAD
=======

/datum/action/toggle_welding/Destroy()
	. = ..()
	eyes = null
>>>>>>> 832b06a396bfa66225e5402854c282ad4091f574
