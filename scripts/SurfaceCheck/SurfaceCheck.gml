/// @func SurfaceCheck(_surface, _width, _height)
///
/// @desc Checks if given surface exists and if it has the correct size. If it
/// does not exist then it is created. If it exists but it has a different size
/// then it is resized.
///
/// @param {Id.Surface} _surface The surface to check.
/// @param {Real} _width The desired width of the surface.
/// @param {Real} _height The desired height of the surface.
///
/// @return {Id.Surface} The original surface if it was only resized or
/// a new surface if given surface did not exist.
function SurfaceCheck(_surface, _width, _height)
{
	_width = max(_width, 1);
	_height = max(_height, 1);
	if (!surface_exists(_surface))
	{
		_surface = surface_create(_width, _height);
	}
	else if (surface_get_width(_surface) != _width
		|| surface_get_height(_surface) != _height)
	{
		surface_resize(_surface, _width, _height);
	}
	return _surface;
}
