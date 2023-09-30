/atom/
	//Максимальный уровень реальности атома.
	var/reality_level
	//Уровень дамба в данный момент.
	var/reality_density
	//Шаг изменения плотности реальности к уровню.
	var/reality_step = REALITY_STEP_CHANGE_NORMAL
	//Флаг процессинга реальности, по умолчанию, атомы не обрабатывают их уровень реальности, пока что-либо не потревожит спокойствие, вызвав обновление флагов.
	var/reality_process_flags = REALITY_NO_PROCESS

/atom/proc/set_reality_level(new_value)
	reality_level = new_value

/atom/proc/set_reality_density(new_value)
	reality_density = new_value

/atom/proc/reset_realistic_effects()
	return

/atom/proc/update_realistics_effects()
	return

/atom/proc/banish(force = FALSE)
	return
