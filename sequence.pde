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


void instantEvents() {
	// Intro lyrics
	if (beatInRange(201,266)) {
		if (currBeat == 201) {
			cam.ang.reset(-0.4,0,0);
			cam.av.P.set(0,0.001,0);
		}
		if (currBeat % 2 == 0) box.pulse();
		if (beatInRange(234,241)) {
			if (currBeat % 1 == 0) {
				carpetX(mLine, cubeS, -box.gx,box.gy-3,2,-2, 0.25,0);
			}
		} else if (beatInRange(242,250.5)) {
			if (currBeat % 1 == 0) {
				carpetZ(mLine, cubeS, -box.gz,box.gy-3,2,-2, 0.25,0);
			}
		} else if (beatInRange(251,258)) {
			if (currBeat % 1 == 0) {
				carpetX(mLine, cubeS, -box.gx,box.gy-3,2,-2, 0.25,0);
			}
		}
		if (beatInRange(241,242)) {
			for (PolyS mob : box.par) if (mob.alive) mob.die();
			for (PolyS mob : box2.par) if (mob.alive) mob.die();
		}
		switch((int)((currBeat-201)/4)%4) {
			case 0:
			carpetZ(mLine, cubeS, -box.gz,box.gy,2, 0.25,0);
			break;
			case 1:
			carpetX(mLine, cubeS, -box.gx,box.gy-1,2, 0.25,0);
			break;
			case 2:
			carpetZ(mLine, cubeS, box.gz,box.gy,-2, 0.25,0);
			break;
			case 3:
			carpetX(mLine, cubeS, box.gx,box.gy-1,-2, 0.25,0);
			break;
		}
		if (beatInRange(203,206) || beatInRange(218.5,221.5)) {
			if (currBeat % 0.5 == 0) {
				for (int i = -box.gx ; i <= box.gx ; i ++) box.add(mFlip, cube, i,box.gy,0, 0.5,0, 16).setT(0,-1,0, 0,0,-1);
				for (int i = -box.gx ; i <= box.gx ; i ++) box.add(mFlip, cube, i,box.gy,0, 0.5,0, 16).setT(0,-1,0, 0,0,1);
			}
		} else if (beatInRange(211,214) || beatInRange(226,229)) {
			if (currBeat % 0.5 == 0) {
				for (int i = -box.gz ; i <= box.gz ; i ++) box.add(mFlip, cube, i,box.gy,i, 0.5,0, 16).setT(0,-1,0, -1,0,0);
				for (int i = -box.gz ; i <= box.gz ; i ++) box.add(mFlip, cube, i,box.gy,i, 0.5,0, 16).setT(0,-1,0, 1,0,0);
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
	else if (beatInRange(297,394)) {
		if (currBeat == 297) {
			// box.setW(5,5,5);
			for (PolyS mob : box.par) mob.die();
			for (PolyS mob : box2.par) mob.die();
			ringY(mSwitch, cubeS, -box.gy+1,1, 2,1);
			ringY(mSwitch, cubeS, box.gy-1,1, 2,1);
		}
		if (currBeat == 318) { // Violin note
			box.add(mSource, cube, 3,3,3, 0.25,0, 16).setT(0,0,0, 0,-2,0);
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
		if (beatInRange(329,361)) {
			if (currBeat % 2 == 0) box.pulse();
			if (currBeat % 2 == 1) {
				ringY(mLine, pyramidS, -box.gy,2, 0.25,0);
				ringY(mLine, pyramidS, box.gy,-2, 0.25,0);
			}
		}
		if (beatInRange(329,361) && currBeat % 2 == 0) box.pulse();
		if (beatInRange(329,331.5) || beatInRange(333.5,335.5) || beatInRange(337,339.5) || beatInRange(341,343.5) ||
			beatInRange(345,347.5) || beatInRange(349.5,351.5) || beatInRange(353,355.5) || beatInRange(357,359.5)) {
			for (int o = 0 ; o < 3 ; o ++) {
				x = random(-box.gx+1,box.gx-1);
				z = random(-box.gz+1,box.gz-1);
				box.add(mFlip, cube, x,box.gy-1,z, 0.25,0, 16).setT(0,-2,0);

				box.add(mFlip, cube, x,box.gy-2,z, 0.25,0, 16).setT(0,-2,0);
				box.add(mFlip, cube, x,box.gy,z, 0.25,0, 16).setT(0,-2,0);

				box.add(mFlip, cube, x-1,box.gy-1,z, 0.25,0, 16).setT(0,-2,0);
				box.add(mFlip, cube, x+1,box.gy-1,z, 0.25,0, 16).setT(0,-2,0);
				
				box.add(mFlip, cube, x,box.gy-1,z-1, 0.25,0, 16).setT(0,-2,0);
				box.add(mFlip, cube, x,box.gy-1,z+1, 0.25,0, 16).setT(0,-2,0);
			}
		}
		if (beatInRange(361,369)) {
			if (currBeat % 1 == 0) {
				ringY(mLine, octohedronS, -box.gy,2, 0.25,0);
				ringY(mLine, octohedronS, box.gy,-2, 0.25,0);
			}
			if (currBeat % 2 == 0) box.pulse();
		}
		if (beatInRange(369,391)) {
			if (currBeat % 1 == 0) {
				ringZ(mLine, octohedronS, -box.gz,2, 0.25,0);
				ringZ(mLine, octohedronS, box.gz,-2, 0.25,0);
			}
			if (currBeat % 2 == 0) box.pulse();
		}
		if (currBeat == 361) {
			for (PolyS mob : box.par) mob.die();
			for (PolyS mob : box2.par) mob.die();
			ringY(mSwitch, cubeS, -box.gy+1,1, 1,0);
			ringY(mSwitch, cubeS, box.gy-1,1, 1,0);
		}
		if (beatInRange(361,363.5) || beatInRange(365.5,367.5) || beatInRange(369,371.5) || beatInRange(373,375.5) ||
			beatInRange(377,379.5) || beatInRange(381.5,383.5) || beatInRange(385,387.5) || beatInRange(389,391.5)) {
			for (int o = 0 ; o < 3 ; o ++) {
				x = random(-box.gx+1,box.gx-1);
				z = random(-box.gz+1,box.gz-1);
				box.add(mFlip, cube, x,box.gy-1,z, 0.25,0, 16).setT(0,-2,0);
				box.add(mFlip, cube, x,box.gy-2,z, 0.25,0, 16).setT(0,-2,0);
				box.add(mFlip, cube, x,box.gy,z, 0.25,0, 16).setT(0,-2,0);
				box.add(mFlip, cube, x-1,box.gy-1,z, 0.25,0, 16).setT(0,-2,0);
				box.add(mFlip, cube, x+1,box.gy-1,z, 0.25,0, 16).setT(0,-2,0);
				box.add(mFlip, cube, x,box.gy-1,z-1, 0.25,0, 16).setT(0,-2,0);
				box.add(mFlip, cube, x,box.gy-1,z+1, 0.25,0, 16).setT(0,-2,0);
			}
		}
		box.setFillStyle(155,155,155, 125,-125,125, 0,0,0, 2,2,2);
		box2.setFillStyle(55,55,55, 125,-125,125, 0,0,0, 1,1,1);
	} // Outro lyrics
	else if (beatInRange(394,425)) {
		// 394,395 402,403.5 410, 418,
		if (currBeat == 394) {
			cam.ang.reset(-0.4,0,0);
			cam.av.P.set(0,0.001,0);
			gridY(mNone, crystalS, box.gy,0, 1,0,6);
		} else if (currBeat == 395.5) {
			gridY(mNone, cubeS, -box.gy,0, 0.5,0,9);
		}
		if (currBeat == 402) {
			gridY(mNone, cubeS, box.gy,0, 1,0,6);
		} else if (currBeat == 403.5) {
			gridY(mNone, octohedronS, -box.gy,0, 0.5,0,9);
		}
		if (currBeat == 410) {
			gridY(mNone, cubeS, box.gy,0, 1,0,6);
		} else if (currBeat == 411.5) {
			gridY(mNone, crystalS, -box.gy,0, 0.5,0,9);
		}
		if (currBeat == 418) {
			gridY(mNone, crystalS, box.gy,0, 1,0,6);
		} else if (currBeat == 419.5) {
			gridY(mNone, pyramidS, -box.gy,0, 0.5,0,9);
		}
		if (beatInRange(395,398) || beatInRange(403,406) || beatInRange(411,414) || beatInRange(419,422)) {
			x = random(-box.gx+1,box.gx-1);
			z = random(-box.gz+1,box.gz-1);
			box.add(mSource, cube, x,box.gy-1,z, 0.25,0, 16).setT((int)random(-2,2),-1,(int)random(-2,2), 0,-2,0);
		}
		
		box.setFillStyle(155,155,155, 125,-125,125, 0,0,0, 2,2,2);
		box2.setFillStyle(55,55,55, 125,-125,125, 0,0,0, 1,1,1);
	} // Outro buildup
	else if (beatInRange(425,434)) {
		//425..434
		ringY(mLine, cubeS, box.gy,-4, 0.5,0);
		box.setFillStyle(155,155,155, 125,-125,125, 0,0,0, 2,2,2);
		box2.setFillStyle(55,55,55, 125,-125,125, 0,0,0, 1,1,1);
	} // Outro section
	else if (beatInRange(434,497)) {
		if (currBeat == 434) for (PolyS mob : box.par) mob.die();
		if (beatInRange(434,442) && currBeat % 1 == 0) ringY(mFlip, cubeS, box.gy,-2, 0.5,0);
		if (beatInRange(442,449) && currBeat % 1 == 0) ringZ(mFlip, pyramidS, box.gz,-2, 0.5,0);
		if (beatInRange(449,458) && currBeat % 1 == 0) ringX(mFlip, octohedronS, box.gx,-2, 0.5,0);
		if (beatInRange(458,461) && currBeat % 1 == 0) ringY(mFlip, cubeS, box.gy,-2, 0.5,0);
		if (currBeat == 461) {
			for (PolyS mob : box.par) mob.die();
			ringY(mSwitch, cubeS, -3, -1, 0.5,0);
			ringY(mSwitch, cubeS, 3, -1, 0.5,0);
		} else if (currBeat == 465) {
			for (PolyS mob : box.par) mob.die();
			ringX(mSwitch, octohedronS, 0, -1, 1,0);
		}
		if (beatInRange(465,473)) {
			if (currBeat % 0.25 == 0) carpetX(mLine, cubeS, -box.gx,box.gy, 1, 0.25,0);
		} else if (beatInRange(473,481)) {
			if (currBeat % 0.25 == 0) carpetZ(mLine, cubeS, -box.gz,box.gy, 1, 0.25,0);
		} else if (beatInRange(481,489)) {
			if (currBeat % 0.25 == 0) carpetX(mLine, cubeS, -box.gx,box.gy, 1, 0.25,0);
		} else if (beatInRange(489,494)) {
			if (currBeat % 0.25 == 0) carpetZ(mLine, cubeS, -box.gx,box.gy, 1, 0.25,0);
		}
		if (currBeat == 494) {
			ringY(mSwitchLine, cubeS, box.gy, -1, 0.5,0.5);
			ringY(mSwitchLine, cubeS, 0, -1, 0.5,0.5);
		}

		box.setFillStyle(155,155,155, 125,-125,125, 0,0,0, 2,2,2);
		box2.setFillStyle(55,55,55, 125,-125,125, 0,0,0, 1,1,1);
	} // Outro section 2
	else if (beatInRange(497,555)) {
		if (currBeat == 497) {
			for (PolyS mob : box.par) mob.die();
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
		setTime(204591,393.25);
		break;
		case '7':
		setTime(224954,432.25);
		break;
		case '8':
		setTime(255744,491.25);
		break;
	}
}

void addEvents() {

}