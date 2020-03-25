/* 
TODO:
Physical sequence
p.v wave effects
Color changes
Background wall effects
*/

String[] mNone = new String[]{};
String[] mSource = new String[]{"source","line"};
String[] mLine = new String[]{"line"};
String[] mFlip = new String[]{"line","flip"};
String[] mSwitch2 = new String[]{"flip2", "flipAng", "altTemp"};
String[] mSwitch = new String[]{"flip","flipAng","altTemp"};
String[] mSwitchLine = new String[]{"flip","flipAng","altTemp","line"};
PolyTemp[] octoCube = new PolyTemp[]{octohedron,cube};
PolyTemp[] octoMid = new PolyTemp[]{octohedron,pyramid};
PolyTemp[] pyraCube = new PolyTemp[]{pyramid,cube};
PolyTemp[] cubeCrystal = new PolyTemp[]{cube,crystal};
PolyTemp[] cubeS = new PolyTemp[]{cube};
PolyTemp[] octohedronS = new PolyTemp[]{octohedron};
PolyTemp[] pyramidS = new PolyTemp[]{pyramid};
PolyTemp[] crystalS = new PolyTemp[]{crystal};

void addEvents() {
	events.add(new PulseSphere(205,209,0.5));
}

void instantEvents() {
	// Intro lyrics
	if (beatInRange(201,266)) {
		if (currBeat == 201) {
			box.av.reset(0,-0.004,0);
		}
		if (currBeat % 2 == 0) box.pulse();
		if (beatInRange(201,234)) if (currBeat % 2 == 1) ringY(mLine, cubeS, -box.gy,1, 0.25,0);
		//if (currBeat % 2 == 1) box.backAdd(0, 0, 0,0, 0, box.gw*box.gx, 0.95, 125,125,125);
		if (beatInRange(234,241)) {
			if (currBeat % 1 == 0) {
				carpetX(mLine, octohedronS, -box.gx,box.gy-2,1,-2, 0.5,0);
				carpetX(mLine, octohedronS, box.gx,box.gy-2,-1,-2, 0.5,0);
			}
		} else if (beatInRange(242,250.5)) {
			if (currBeat % 1 == 0) {
				carpetZ(mLine, pyramidS, -box.gz,box.gy-2,1,-2, 0.5,0);
				carpetZ(mLine, pyramidS, box.gz,box.gy-2,-1,-2, 0.5,0);
			}
		} else if (beatInRange(251,258)) {
			if (currBeat % 1 == 0) {
				carpetX(mLine, octohedronS, -box.gx,box.gy-2,1,-2, 0.5,0);
				carpetX(mLine, octohedronS, box.gx,box.gy-2,-1,-2, 0.5,0);
			}
		}
		if (beatInRange(241,242)) {
			for (PolyS mob : box.par) if (mob.alive) mob.die();
		}
		if (currBeat % 0.5 == 0) {
			switch((int)((currBeat-201)/4)%4) {
				case 0:
				carpetZ(mLine, cubeS, -box.gz,box.gy,2, 0.5,0);
				break;
				case 1:
				carpetX(mLine, cubeS, -box.gx,box.gy-1,2, 0.5,0);
				break;
				case 2:
				carpetZ(mLine, cubeS, box.gz,box.gy,-2, 0.5,0);
				break;
				case 3:
				carpetX(mLine, cubeS, box.gx,box.gy-1,-2, 0.5,0);
				break;
			}
		}
		if (beatInRange(203,206) || beatInRange(218.5,221.5)) {
			if (currBeat % 0.5 == 0) {
				for (int i = -box.gx+1 ; i < box.gx ; i ++) box.add(mFlip, cube, i,box.gy,0, 0.5,0, 16).setT(0,-1,0, 0,0,-1);
				for (int i = -box.gx+1 ; i < box.gx ; i ++) box.add(mFlip, cube, i,box.gy,0, 0.5,0, 16).setT(0,-1,0, 0,0,1);
			}
		} else if (beatInRange(211,214) || beatInRange(226,229)) {
			if (currBeat % 0.5 == 0) {
				for (int i = -box.gz+1 ; i < box.gz ; i ++) box.add(mSwitchLine, cube, i,box.gy,i, 0.5,0, 16).setT(0,-1,0, -1,0,0);
				for (int i = -box.gz+1 ; i < box.gz ; i ++) box.add(mSwitchLine, cube, i,box.gy,i, 0.5,0, 16).setT(0,-1,0, 1,0,0);
			}
		} else if (beatInRange(235,238) || beatInRange(250.5,253.5)) {
			if (currBeat % 0.5 == 0) {
				for (int i = -box.gx+1 ; i < box.gx ; i ++) {
					for (int k = -box.gz+1 ; k < box.gz ; k ++) {
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
						mob = box.add(mSwitchLine, cube, i,box.gy,k, 0.5,0, 16);
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

		box.setFillStyle(0, 120,120,120, -25,75,-125);
	} // "Whemm" bridge
	else if (beatInRange(266,297)) {
		if (currBeat == 266) {
			box.av.reset(0,0.004,0);
			box.ang.reset(0,PI/4,0);
		}
		if (currBeat % 2 == 1) {
			ringY(mLine, cubeS, -box.gy,2, 0.25,0);
			ringY(mLine, cubeS, box.gy,-2, 0.25,0);
		}
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
			box.setFillStyle(0, 175,125,75, 55,-155,125);
		} else if (beatInRange(269.75,274)) {
			for (int i = -box.gy ; i <= box.gy ; i ++) {
				mob = box.add(mLine, pyramid, i,i,-box.gz, 0.25,0, 16);
				mob.setT(0,0,1);
			}
			box.setFillStyle(1, 75,125,175, 125,25,175);
		} else if (beatInRange(274,277.75)) {
			for (int i = -box.gy ; i <= box.gy ; i ++) {
				mob = box.add(mLine, octohedron, 0,i,box.gz, 0.25,0, 16);
				mob.setT(0,0,-1);
			}
			box.setFillStyle(0, 75,175,75, -255,100,155);
		} else if (beatInRange(277.75,282)) {
			for (int i = -box.gy ; i <= box.gy ; i ++) {
				mob = box.add(mLine, octoMid, -box.gx,i,i, 0.25,0, 16);
				mob.setT(1,0,0);
			}
			box.setFillStyle(1, 125,55,125, 125,-155,125);
		} else if (beatInRange(282,285.75)) {
			for (int i = -box.gx ; i <= box.gx ; i ++) {
				mob = box.add(mLine, cube, i,box.gy, box.gz, 0.25,0, 16);
				mob.setT(0,0,-1);
			}
			box.setFillStyle(2, 75,175,75, 155,-125,75);
		} else if (beatInRange(285.75,290)) {
			for (int i = -box.gy ; i <= box.gy ; i ++) {
				mob = box.add(mLine, octoMid, -box.gx,i,i, 0.25,0, 16);
				mob.setT(1,0,0);
			}
			box.setFillStyle(1, 175,75,75, -155,100,125);
		} else if (beatInRange(290,293.75)) {
			for (int i = -box.gx ; i <= box.gx ; i ++) {
				mob = box.add(mLine, cube, i,box.gy,-box.gz, 0.25,0, 16);
				mob.setT(0,0,1);
			}
			box.setFillStyle(2, 75,75,175, 100,25,155);
		} else if (beatInRange(293.75,298)) {
			for (int i = -box.gy ; i <= box.gy ; i ++) {
				mob = box.add(mLine, octoMid, i,i,box.gz, 0.25,0, 16);
				mob.setT(0,0,-1);
			}
			box.setFillStyle(0, 125,75,125, 100,-255,125);
		}
	} // "Whemm" melody
	else if (beatInRange(297,394)) {
		if (currBeat == 298) {
			box.av.reset(0,-0.003,0);
		}
		if (currBeat == 297) {
			for (PolyS mob : box.par) mob.die();
			ringY(mSwitch, cubeS, box.gy-1, 1, 2,0, 16);
		}
		if (beatInRange(297,329)) {
			box.setFillStyle(0, 125,125,125, 125,125,-125);
		} else if (beatInRange(329,345)) {
			box.setFillStyle(0, 125,125,125, 125,-125,125);
			if (currBeat == 329) {
				ringY(mSwitch, cubeS, 0, 1, 2,0, 8);
				box.av.reset(0,-0.005,0);
			}
			if (currBeat % 2 == 0) box.pulse();
			if (currBeat % 2 == 1) {
				ringY(mLine, cubeS, -box.gy,2, 0.25,0);
				ringY(mLine, cubeS, box.gy,-2, 0.25,0);
			}
		} else if (beatInRange(345,361)) {
			box.setFillStyle(1, 125,125,125, -125,125,-125);
			if (currBeat == 345) {
				ringX(mSwitch, cubeS, 0, 1, 1,1, 16);
			}
			if (currBeat % 2 == 0) box.pulse();
			if (currBeat % 2 == 1) {
				ringX(mLine, cubeS, -box.gx,2, 0.25,0);
				ringX(mLine, cubeS, box.gx,-2, 0.25,0);
			}
		} else if (beatInRange(361,369)) {
			box.setFillStyle(2, 125,125,125, -125,-125,125);
			if (currBeat % 2 == 0) box.pulse();
			if (currBeat % 2 == 1) {
				ringZ(mLine, cubeS, -box.gz,2, 0.25,0);
				ringZ(mLine, cubeS, box.gz,-2, 0.25,0);
			}
		} else if (beatInRange(369,378)) {
			box.setFillStyle(1, 125,125,125, 125,-125,125);
			if (currBeat == 369) {
				ringZ(mSwitch2, cubeS, -box.gy+1,1, 1,0,8);
				ringZ(mSwitch2, cubeS, box.gy-1,1, 1,0,8);
			}
			if (currBeat % 2 == 0) {
				ringX(mLine, cubeS, -box.gx,2, 0.25,0);
				ringX(mLine, cubeS, box.gx,-2, 0.25,0);
			} else if (currBeat % 2 == 1) {
				ringY(mLine, pyramidS, -box.gz,2, 0.25,0);
				ringY(mLine, pyramidS, box.gz,-2, 0.25,0);
			}
			if (currBeat % 2 == 0) box.pulse();
		} else if (beatInRange(378,386)) {
			box.setFillStyle(2, 125,125,125, 125,-125,125);
			if (currBeat % 1 == 0) {
				ringZ(mLine, cubeS, -box.gz,2, 0.25,0);
				ringZ(mLine, cubeS, box.gz,-2, 0.25,0);
			}
			if (currBeat % 2 == 1) {
				ringX(mLine, cubeS, -box.gy,2, 0.25,0);
				ringX(mLine, cubeS, box.gy,-2, 0.25,0);
			}
			if (currBeat % 2 == 0) box.pulse();
		} else if (beatInRange(386,393)) {
			box.setFillStyle(0, 125,125,125, 125,-125,125);
			if (currBeat % 2 == 1) {
				ringY(mLine, pyramidS, -box.gy,2, 0.25,0);
				ringY(mLine, pyramidS, box.gy,-2, 0.25,0);
			}
		}
		if (currBeat == 298 || currBeat == 314 || currBeat == 306 || currBeat == 322) {
			ringZ(mLine, octohedronS, -box.gz, -1, 0.25,0,16);
			ringZ(mLine, octohedronS, box.gz, 1, 0.25,0,16);
		} else if (currBeat == 302 || currBeat == 318 || currBeat == 310 || currBeat == 326) {
			ringX(mLine, octohedronS, -box.gx, -1, 0.25,0,16);
			ringX(mLine, octohedronS, box.gx, 1, 0.25,0,16);
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
		if (beatInRange(329,361) && currBeat % 2 == 0) box.pulse();
		if (beatInRange(329,331.5) || beatInRange(333.5,335.5) || beatInRange(337,339.5) || beatInRange(341,343.5) ||
			beatInRange(345,347.5) || beatInRange(349.5,351.5) || beatInRange(353,355.5) || beatInRange(357,359.5)) {
			int vx = 0; int vy = 0; int vz = 0;
			if (currBeat < 345) {
				vy = -2;
				if (random(1) < 0.5) vy = 2;
			} else {
				vx = -2;
				if (random(1) < 0.5) vx = 2;
			}
			for (int o = 0 ; o < 5 ; o ++) {
				x = random(-box.gx+1,box.gx-1);
				y = random(-box.gy+2, box.gy-2);
				z = random(-box.gz+1,box.gz-1);
				box.add(mFlip, cube, x,y,z, 0.25,0, 16).setT(vx,vy,vz);
				box.add(mFlip, cube, x,y-1,z, 0.25,0, 16).setT(vx,vy,vz);
				box.add(mFlip, cube, x,y+1,z, 0.25,0, 16).setT(vx,vy,vz);
				box.add(mFlip, cube, x-1,y,z, 0.25,0, 16).setT(vx,vy,vz);
				box.add(mFlip, cube, x+1,y,z, 0.25,0, 16).setT(vx,vy,vz);
				box.add(mFlip, cube, x,y,z-1, 0.25,0, 16).setT(vx,vy,vz);
				box.add(mFlip, cube, x,y,z+1, 0.25,0, 16).setT(vx,vy,vz);
			}
		}
		if (currBeat == 361) {
			for (PolyS mob : box.par) mob.die();
			ringZ(mSwitch2, cubeS, -2,1,1, 1,0,8);
			ringZ(mSwitch2, cubeS, 2,1,1, 1,0,8);
		}
		if (beatInRange(361,363.5) || beatInRange(365.5,367.5) || beatInRange(369,371.5) || beatInRange(373,375.5) ||
			beatInRange(377,379.5) || beatInRange(381.5,383.5) || beatInRange(385,387.5) || beatInRange(389,391.5)) {
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
	} // Outro lyrics
	else if (beatInRange(394,425)) {
		// 394,395 402,403.5 410, 418,
		if (currBeat == 394) {
			box.av.reset(0,0.002,0);
			box.ang.reset(0,PI/3,0);
			gridY(mNone, crystalS, box.gy, 0,0, 1,0,6);
		} else if (currBeat == 395.5) {
			ringY(mNone, crystalS, -box.gy,0, 0.5,0,9);
			ringX(mNone, cubeS, -box.gx,0, 0.5,0,9);
			ringX(mNone, cubeS, box.gx,0, 0.5,0,9);
		}
		if (currBeat == 402) {
			gridY(mNone, octohedronS, box.gy, 0,0, 1,0,6);
		} else if (currBeat == 403.5) {
			ringY(mNone, octohedronS, -box.gy,0, 0.5,0,9);
			ringZ(mNone, octohedronS, -box.gz,0, 0.5,0,9);
			ringZ(mNone, octohedronS, box.gz,0, 0.5,0,9);
		}
		if (currBeat == 410) {
			gridY(mNone, cubeS, box.gy, 0,0, 1,0,6);
		} else if (currBeat == 411.5) {
			ringY(mNone, cubeS, -box.gy,0, 0.5,0,9);
			ringX(mNone, cubeS, -box.gx,0, 0.5,0,9);
			ringX(mNone, cubeS, box.gx,0, 0.5,0,9);
		}
		if (currBeat == 418) {
			gridY(mNone, pyramidS, box.gy, 0,0, 1,0,6);
		} else if (currBeat == 419.5) {
			ringY(mNone, pyramidS, -box.gy,0, 0.5,0,9);
			ringZ(mNone, pyramidS, -box.gz,0, 0.5,0,9);
			ringZ(mNone, pyramidS, box.gz,0, 0.5,0,9);
		}
		if (beatInRange(395,398) || beatInRange(403,406) || beatInRange(411,414) || beatInRange(419,422)) {
			x = random(-box.gx+1,box.gx-1);
			z = random(-box.gz+1,box.gz-1);
			box.add(mSource, cube, x,box.gy-1,z, 0.25,0, 16).setT((int)random(-2,2),-1,(int)random(-2,2), 0,-2,0);
		}
		
		box.setFillStyle(0, 155,155,155, 125,-125,55);
	} // Outro buildup
	else if (beatInRange(425,497)) {
		if (beatInRange(425,434)) ringY(mLine, cubeS, box.gy,-4, 0.5,0);
		if (currBeat == 434) for (PolyS mob : box.par) mob.die();

		if (beatInRange(434,442) && currBeat % 1 == 0) {
			ringY(mFlip, cubeS, box.gy,-2, 0.5,0);
			if (currBeat % 2 == 1) ringY(mLine, octohedronS, -box.gy,2, 0.25,0);
		}
		if (beatInRange(442,449) && currBeat % 1 == 0) {
			ringZ(mFlip, pyramidS, box.gz,-2, 0.5,0);
			if (currBeat % 2 == 1) ringZ(mLine, cubeS, -box.gz,2, 0.25,0);
		}
		if (beatInRange(449,458) && currBeat % 1 == 0) {
			ringX(mFlip, octohedronS, box.gx,-2, 0.5,0);
			if (currBeat % 2 == 1) ringX(mLine, crystalS, -box.gx,2, 0.25,0);
		}
		if (beatInRange(458,461) && currBeat % 1 == 0) {
			ringY(mFlip, cubeS, box.gy,-2, 0.5,0);
			if (currBeat % 2 == 1) ringY(mLine, pyramidS, -box.gy,2, 0.25,0);
		}

		if (currBeat == 461) {
			for (PolyS mob : box.par) mob.die();
			ringY(mSwitch, cubeS, -box.gy+1, -1, 1,0);
			ringY(mSwitch, pyramidS, -2, -1, 1,0.5);
			ringY(mSwitch, cubeS, 2, -1, 1,0);
			ringY(mSwitch, pyramidS, box.gy-1, -1, 1,0.5);
		}

		if (currBeat == 465 || currBeat == 473 || currBeat == 481 || currBeat == 489 || currBeat == 493) {
			for (PolyS mob : box.par) mob.die();
		}
		if (beatInRange(465,493)) {
			if (currBeat % 2 == 0) box.pulse();
			if (beatInRange(465,473)) {
				if (currBeat % 0.25 == 0) carpetX(mLine, cubeS, -box.gx,box.gy, 2, 0.25,0);
				if (currBeat % 1 == 0) ringX(mSwitchLine, cubeS, -box.gx, 2, 1,0);
				if (currBeat % 2 == 1) ringX(mLine, octohedronS, box.gy,-2, 0.25,0);
			} else if (beatInRange(473,481)) {
				if (currBeat % 0.25 == 0) carpetZ(mLine, cubeS, -box.gz,box.gy, 2, 0.25,0);
				if (currBeat % 1 == 0) ringZ(mSwitchLine, cubeS, -box.gz, 2, 1,0);
				if (currBeat % 2 == 1) ringZ(mLine, octohedronS, box.gy,-2, 0.25,0);
			} else if (beatInRange(481,489)) {
				if (currBeat % 0.25 == 0) carpetX(mLine, cubeS, box.gx,box.gy, -2, 0.25,0);
				if (currBeat % 1 == 0) ringX(mSwitchLine, cubeS, box.gx, -2, 1,0);
				if (currBeat % 2 == 1) ringX(mLine, octohedronS, -box.gy,2, 0.25,0);
			} else if (beatInRange(489,493)) {
				if (currBeat % 0.25 == 0) carpetZ(mLine, cubeS, box.gz,box.gy, -2, 0.25,0);
				if (currBeat % 1 == 0) ringZ(mSwitchLine, cubeS, box.gz, -2, 1,0);
				if (currBeat % 2 == 1) ringZ(mLine, octohedronS, -box.gy,2, 0.25,0);
			}
		}
		if (currBeat == 493) {
			ringY(mSwitchLine, cubeS, 0, -1, 0.5,0.5);
			ringY(mSwitchLine, cubeS, box.gy/2, -1, 0.5,0.5);
			ringY(mSwitchLine, cubeS, box.gy, -1, 0.5,0.5);
		}

		box.setFillStyle(2, 155,155,155, 125,-125,75);
	} // Outro section 2
	else if (beatInRange(497,555)) {
		if (currBeat == 497) {
			for (PolyS mob : box.par) mob.die();
			ringY(mSwitch, cubeS, -box.gy+1, -1, 2,1);
			ringY(mSwitch, pyramidS, -2, -1, 2,0);
			ringY(mSwitch, cubeS, 2, -1, 2,1);
			ringY(mSwitch, pyramidS, box.gy-1, -1, 2,0);
		}
		if (currBeat % 2 == 0) box.pulse();
		if (currBeat == 522) for (PolyS mob : box.par) mob.die();
		box.setFillStyle(0, 155,155,155, 125,-125,75);
	}
	box.setIndex();
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
		setTime(204591,393.25);
		break;
		case '7':
		setTime(224954,432.25);
		break;
		case'8':
		setTime(240071,461);
		break;
		case '9':
		setTime(255744,491.25);
		break;
	}
}