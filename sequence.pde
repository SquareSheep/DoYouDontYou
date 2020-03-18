/* 
201 Intro section:
203-207 Do you hear what I hear
211-215 Do you care if I care
219-223 Do you know what I know
227-231 Do you know what we share

235-239 Do you hear what I hear
243-247 ...
251-255
259-263

267 Bridge:
"Whemm" sounds
266 270 274 278 282 286 290 294

297 Melody section

*/
void addEvents() {

}

int bgType = 0;
void instantEvents() {
	if (beatInRange(201,266)) {
		if (currBeat == 201) {
			cam.ang.reset(0,0,0);
		}
		cam.av.P.set(0.01*noise((float)frameCount/100),-0.01*noise((float)frameCount/125),0);
		if (currBeat == 203 || currBeat == 218.5 || currBeat == 235 || currBeat == 250.5) {
			for (int i = -box.gx ; i < box.gx ; i ++) box.add(1, i,-(int)box.gy,-box.gz, "source", 0.25,0, 24).setT(0,0,1);
			for (int i = -box.gx ; i <= box.gx ; i ++) box.add(1, i,(int)box.gy,-box.gz, "source", 0.25,0, 24).setT(0,0,1);
			for (int i = -box.gy ; i < box.gy ; i ++) box.add(1, -(int)box.gx,i,-box.gz, "source", 0.25,0, 24).setT(0,0,1);
			for (int i = -box.gy ; i <= box.gy ; i ++) box.add(1, (int)box.gx,i,-box.gz, "source", 0.25,0, 24).setT(0,0,1);
		} else if (currBeat == 211 || currBeat == 226.5 || currBeat == 243 || currBeat == 258.5) {
			for (int i = -box.gx ; i < box.gx ; i ++) box.add(1, i,-(int)box.gy,-box.gz, "source", 0.25,0, 24).setT(0,1,1);
			for (int i = -box.gx ; i <= box.gx ; i ++) box.add(1, i,(int)box.gy,-box.gz, "source", 0.25,0, 24).setT(0,-1,1);
			for (int i = -box.gy ; i < box.gy ; i ++) box.add(1, -(int)box.gx,i,-box.gz, "source", 0.25,0, 24).setT(1,0,1);
			for (int i = -box.gy ; i <= box.gy ; i ++) box.add(1, (int)box.gx,i,-box.gz, "source", 0.25,0, 24).setT(-1,0,1);
		}

		box.arFillStyleSet(55,55,55,75, 100,-100,100,0, 1,1,1,0, 1,1,1,0);
		box.arFillStyleSet(true,25,25,25,75, 25,-25,25,0, 0,0,0,2, 1,1,1,0);
	} // Bridge section
	else if (beatInRange(266,297)) {
		if (currBeat == 266) cam.av.reset(0,-0.002,0);
		// "Whemm" sounds
		if (currBeat == 266 || currBeat == 269.75 || currBeat == 274 || currBeat == 277.75 || currBeat == 282 || currBeat == 285.75 || currBeat == 290 || currBeat == 293.75) {
			for (int i = 0 ; i < ar.size() ; i ++) {
				ar.get(i).die();
			}
			box.arFillStyleSet(true,125,55,25,255, 100,55,25,0, 2,2,2,0, 0,0,0,0);
		}
	}
}

void keyboardInput() {
	switch(key) {
		case '1':
		setTime(99195,191.25);
		break;
		case '2':
		setTime(136765,263.5);
		break;
		case '3':
		setTime(0,0);
		break;
		case '4':
		setTime(0,0);
		break;
		case '5':
		setTime(0,0);
		break;
		case '6':
		setTime(0,0);
		break;
	}
}

boolean beatInRange(int minBeat, int maxBeat) {
	return currBeat >= minBeat && currBeat < maxBeat;
}