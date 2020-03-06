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
270 274 278 282 286 290 294

297 Melody section

*/
void addEvents() {

}

int bgType = 0;
void instantEvents() {
	// Intro section
	if (beatInRange(201,263) && (currBeatQ == 0.5 || currBeatQ == 0)) {
		//if (currBeatQ == 0.5) box.setW(7,7,7);
		//if (currBeatQ == 0) box.setW(4,4,4);
		// if (currBeatQ == 0) {
		// 	box2.add((int)(currBeat%2), -box2.g.x,-box2.g.y,-box2.g.z);
		// 	box2.add((int)(currBeat%2), -box2.g.x,box2.g.y,-box2.g.z);
		// 	box2.add((int)(currBeat%2), box2.g.x,box2.g.y,-box2.g.z);
		// 	box2.add((int)(currBeat%2), box2.g.x,-box2.g.y,-box2.g.z);
		// 	for (int i = 0 ; i < 4 ; i ++) {
		// 		ar2.get(ar2.size() -1-i).pv.reset(0,0,60);
		// 	}
		// }
		if (beatInRange(203,207) || beatInRange(211,215) || beatInRange(219,223) || beatInRange(227,231)
			|| beatInRange(235,239) || beatInRange(243,247) || beatInRange(251,255) || beatInRange(259,263)) {
			for (int i = -(int)box.g.x ; i < box.g.x ; i ++) {
				i ++;
				for (int k = -(int)box.g.y ; k < box.g.y ; k ++) {
					box.add(randomI(new int[]{0,2}),i,k,-box.g.z);
					k ++;
				}
			}
		}
		if (beatInRange(203,211) || beatInRange(235,243)) for (PolyS mob : ar) {
			mob.addP(abs(mob.gety()%3),abs(mob.getz())%3,1);
			mob.addAng(abs(mob.gety()%3),abs(mob.getz())%3,0);

		} else if (beatInRange(211,219) || beatInRange(243,251)) for (PolyS mob : ar) {
			mob.addP(abs(mob.gety()%3),-abs(mob.getz())%3,1);
			mob.addAng(abs(mob.gety()%3),abs(mob.getz())%3,0);

		} else if (beatInRange(219,227) || beatInRange(251,259)) for (PolyS mob : ar) {
			mob.addP(-abs(mob.gety()%3),-abs(mob.getz())%3,1);
			mob.addAng(abs(mob.gety()%3),abs(mob.getz())%3,0);

		} else if (beatInRange(227,235) || beatInRange(259,267)) for (PolyS mob : ar) {
			mob.addP(-abs(mob.gety()%3),abs(mob.getz())%3,1);
			mob.addAng(abs(mob.gety()%3),abs(mob.getz())%3,0);
		}

		box.arFillStyleSet(55,55,55,255, 100,100,100,0, 1,1,1,0, 1,1,1,0);
		for (PolyS mob : ar) {
			if (mob.steps > 9) mob.die();
		}
	}
	switch((int)(currBeat*4)) {
		//case 192:
	}
}

void keyboardInput() {
	switch(key) {
		case '1':
		setTime(99195,191);
		break;
		case '2':
		setTime(138321,266);
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