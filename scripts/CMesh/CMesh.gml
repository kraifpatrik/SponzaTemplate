/// @func CMesh([_model])
///
/// @desc A mesh.
///
/// @param {Struct.CModel, Undefined} [_model] The model to which the mesh belongs.
function CMesh(_model=undefined) constructor
{
	/// @var {Struct.CModel, Undefined} The model to which the mesh belongs or
	/// `undefined` (default).
	Model = _model;

	/// @var {Id.VertexBuffer, Undefined} The vertex buffer of the mesh or
	/// `undefined` (default).
	VertexBuffer = undefined;

	/// @var {String, Undefined} The name of the material used by the mesh or
	/// `undefined` (default).
	Material = undefined;

	/// @func ToBuffer(_buffer)
	///
	/// @desc Writes the mesh to a buffer.
	///
	/// @param {Id.Buffer} _buffer A buffer to write the mesh into.
	///
	/// @return {Struct.CMesh} Returns `self`.
	///
	/// @throws {String} If an error occurs.
	static ToBuffer = function (_buffer)
	{
		if (Material == undefined)
		{
			throw "Mesh's material name cannot be undefined!";
		}

		if (VertexBuffer == undefined)
		{
			throw "Vertex buffer cannot be undefined!";
		}

		var _vertexCount = vertex_get_number(VertexBuffer);
		buffer_write(_buffer, buffer_u32, _vertexCount);

		// WTF this freezes the game
		//buffer_copy_from_vertex_buffer(VertexBuffer, 0, _vertexCount, _buffer, buffer_tell(_buffer));
		//buffer_seek(_buffer, buffer_seek_end, 0);

		var _vbuffer = buffer_create_from_vertex_buffer(VertexBuffer, buffer_fixed, 1);
		var _vbufferSize = buffer_get_size(_vbuffer);
		buffer_copy(_vbuffer, 0, _vbufferSize, _buffer, buffer_tell(_buffer));
		buffer_delete(_vbuffer);
		buffer_seek(_buffer, buffer_seek_relative, _vbufferSize);

		buffer_write(_buffer, buffer_string, Material);

		return self;
	};

	/// @func FromBuffer(_buffer)
	///
	/// @desc Loads the mesh from a buffer.
	///
	/// @param {Id.Buffer} _buffer The buffer to load the mesh from.
	///
	/// @return {Struct.CMesh} Returns `self`.
	///
	/// @throws {String} If an error occurs.
	static FromBuffer = function (_buffer)
	{
		var _vertexCount = buffer_read(_buffer, buffer_u32);
		VertexBuffer = vertex_create_buffer_from_buffer_ext(
			_buffer, global.__vertexFormat, buffer_tell(_buffer), _vertexCount);
		var _byteSize = vertex_get_buffer_size(VertexBuffer);
		buffer_seek(_buffer, buffer_seek_relative, _byteSize);
		Material = buffer_read(_buffer, buffer_string);
		return self;
	};

	/// @func Freeze()
	///
	/// @desc Freezes the mesh's vertex buffer (if not `undefined`).
	///
	/// @return {Struct.CMesh} Returns `self`.
	static Freeze = function ()
	{
		if (VertexBuffer != undefined)
		{
			vertex_freeze(VertexBuffer);
		}
		return self;
	};

	/// @func Submit()
	///
	/// @desc Submits the mesh's vertex buffer (if not `undefined`).
	///
	/// @return {Struct.CMesh} Returns `self`.
	static Submit = function ()
	{
		if (VertexBuffer != undefined)
		{
			var _shader = shader_current();
			var _baseColor = pointer_null;
			var _metallicRoughness = pointer_null;
			var _normal = pointer_null;

			if (Material != undefined)
			{
				with (Model.Materials[? Material])
				{
					_baseColor = BaseColor;
					_metallicRoughness = MetallicRoughness;
					_normal = Normal;
				}
			}

			if (_baseColor == pointer_null)
			{
				_baseColor = sprite_get_texture(SprWhite, 0);
			}

			if (_metallicRoughness == pointer_null)
			{
				_metallicRoughness = sprite_get_texture(SprMetallicRoughness, 0);
			}

			if (_normal == pointer_null)
			{
				_normal = sprite_get_texture(SprNormal, 0);
			}

			texture_set_stage(shader_get_sampler_index(_shader, "u_texMetallicRoughness"), _metallicRoughness);
			texture_set_stage(shader_get_sampler_index(_shader, "u_texNormal"), _normal);
			vertex_submit(VertexBuffer, pr_trianglelist, _baseColor);
		}
		return self;
	};

	/// @func Destroy()
	///
	/// @desc Destroys the mesh and frees used memory.
	///
	/// @return {Undefined}
	static Destroy = function ()
	{
		if (VertexBuffer != undefined)
		{
			vertex_delete_buffer(VertexBuffer);
		}
		return undefined;
	};
}
