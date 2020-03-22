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

String[] mNone = new String[]{};
String[] mSource = new String[]{"source","line"};
String[] mSourceI = new String[]{"sourceI","line"};
String[] mLine = new String[]{"line"};
String[] mFlip = new String[]{"line","flip"};
String[] mFlip2 = new String[]{"line","flip","flipAng"};
String[] mSwitch = new String[]{"flip","flipAng","altTemp"};
PolyTemp[] octoCube = new PolyTemp[]{octohedron,cube};
PolyTemp[] octoMid = new PolyTemp[]{octohedron,pyramid};
PolyTemp[] pyraCube = new PolyTemp[]{pyramid,cube};
PolyTemp[] cubeCrystal = new PolyTemp[]{cube,crystal};


void instantEvents() {
	// Intro lyrics
	if (beatInRange(201,266)) {
		if (currBeat == 201) {
			cam.ang.reset(-0.4,0,0);
			cam.av.P.set(0,0.001,0);
		}
		if (beatInRange(241,242)) {
			for (PolyS mob : box.par) if (mob.alive) mob.die();
			for (PolyS mob : box2.par) if (mob.alive) mob.die();
		}
		if (currBeat % 0.5 == 0) {
			for (int i = -box2.gx ; i <= box2.gx ; i ++) {
				mob = box2.add(mLine, cube, i,box2.gy,-box2.gz, 0.5,0, 16);
				mob.setT(0,0,1);
				mob.diePulse = false;
			}
		}
		if (beatInRange(203,206) || beatInRange(218.5,221.5)) {
			if (currBeat % 0.5 == 0) {
				for (int i = -box.gx ; i <= box.gx ; i ++) {
					mob = box.add(mFlip, cube, i,box.gy,0, 0.5,0, 16);
					if (i % 2 == 0) {
						mob.setT(0,-1,0, 0,0,-1);
					} else {
						mob.setT(0,-1,0, 0,0,1);
					}
				}
			}
		} else if (beatInRange(211,214) || beatInRange(226,229)) {
			if (currBeat % 0.5 == 0) {
				for (int i = -box.gz ; i <= box.gz ; i ++) {
					mob = box.add(mFlip, cube, i,box.gy,i, 0.5,0, 16);
					if (i % 2 == 0) {
						mob.setT(0,-1,0, -1,0,0);
					} else {
						mob.setT(0,-1,0, 1,0,0);
					}
				}
			}
		} else if (beatInRange(235,238) || beatInRange(250.5,253.5)) {
			if (currBeat % 0.5 == 0) {
				for (int i = -box.gx ; i <= box.gx ; i ++) {
					for (int k = -box.gz ; k <= box.gz ; k ++) {
						mob = box.add(mFlip, cube, i,box.gy,k, 0.5,0, 16);
						if (i % 2 == 0) {
							mob.setT(0,-1,0, -1,0,0);
						} else {
							mob.setT(0,-1,0, 1,0,0);
						}
						k += 2;
					}
					i += 2;
				}
			}
		} else if (beatInRange(243,246) || beatInRange(258.5,261.5)) {
			if (currBeat % 0.5 == 0) {
				for (int i = -box.gx ; i <= box.gx ; i ++) {
					for (int k = -box.gz ; k <= box.gz ; k ++) {
						mob = box.add(mFlip, cube, i,box.gy,k, 0.5,0, 16);
						if (i % 2 == 0) {
							mob.setT(0,-1,0, -1,0,0);
						} else {
							mob.setT(0,-1,0, 1,0,0);
						}
						k += 2;
					}
					i += 2;
				}
			}
		}

		box.setFillStyle(155,155,155, 125,-125,125, 0,0,0, 2,2,2);
		box2.setFillStyle(55,55,55, 125,-125,125, 0,0,0, 1,1,1);
	} // "Whemm" bridge
	else if (beatInRange(266,297)) {
		if (currBeat == 266) {
			cam.ang.P.set(-0.5,0.5,0);
			cam.av.reset(0,-0.002,0);
			for (PolyS mob : box2.par) mob.die();
		}
		if (currBeat % 2 == 1) {
			for (int i = -box.gx ; i <= box.gx ; i ++) box.add(mLine, cube, i,-box.gy,-box.gz, 0.25,0, 16).setT(0,2,0);
			for (int i = -box.gx ; i <= box.gx ; i ++) box.add(mLine, cube, i,-box.gy,box.gz, 0.25,0, 16).setT(0,2,0);
			for (int i = -box.gz ; i <= box.gz ; i ++) box.add(mLine, cube, -box.gx,-box.gy,i, 0.25,0, 16).setT(0,2,0);
			for (int i = -box.gz ; i <= box.gz ; i ++) box.add(mLine, cube, box.gx,-box.gy,i, 0.25,0, 16).setT(0,2,0);
			for (int i = -box.gx ; i <= box.gx ; i ++) box.add(mLine, cube, i,box.gy,-box.gz, 0.25,0, 16).setT(0,-2,0);
			for (int i = -box.gx ; i <= box.gx ; i ++) box.add(mLine, cube, i,box.gy,box.gz, 0.25,0, 16).setT(0,-2,0);
			for (int i = -box.gz ; i <= box.gz ; i ++) box.add(mLine, cube, -box.gx,box.gy,i, 0.25,0, 16).setT(0,-2,0);
			for (int i = -box.gz ; i <= box.gz ; i ++) box.add(mLine, cube, box.gx,box.gy,i, 0.25,0, 16).setT(0,-2,0);
		}
		// "Whemm" sounds
		if (currBeat == 266 || currBeat == 269.75 || currBeat == 274 || currBeat == 277.75 || 
			currBeat == 282 || currBeat == 285.75 || currBeat == 290 || currBeat == 293.75) {
			for (PolyS mob : box.par) {
				mob.die();
			}
		}
		if (beatInRange(266,269.75)) {
			for (int i = -box.gx ; i <= box.gx ; i ++) {
				mob = box.add(mLine, cube, i,box.gy,-box.gz, 0.25,0, 16);
				mob.setT(0,0,1);
			}
			box.setFillStyle(75,75,75, 100,-155,125, 1,1,1, 0,0,0);
		} else if (beatInRange(269.75,274)) {
			for (int i = -box.gy ; i <= box.gy ; i ++) {
				mob = box.add(mLine, pyramid, -box.gx,i,i, 0.25,0, 16);
				mob.setT(1,0,0);
			}
			box.setFillStyle(75,75,75, 100,25,255, 1,1,1, 0,0,0);
		} else if (beatInRange(274,277.75)) {
			for (int i = -box.gy ; i <= box.gy ; i ++) {
				mob = box.add(mLine, octohedron, 0,i,box.gz, 0.25,0, 16);
				mob.setT(0,0,-1);
			}
			box.setFillStyle(75,75,75, -155,100,125, 1,1,1, 0,0,0);
		} else if (beatInRange(277.75,282)) {
			for (int i = -box.gy ; i <= box.gy ; i ++) {
				mob = box.add(mLine, octoMid, box.gx,i,i, 0.25,0, 16);
				mob.setT(-1,0,0);
			}
			box.setFillStyle(75,75,75, 100,-155,125, 1,1,1, 0,0,0);
		} else if (beatInRange(282,285.75)) {
			for (int i = -box.gx ; i <= box.gx ; i ++) {
				mob = box.add(mLine, cube, i,box.gy,-box.gz, 0.25,0, 16);
				mob.setT(0,0,1);
			}
			box.setFillStyle(75,75,75, -100,-25,155, 1,1,1, 0,0,0);
		} else if (beatInRange(285.75,290)) {
			for (int i = -box.gy ; i <= box.gy ; i ++) {
				mob = box.add(mLine, octoMid, -box.gx,i,i, 0.25,0, 16);
				mob.setT(1,0,0);
			}
			box.setFillStyle(75,75,75, -155,100,125, 1,1,1, 0,0,0);
		} else if (beatInRange(290,293.75)) {
			for (int i = -box.gx ; i <= box.gx ; i ++) {
				mob = box.add(mLine, cube, i,box.gy,-box.gz, 0.25,0, 16);
				mob.setT(0,0,1);
			}
			box.setFillStyle(75,75,75, 100,25,255, 1,1,1, 0,0,0);
		} else if (beatInRange(293.75,298)) {
			for (int i = -box.gy ; i <= box.gy ; i ++) {
				mob = box.add(mLine, octoMid, box.gx,i,i, 0.25,0, 16);
				mob.setT(-1,0,0);
			}
			box.setFillStyle(75,75,75, 100,-155,125, 1,1,1, 0,0,0);
		}
	} // "Whemm" melody
	else if (beatInRange(297,400)) {
		if (currBeat == 297) {
			box.setW(5,5,7);
			for (PolyS mob : box.par) mob.die();
			for (PolyS mob : box2.par) mob.die();
			ringY(mSwitch, cube, -box.gy+1,1, 2,1);
			ringY(mSwitch, cube, box.gy-1,1, 2,1);
		}
		if (beatInRange(297,299.5) || beatInRange(301.5,303.5) || beatInRange(305,307.5) || beatInRange(309,311.5) ||
			beatInRange(313,315.5) || beatInRange(317.5,319.5) || beatInRange(321,323.5) || beatInRange(325,327.5)) {
			for (int o = 0 ; o < 3 ; o ++) {
				x = random(-box.gx+1,box.gx-1);
				z = random(-box.gz+1,box.gz-1);
				box.add(mFlip, cube, x,0,z, 0.25,0, 16).setT(0,-2,0);
				box.add(mFlip, cube, x-1,0,z, 0.25,0, 16).setT(0,-2,0);
				box.add(mFlip, cube, x+1,0,z, 0.25,0, 16).setT(0,-2,0);
				box.add(mFlip, cube, x,0,z-1, 0.25,0, 16).setT(0,-2,0);
				box.add(mFlip, cube, x,0,z+1, 0.25,0, 16).setT(0,-2,0);

				box.add(mFlip, cube, x,0,z, 0.25,0, 16).setT(0,2,0);
				box.add(mFlip, cube, x-1,0,z, 0.25,0, 16).setT(0,2,0);
				box.add(mFlip, cube, x+1,0,z, 0.25,0, 16).setT(0,2,0);
				box.add(mFlip, cube, x,0,z-1, 0.25,0, 16).setT(0,2,0);
				box.add(mFlip, cube, x,0,z+1, 0.25,0, 16).setT(0,2,0);
			}
		}
		// 329
		if (currBeat % 2 == 1 && beatInRange(329,361)) {
			for (int i = -box.gx ; i <= box.gx ; i ++) box.add(mLine, cubeCrystal, i,-box.gy,-box.gz, 0.25,0, 16).setT(0,2,0);
			for (int i = -box.gx ; i <= box.gx ; i ++) box.add(mLine, cubeCrystal, i,-box.gy,box.gz, 0.25,0, 16).setT(0,2,0);
			for (int i = -box.gz ; i <= box.gz ; i ++) box.add(mLine, cubeCrystal, -box.gx,-box.gy,i, 0.25,0, 16).setT(0,2,0);
			for (int i = -box.gz ; i <= box.gz ; i ++) box.add(mLine, cubeCrystal, box.gx,-box.gy,i, 0.25,0, 16).setT(0,2,0);
			for (int i = -box.gx ; i <= box.gx ; i ++) box.add(mLine, cubeCrystal, i,box.gy,-box.gz, 0.25,0, 16).setT(0,-2,0);
			for (int i = -box.gx ; i <= box.gx ; i ++) box.add(mLine, cubeCrystal, i,box.gy,box.gz, 0.25,0, 16).setT(0,-2,0);
			for (int i = -box.gz ; i <= box.gz ; i ++) box.add(mLine, cubeCrystal, -box.gx,box.gy,i, 0.25,0, 16).setT(0,-2,0);
			for (int i = -box.gz ; i <= box.gz ; i ++) box.add(mLine, cubeCrystal, box.gx,box.gy,i, 0.25,0, 16).setT(0,-2,0);
		}
		if (beatInRange(329,331.5) || beatInRange(333.5,335.5) || beatInRange(337,339.5) || beatInRange(341,343.5) ||
			beatInRange(345,347.5) || beatInRange(349.5,351.5) || beatInRange(353,355.5) || beatInRange(357,359.5)) {
			for (int o = 0 ; o < 3 ; o ++) {
				x = random(-box.gx+1,box.gx-1);
				z = random(-box.gz+1,box.gz-1);
				box.add(mFlip2, cube, x,box.gy-1,z, 0.25,0, 16).setT(0,-2,0);

				box.add(mFlip2, cube, x,box.gy-2,z, 0.25,0, 16).setT(0,-2,0);
				box.add(mFlip2, cube, x,box.gy,z, 0.25,0, 16).setT(0,-2,0);

				box.add(mFlip2, cube, x-1,box.gy-1,z, 0.25,0, 16).setT(0,-2,0);
				box.add(mFlip2, cube, x+1,box.gy-1,z, 0.25,0, 16).setT(0,-2,0);
				
				box.add(mFlip2, cube, x,box.gy-1,z-1, 0.25,0, 16).setT(0,-2,0);
				box.add(mFlip2, cube, x,box.gy-1,z+1, 0.25,0, 16).setT(0,-2,0);
			}
		}
		if (currBeat % 1 == 0 && beatInRange(361,369)) {
			ringY(mLine, cube, -box.gy,2, 0.25,0);
			ringY(mLine, cube, box.gy,-2, 0.25,0);
		}
		if (currBeat % 1 == 0 && beatInRange(369,391)) {
			ringZ(mLine, cube, -box.gz,2, 0.25,0);
			ringZ(mLine, cube, box.gz,-2, 0.25,0);
		}
		if (currBeat == 361) {
			for (PolyS mob : box.par) mob.die();
			for (PolyS mob : box2.par) mob.die();
			ringY(mSwitch, cube, -box.gy+1,1, 1,0);
			ringY(mSwitch, cube, box.gy-1,1, 1,0);
		}
		if (beatInRange(361,363.5) || beatInRange(365.5,367.5) || beatInRange(369,371.5) || beatInRange(373,375.5) ||
			beatInRange(377,379.5) || beatInRange(381.5,383.5) || beatInRange(385,387.5) || beatInRange(389,391.5)) {
			for (int o = 0 ; o < 3 ; o ++) {
				x = random(-box.gx+1,box.gx-1);
				z = random(-box.gz+1,box.gz-1);
				box.add(mFlip2, cube, x,box.gy-1,z, 0.25,0, 16).setT(0,-2,0);

				box.add(mFlip2, cube, x,box.gy-2,z, 0.25,0, 16).setT(0,-2,0);
				box.add(mFlip2, cube, x,box.gy,z, 0.25,0, 16).setT(0,-2,0);

				box.add(mFlip2, cube, x-1,box.gy-1,z, 0.25,0, 16).setT(0,-2,0);
				box.add(mFlip2, cube, x+1,box.gy-1,z, 0.25,0, 16).setT(0,-2,0);
				
				box.add(mFlip2, cube, x,box.gy-1,z-1, 0.25,0, 16).setT(0,-2,0);
				box.add(mFlip2, cube, x,box.gy-1,z+1, 0.25,0, 16).setT(0,-2,0);
			}
		}
		box.setFillStyle(155,155,155, 125,-125,125, 0,0,0, 2,2,2);
		box2.setFillStyle(55,55,55, 125,-125,125, 0,0,0, 1,1,1);
	}
	box.setIndex();
	box2.setIndex();
}

void keyboardInput() {
	switch(key) {
		case '1':
		setTime(99195,191.25);
		break;
		case '2':
		setTime(136765,263.25);
		break;
		case '3':
		setTime(153460,295.25);
		break;
		case '4':
		setTime(169644,326.25);
		break;
		case '5':
		setTime(186316,358.25);
		break;
		case '6':
		setTime(0,0);
		break;
	}
}