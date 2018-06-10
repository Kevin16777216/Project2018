This is where all the data is about physics in a scene.
Ex:
	-Hitboxes(mainly this)
	-Enemy collision
	-Item collison
		-pick up Money
		-check if close enoughto read a sign
Format:
	ID
	<Character>
	x,y,width,height,isSolid
	<Static Objects>
	x,y,width,height,isSolid
	<Enemies>
	x,y,MovementID,ID
	-Movement ID will be separate for another folder, aswell as ID;
	
	<Foreground>
	x,y,height,width(Name of Image)
	<Background>
	shiftx(ratio),shifty,scalex,scaley,img
	<Midground>
	