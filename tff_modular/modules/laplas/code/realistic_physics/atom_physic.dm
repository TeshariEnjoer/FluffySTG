/**
 * Возращает уровень процессор реальности, если его нет, ложь.
 */
/atom/proc/get_reality_processor()
	var/datum/element/reality_processing/processor = SSdcs.GetElement(/datum/element/reality_processing, FALSE)
	return processor || FALSE

/atom/proc/modify_reality(datum/reality_modifaer/modifaer, density, level, effect_time)
	if(!SSreality_physic.can_fire)
		return
	if(reality_process_flags == REALITY_NO_PROCESS)
		return
	var/datum/element/reality_processing/processor = get_reality_processor()

	if(processor)

		if(modifaer)
			processor.modifaers += modifaer
			return
		//Созданем модификатор из имеющихся данных.
		var/datum/reality_modifaer/mod = new(density, level, effect_time)
		processor.modifaers += mod
		return

	//Буквально дублирование кода выше...
	processor = new()
	if(modifaer)
		processor.modifaers += modifaer
		return
	var/datum/reality_modifaer/mod = new(density, level, effect_time)


	processor.modifaers += mod
	processor.handle_atom = src
	SSreality_physic.processing_atoms |= processor
