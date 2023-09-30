/turf/closed
	reality_process_flags = REALITY_STABILAZE_PROCESS
	//Турфы не восстанавливаются сами по себе.
	reality_step = 0

/turf/closed/update_realistics_effects()
	. = ..()
	if(reality_density <= REALITY_LEVEL_HAVOC)
		opacity = FALSE
	if(reality_density <= REALITY_LEVEL_LOSE)
		density = FALSE

/turf/closed/reset_realistic_effects()
	. = ..()

/turf/closed/banish(force)
	. = ..()
	if(!force)
		animate(src, 3 SECONDS, alpha = 0)
	QDEL_IN(src, 3.5 SECONDS)
