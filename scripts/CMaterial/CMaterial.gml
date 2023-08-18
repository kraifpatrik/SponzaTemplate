/// @func CMaterial()
///
/// @desc A material.
function CMaterial() constructor
{
	/// @var {String, Undefined} Path to file from which was the `BaseColor`
	/// texture loaded or `undefined` (default).
	BaseColorPath = undefined;

	/// @var {Pointer.Texture} The base color texture. Default value is
	/// `pointer_null`.
	BaseColor = pointer_null;

	/// @var {String, Undefined} Path to file from which was the
	/// `MetallicRoughness` texture loaded or `undefined` (default).
	MetallicRoughnessPath = undefined;

	// @var {Pointer.Texture} The metallic-roughness texture. Default value is
	/// `pointer_null`.
	MetallicRoughness = pointer_null;

	/// @var {String, Undefined} Path to file from which was the `Normal`
	/// texture loaded or `undefined` (default).
	NormalPath = undefined;

	// @var {Pointer.Texture} The normal texture. Default value is `pointer_null`.
	Normal = pointer_null;

	/// @func Destroy()
	///
	/// @desc Destroys the material.
	///
	/// @return {Undefined}
	static Destroy = function ()
	{
		return undefined;
	};
}
