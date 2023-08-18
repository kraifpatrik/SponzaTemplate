/// @func CMaterial([_name])
///
/// @desc A material.
///
/// @param {String, Undefined} [_name] The name of the material of `undefined`.
function CMaterial(_name) constructor
{
	/// @var {String, Undefined} The name of the material or `undefined` (default).
	Name = _name;

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

	/// @func ToBuffer(_buffer)
	///
	/// @desc Writes the material to a buffer.
	///
	/// @param {Id.Buffer} _buffer A buffer to write the material into.
	///
	/// @return {Struct.CMaterial} Returns `self`.
	///
	/// @throws {String} If an error occurs.
	static ToBuffer = function (_buffer)
	{
		if (Name == undefined)
		{
			throw "Material name cannot be undefined!";
		}

		buffer_write(_buffer, buffer_string, Name);

		buffer_write(_buffer, buffer_bool, BaseColorPath != undefined);
		if (BaseColorPath != undefined)
		{
			buffer_write(_buffer, buffer_string, BaseColorPath);
		}

		buffer_write(_buffer, buffer_bool, MetallicRoughnessPath != undefined);
		if (MetallicRoughnessPath != undefined)
		{
			buffer_write(_buffer, buffer_string, MetallicRoughnessPath);
		}

		buffer_write(_buffer, buffer_bool, NormalPath != undefined);
		if (NormalPath != undefined)
		{
			buffer_write(_buffer, buffer_string, NormalPath);
		}

		return self;
	};

	/// @func FromBuffer(_buffer)
	///
	/// @desc Loads the material from a buffer.
	///
	/// @param {Id.Buffer} _buffer The buffer to load the material from.
	///
	/// @return {Struct.CMaterial} Returns `self`.
	///
	/// @throws {String} If an error occurs.
	static FromBuffer = function (_buffer)
	{
		Name = buffer_read(_buffer, buffer_string);

		BaseColorPath = buffer_read(_buffer, buffer_bool)
			? buffer_read(_buffer, buffer_string)
			: undefined;

		MetallicRoughnessPath = buffer_read(_buffer, buffer_bool)
			? buffer_read(_buffer, buffer_string)
			: undefined;

		NormalPath = buffer_read(_buffer, buffer_bool)
			? buffer_read(_buffer, buffer_string)
			: undefined;

		return self;
	};

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
