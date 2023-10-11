//Этот компонент обеспечивает отторжение органа, если он не подходит установленному биотипу.
/datum/component/organ_rejection
	var/special_biotype
	var/process_life

/datum/component/organ_rejection/Initialize(special_biotype)
	. = ..()
	if(!istype(parent, /obj/item/organ))
		return COMPONENT_INCOMPATIBLE
	src.special_biotype = special_biotype

	RegisterWithParent()

/datum/component/organ_rejection/RegisterWithParent()
	. = ..()
	RegisterSignal(parent, COMSIG_ORGAN_IMPLANTED, PROC_REF(organ_insert))
	RegisterSignal(parent, COMSIG_ORGAN_REMOVED, PROC_REF(organ_remove))

/datum/component/organ_rejection/Destroy(force, silent)
	. = ..()

/datum/component/organ_rejection/proc/check_biotypes(mob/living/carbon/organ_owner)
	if(!iscarbon(organ_owner))
		return FALSE
	if(!special_biotype)
		return FALSE
	if(!organ_owner.mob_biotypes & special_biotype)
		return FALSE
	return TRUE

/datum/component/organ_rejection/proc/organ_insert(mob/living/carbon/receiver)
	SIGNAL_HANDLER
	if(check_biotypes(receiver))
		return
	var/obj/item/organ/attached_organ = parent
	attached_organ.organ_flags |= ORGAN_FAILING
	attached_organ.healing_factor = 0


/datum/status_effect/organ_rejection
	id = "rejected_organ"

