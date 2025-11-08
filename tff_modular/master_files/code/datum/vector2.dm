// Basic vector2 datum
/datum/vector2
	var/x = 0
	var/y = 0

/datum/vector2/New(_x = 0, _y = 0)
	x = _x
	y = _y

// Addition: Adds another vector to this one (mutable)
/datum/vector2/proc/add(datum/vector2/other)
	x += other.x
	y += other.y
	return src

// Addition: Returns a new vector that is the sum of this and another (immutable)
/datum/vector2/proc/added(datum/vector2/other)
	return new /datum/vector2(x + other.x, y + other.y)

// Subtraction: Subtracts another vector from this one (mutable)
/datum/vector2/proc/subtract(datum/vector2/other)
	x -= other.x
	y -= other.y
	return src

// Subtraction: Returns a new vector that is this minus another (immutable)
/datum/vector2/proc/subtracted(datum/vector2/other)
	return new /datum/vector2(x - other.x, y - other.y)

// Scalar multiplication: Multiplies this vector by a scalar (mutable)
/datum/vector2/proc/multiply(scalar)
	x *= scalar
	y *= scalar
	return src

// Scalar multiplication: Returns a new vector scaled by a scalar (immutable)
/datum/vector2/proc/multiplied(scalar)
	return new /datum/vector2(x * scalar, y * scalar)

// Scalar division: Divides this vector by a scalar (mutable, avoids div0)
/datum/vector2/proc/divide(scalar)
	if(scalar == 0)
		return src // Avoid div0, no-op
	x /= scalar
	y /= scalar
	return src

// Scalar division: Returns a new vector divided by a scalar (immutable, avoids div0)
/datum/vector2/proc/divided(scalar)
	if(scalar == 0)
		return new /datum/vector2(x, y) // Avoid div0, return copy
	return new /datum/vector2(x / scalar, y / scalar)

// Dot product: Computes the dot product with another vector (scalar result)
/datum/vector2/proc/dot(datum/vector2/other)
	return (x * other.x) + (y * other.y)

// Cross product (2D): Computes the scalar cross product (x1*y2 - y1*x2), useful for torque or perpendicularity
/datum/vector2/proc/cross(datum/vector2/other)
	return (x * other.y) - (y * other.x)

// Magnitude: Returns the length of the vector
/datum/vector2/proc/magnitude()
	return sqrt((x * x) + (y * y))

// Magnitude squared: Returns the squared length (faster for comparisons)
/datum/vector2/proc/magnitude_squared()
	return (x * x) + (y * y)

// Normalization: Normalizes this vector to unit length (mutable, avoids div0)
/datum/vector2/proc/normalize()
	var/mag = magnitude()
	if(mag == 0)
		return src
	x /= mag
	y /= mag
	return src

// Normalization: Returns a new normalized unit vector (immutable, avoids div0)
/datum/vector2/proc/normalized()
	var/mag = magnitude()
	if(mag == 0)
		return new /datum/vector2(0, 0)
	return new /datum/vector2(x / mag, y / mag)

// Angle to: Returns the angle in radians between this and another vector
/datum/vector2/proc/angle_to(datum/vector2/other)
	var/dot_prod = dot(other)
	var/mag_prod = magnitude() * other.magnitude()
	if(mag_prod == 0)
		return 0
	return arccos(dot_prod / mag_prod)

// Angle: Returns the direction angle of this vector in radians (from positive x-axis)
/datum/vector2/proc/angle()
	return arctan(y, x)

// Rotation: Rotates this vector by an angle in radians (mutable)
/datum/vector2/proc/rotate(angle)
	var/cos_a = cos(angle)
	var/sin_a = sin(angle)
	var/new_x = (x * cos_a) - (y * sin_a)
	var/new_y = (x * sin_a) + (y * cos_a)
	x = new_x
	y = new_y
	return src

// Rotation: Returns a new vector rotated by an angle in radians (immutable)
/datum/vector2/proc/rotated(angle)
	var/cos_a = cos(angle)
	var/sin_a = sin(angle)
	return new /datum/vector2((x * cos_a) - (y * sin_a), (x * sin_a) + (y * cos_a))

// Projection: Projects this vector onto another (returns new vector)
/datum/vector2/proc/project_onto(datum/vector2/other)
	var/dot_prod = dot(other)
	var/other_mag_sq = other.magnitude_squared()
	if(other_mag_sq == 0)
		return new /datum/vector2(0, 0)
	var/scalar = dot_prod / other_mag_sq
	return other.multiplied(scalar)

// Perpendicular: Returns a new perpendicular vector (rotated 90 degrees counterclockwise)
/datum/vector2/proc/perpendicular()
	return new /datum/vector2(-y, x)

// Reflection: Reflects this vector over a normal vector (returns new vector, assumes normal is unit)
/datum/vector2/proc/reflect(datum/vector2/normal)
	var/datum/vector2/proj = project_onto(normal)
	return subtracted(proj.multiplied(2)) // this - 2 * proj

// Linear interpolation: Returns a new vector interpolated between this and target by factor (0-1)
/datum/vector2/proc/lerp(datum/vector2/target, factor)
	var/datum/vector2/add = added(target.subtracted(copy()))
	return add.multiplied(factor)

// Clamp magnitude: Clamps the vector's magnitude between min and max (mutable)
/datum/vector2/proc/clamp_magnitude(min_mag = 0, max_mag = INFINITY)
	var/mag = magnitude()
	if(mag == 0)
		return src
	if(mag < min_mag)
		multiply(min_mag / mag)
	else if(mag > max_mag)
		multiply(max_mag / mag)
	return src

// Clamp components: Clamps x and y between min and max values (mutable)
/datum/vector2/proc/clamp_components(min_val = -INFINITY, max_val = INFINITY)
	x = clamp(x, min_val, max_val)
	y = clamp(y, min_val, max_val)
	return src

// Component-wise min: Returns a new vector with min components from this and another
/datum/vector2/proc/min_components(datum/vector2/other)
	return new /datum/vector2(min(x, other.x), min(y, other.y))

// Component-wise max: Returns a new vector with max components from this and another
/datum/vector2/proc/max_components(datum/vector2/other)
	return new /datum/vector2(max(x, other.x), max(y, other.y))

// Component-wise abs: Returns a new vector with absolute values
/datum/vector2/proc/abs_components()
	return new /datum/vector2(abs(x), abs(y))

// Floor: Returns a new vector with floored components
/datum/vector2/proc/floor_components()
	return new /datum/vector2(FLOOR(x, 1), FLOOR(y, 1))

// Ceil: Returns a new vector with ceiled components
/datum/vector2/proc/ceil_components()
	return new /datum/vector2(CEILING(x, 1), CEILING(y, 1))

// Round: Returns a new vector with rounded components
/datum/vector2/proc/round_components()
	return new /datum/vector2(round(x), round(y))

// Copy: Returns a new copy of this vector
/datum/vector2/proc/copy()
	return new /datum/vector2(x, y)

// Zero: Sets this vector to zero (mutable)
/datum/vector2/proc/zero()
	x = 0
	y = 0
	return src

// Equality: Checks if this vector exactly equals another (floats beware of precision)
/datum/vector2/proc/equals(datum/vector2/other)
	return (x == other.x) && (y == other.y)

// Approximate equality: Checks if this vector is approximately equal to another within epsilon
/datum/vector2/proc/approx_equals(datum/vector2/other, epsilon = 0.001)
	return (abs(x - other.x) <= epsilon) && (abs(y - other.y) <= epsilon)

// Distance: Returns the Euclidean distance to another vector
/datum/vector2/proc/distance_to(datum/vector2/other)
	var/dx = x - other.x
	var/dy = y - other.y
	return sqrt((dx * dx) + (dy * dy))

// Distance squared: Returns the squared Euclidean distance (faster for comparisons)
/datum/vector2/proc/distance_to_squared(datum/vector2/other)
	var/dx = x - other.x
	var/dy = y - other.y
	return (dx * dx) + (dy * dy)

// To dir: Converts this vector to the closest BYOND dir
/datum/vector2/proc/to_dir()
	var/ang = angle()
	switch(ang)
		if(-157.5 to -112.5)
			return SOUTHWEST
		if(-112.5 to -67.5)
			return SOUTH
		if(-67.5 to -22.5)
			return SOUTHEAST
		if(22.5 to 67.5)
			return NORTHEAST
		if(67.5 to 112.5)
			return NORTH
		if(112.5 to 157.5)
			return NORTHWEST
		if(157.5 to 180)
			return WEST
		else
			return EAST

// Static helpers (not on instance)

// From angle: Creates a new vector from angle (radians) and magnitude
/proc/vector2_from_angle(angle, mag = 1)
	return new /datum/vector2(cos(angle) * mag, sin(angle) * mag)

// Random unit: Creates a new random unit vector
/proc/vector2_random_unit()
	var/angle = rand(0, 360)
	return vector2_from_angle(angle)

// Random: Creates a new vector with random components in range
/proc/vector2_random(min_val = -1, max_val = 1)
	return new /datum/vector2(rand(min_val, max_val), rand(min_val, max_val))

// For Rust integration: Serialize to list for FFI
/datum/vector2/proc/to_list()
	return list(x, y)

// Deserialize from list
/proc/vector2_from_list(list/L)
	if(!islist(L) || L.len < 2)
		return new /datum/vector2(0, 0)
	return new /datum/vector2(L[1], L[2])

// From dir: Converts a BYOND dir (NORTH, SOUTH, etc.) to a unit vector
/proc/vector2_from_dir(dir)
	switch(dir)
		if(NORTH)
			return new /datum/vector2(0, 1)
		if(SOUTH)
			return new /datum/vector2(0, -1)
		if(EAST)
			return new /datum/vector2(1, 0)
		if(WEST)
			return new /datum/vector2(-1, 0)
		if(NORTHEAST)
			return new /datum/vector2(1, 1)
		if(NORTHWEST)
			return new /datum/vector2(-1, 1)
		if(SOUTHEAST)
			return new /datum/vector2(1, -1)
		if(SOUTHWEST)
			return new /datum/vector2(-1, -1)
	return new /datum/vector2(0, 0)

// Constant subtypes for common vectors (predefined for quick access)
/datum/vector2/zero
	x = 0
	y = 0

/datum/vector2/right
	x = 1
	y = 0

/datum/vector2/left
	x = -1
	y = 0

/datum/vector2/up
	x = 0
	y = 1

/datum/vector2/down
	x = 0
	y = -1
