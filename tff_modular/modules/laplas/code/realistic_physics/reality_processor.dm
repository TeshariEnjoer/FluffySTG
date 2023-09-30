
/datum/element/reality_processing
	element_flags = ELEMENT_DETACH_ON_HOST_DESTROY
	//Цель обработки реальности.
	var/datum/weakref/handle_atom
	//Должны ли мы постоянно обрабатывать уровень, только для карбонов и хуманов.
	var/always_process = FALSE
	//Модификаторы уровня реальности.
	var/list/datum/reality_modifaer/modifaers = list()

/datum/element/reality_processing/source
	//Тип модификатора реальности, что будет накладывать источник
	var/datum/reality_modifaer/modifaer_type
	//Цели для изменения реальности. Может быть чем угодно.
	var/list/target

/datum/element/reality_processing/source/Attach(datum/target, level, power)
	. = ..()
	handle_atom = target
	SSreality_physic.processing_sources |= src
	message_admins("New source of reality created [target]!")

/datum/element/reality_processing/source/Detach(datum/source, ...)
	. = ..()
	SSreality_physic.processing_sources -= src

//Модификаторы, существует до момента достижения уровня реальности, или указанное время.
/datum/reality_modifaer
	//Уровень и плотность, к которым будет стримиться атом.
	var/density_modifaer
	var/reality_modifaer

	//Время действия модификатора, если не указано, то модификатор будет удален сразу после применения.
	var/duration

/datum/reality_modifaer/New(density, level, duration, source)
	. = ..()
	density_modifaer = density
	reality_modifaer = level
	if(duration)
		src.duration = duration
		QDEL_IN(src, duration)
