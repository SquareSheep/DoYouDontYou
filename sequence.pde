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
	// Intro section
	if (beatInRange(201,263) && (currBeatQ == 0.5 || currBeatQ == 0)) {
		if (beatInRange(203,207) || beatInRange(211,215) || beatInRange(219,223) || beatInRange(227,231)
			|| beatInRange(235,239) || beatInRange(243,247) || beatInRange(251,255) || beatInRange(259,263)) {
			for (int i = -(int)box.g.x ; i < box.g.x ; i ++) {
				i +=2;
				for (int k = -(int)box.g.y ; k < box.g.y ; k ++) {
					box.add(randomI(new int[]	{0,2}),i,box.g.y,k);
					k +=2;
				}
			}
		}
		if (beatInRange(203,211) || beatInRange(235,243)) for (PolyS mob : ar) {
			mob.addP(abs(mob.gety()%2),-1,abs(mob.getx())%2);
			mob.addAng(abs(mob.gety()%2),abs(mob.getz())%2,0);

		} else if (beatInRange(211,219) || beatInRange(243,251)) for (PolyS mob : ar) {
			mob.addP(abs(mob.gety()%2),-1,-abs(mob.getx())%2);
			mob.addAng(abs(mob.gety()%2),abs(mob.getz())%2,0);

		} else if (beatInRange(219,227) || beatInRange(251,259)) for (PolyS mob : ar) {
			mob.addP(-abs(mob.gety()%2),-1,-abs(mob.getx())%2);
			mob.addAng(abs(mob.gety()%2),abs(mob.getz())%2,0);

		} else if (beatInRange(227,235) || beatInRange(259,267)) for (PolyS mob : ar) {
			mob.addP(-abs(mob.gety()%2),-1,abs(mob.getx())%2);
			mob.addAng(abs(mob.gety()%2),abs(mob.getz())%2,0);
		}

		box.arFillStyleSet(55,55,55,255, 100,100,100,0, 1,1,1,0, 1,1,1,0);
		for (PolyS mob : ar) {
			if (mob.steps > 7) mob.die();
		}
	}
	// Bridge section
	else if (beatInRange(263,297)) {
		if (currBeat == 266) cam.av.reset(0,-0.002,0);
		// "Whemm" sounds
		if (currBeat == 266 || currBeat == 269.75 || currBeat == 274 || currBeat == 277.75 || currBeat == 282 || currBeat == 285.75 || currBeat == 290 || currBeat == 293.75) {
			for (int i = 0 ; i < ar.size() ; i ++) {
				ar.get(i).die();
			}
			for (int i = -(int)box.g.x; i < box.g.x - 1 ; i ++) 
				for (int k = -(int)box.g.y ; k < box.g.y ; k ++) box.add(random(3),i,k,-box.g.z, 0,2,0);
			for (int i = -(int)box.g.z + 1 ; i < box.g.x ; i ++) 
				for (int k = -(int)box.g.y ; k < box.g.y ; k ++) box.add(random(3),-box.g.x,k,i, 0,3,0);
			for (int i = -(int)box.g.x + 1 ; i < box.g.x ; i ++) 
				for (int k = -(int)box.g.y ; k < box.g.y ; k ++) box.add(random(3),i,k,box.g.z, 0,0,0);
			for (int i = -(int)box.g.z ; i < box.g.x - 1 ; i ++) 
				for (int k = -(int)box.g.y ; k < box.g.y ; k ++) box.add(random(3),box.g.x,k,i, 0,1,0);
			box.arFillStyleSet(55,55,55,255, 100,100,100,0, 1,1,1,0, 1,1,1,0);
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