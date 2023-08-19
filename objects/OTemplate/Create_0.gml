draw_set_font(FntOpenSans10);

camera = camera_create();
clipFar = 512.0;
fov = 60.0;
x = 3.0;
y = 0.0;
z = 1.0;
direction = 180.0;
directionUp = 0.0;
mouseLastX = 0;
mouseLastY = 0;

model = new CModel();

if (file_exists("Data/Sponza/Sponza.bin"))
{
	var _buffer = buffer_load("Data/Sponza/Sponza.bin");
	model.FromBuffer(_buffer);
	buffer_delete(_buffer);
}
else
{
	model.FromOBJ("Data/Sponza/Sponza.obj");

	//var _buffer = buffer_create(1, buffer_grow, 1);
	//model.ToBuffer(_buffer);
	//buffer_save(_buffer, game_save_id + "Data/Sponza/Sponza.bin");
	//buffer_delete(_buffer);
}

model.Freeze();

modelScale = 0.01;
modelMatrix = matrix_build(
	0.0, 0.0, 0.0,
	0.0, 0.0, 0.0,
	modelScale, modelScale, modelScale);

camera = camera_create();
clipFar = 512.0;
fov = 60.0;
x = 3.0;
y = 0.0;
z = 1.0;
direction = 180.0;
directionUp = 0.0;
mouseLastX = 0;
mouseLastY = 0;

gui = new CGUI();
guiShow = false;
screenshotMode = false;
