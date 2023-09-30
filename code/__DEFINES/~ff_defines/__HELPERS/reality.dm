/**
 * Имеет ли стабильный уровень реальности атом.
 */
/proc/is_stable_atom(atom/target)
	if(target.reality_density == target.reality_level)
		return TRUE
	return FALSE
