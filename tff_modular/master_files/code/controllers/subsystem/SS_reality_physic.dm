/**
 * 				Подсистема физики реальности
 * Эта подсистема обрабатывает взаимодействия с уровнями реальности всех атомов в мире.
 * Если уровень реальности атома был изменён.
 *
 */

SUBSYSTEM_DEF(reality_physic)
	name = "Anomalistic - reality"
	flags = SS_BACKGROUND | SS_NO_INIT

	wait = 2.5 SECONDS

	//Перечень всех атомов, чья механика реальности процессиируется в данный момент.
	var/list/datum/element/reality_processing/processing_atoms = list()
	//Перечь всех источников активного изменения реальности.
	var/list/datum/element/reality_processing/source/processing_sources = list()

/datum/controller/subsystem/reality_physic/fire(resumed)

	for(var/datum/element/reality_processing/P in processing_atoms)
		var/datum/weakref/target_ref = P.handle_atom
		var/atom/target = target_ref.resolve()

		if(MC_TICK_CHECK)
			return

		handle_reality(target, P)

/datum/controller/subsystem/reality_physic/proc/handle_reality(atom/target, datum/element/reality_processing/data)
	if((target.reality_process_flags == REALITY_STABILAZE_PROCESS) && is_stable_atom(target))
		processing_atoms -= data
		qdel(data)
		return
	if(SEND_SIGNAL(target, COMSIG_ATOM_TRY_REALITY_PROCESS, data) & COMSIG_ATOM_REALITY_PROCESS_BLOCK)
		return
	var/target_level = target.reality_level
	var/target_density = target.reality_density

	if(data.modifaers)
		for(var/datum/reality_modifaer/mod in data.modifaers)
			target_level += mod.reality_modifaer
			target_density += mod.density_modifaer
			if(!mod.duration)
				qdel(mod)

	target.set_reality_level(target_level)
	target.set_reality_density(min((target_density + target.reality_step), target.reality_level))

	if(target.reality_density <= REALITY_LEVEL_BANISH)
		target.banish()
		processing_atoms -= data
		qdel(data)
		return

	if(target.reality_density <= REALITY_LEVEL_HAVOC)
		animate(target, target.reality_level, TRUE, alpha = (255 - (target.reality_density * 100)))
	else
		target.reset_realistic_effects()

	target.update_realistics_effects()
	if(MC_TICK_CHECK)
		return
