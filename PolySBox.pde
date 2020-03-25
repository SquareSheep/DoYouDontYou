class PolySBox extends Mob {
	ArrayList<PolyS> ar = new ArrayList<PolyS>();
	int arm = 0;
	ArrayList<PolyS> par = new ArrayList<PolyS>();
	RingPool rings = new RingPool();
	int gx; int gy; int gz;
	float gw;
	boolean checkBorders = true;
	boolean dieBorders = true;
	boolean drawBorders = false;

	boolean flag;

	PolySBox(int x, int y, int z, int wx, int wy, int wz, float gw) {
		p = new Point(x*gw,y*gw,z*gw);
		ang = new Point();
		w = new Point(wx*gw,wy*gw,wz*gw);
		gx = wx; gy = wx; gz = wz;
		this.gw = gw;
	}

	void update() {
		super.update();
		for (int i = arm - 1 ; i >= 0 ; i --) {
			ar.get(i).update();
		}
		for (int i = 0 ; i < arm ; i ++) {
			if (ar.get(i).finished) remove(i);
		}
		rings.update();
		gx = (int)(w.p.x/gw);
		gy = (int)(w.p.y/gw);
		gz = (int)(w.p.z/gw);
		if (checkBorders) {
			for (int i = arm - 1 ; i >= 0 ; i --) {
				PolyS mob = ar.get(i);
				if (checkMobBorder(mob) && dieBorders) {
					if (mob.alive) mob.die();
				}
			}
		}
	}

	void render() {
		push();
		translate(p.p.x, p.p.y, p.p.z);
		rotateX(ang.p.x);
		rotateY(ang.p.y);
		rotateZ(ang.p.z);
		if (drawBorders) {
			stroke(255);
			noFill();
			box(w.p.x*2+gw*2,w.p.y*2+gw*2,w.p.z*2+gw*2);
		}
		rings.render();
		for (int i = 0 ; i < arm ; i ++) {
			PolyS mob = ar.get(i);
			mob.render();
		}
		pop();
	}

	void pulse(float amp) {
		pulse(amp, 0,box.w.p.x*2);
	}

	void pulse(float amp, float minDist, float maxDist) {
		for (PolyS mob : par) {
			temp = sqrt(mob.p.p.x*mob.p.p.x+mob.p.p.y*mob.p.p.y+mob.p.p.z*mob.p.p.z);
			if (temp < minDist || temp > maxDist) continue;
			if (mob.p.p.x != 0) {
				x = -(mob.p.p.x)/temp;
			} else {
				x = 0;
			}
			if (mob.p.p.y != 0) {
				y = -(mob.p.p.y)/temp;
			} else {
				y = 0;
			}
			if (mob.p.p.z != 0) {
				z = -(mob.p.p.z)/temp;
			} else {
				z = 0;
			}
			mob.p.v.add(x*amp, y*amp, z*amp);
		}
	}

	void pulse() {
		pulse(gw*0.3);
	}

	PolyS add(String[] modes, PolyTemp template, float x, float y, float z, float tick, float tickOffset, int maxSteps) {
		PolyS mob;
		if (ar.size() == arm) {
			mob = new PolyS();
			mob.parent = this;
			ar.add(mob);
		} else {
			mob = get();
		}
		x = (int)min(max(x,-gx),gx);
		y = (int)min(max(y,-gy),gy);
		z = (int)min(max(z,-gz),gz);
		mob.reset(modes, template, x,y,z, gw, tick, tickOffset, maxSteps);
		mob.id = arm;
		mob.checkBorders = true;
		arm ++;
		par.add(mob);
		return mob;
	}

	PolyS add(String[] modes, PolyTemp[] template, float x, float y, float z, float tick, float tickOffset, int maxSteps) {
		return add(modes, template[(int)random(template.length)], x,y,z, tick, tickOffset, maxSteps);
	}

	void remove(int i) {
		ar.add(ar.remove(i));
		par.remove(i);
		arm --;
	}

	PolyS get() {
		return ar.get(arm);
	}

	PolyS get(float i) {
		return ar.get((int)i);
	}

	void setW(float x, float y, float z) {
		w.P.set(gw*(int)x, gw*(int)y, gw*(int)z);
	}

	void backAdd(int wall, int type, float x, float y, float W, float wMax, float amp, float r, float g, float b) {
		float bw = w.p.x*0.5;
		Ring mob;
		switch (wall) {	
			default:
			mob = rings.add(type, x,y,-bw, 0,0,0, W, wMax, amp);
		}
		mob.fillStyle.reset(r,g,b,255);
	}

	void setFillStyle(int mode, float rc, float gc, float bc, float rcr, float gcr, float bcr) {
		float x,y,z,t;
		temp = (float)frameCount/15;
		float amp = 0.007;
		float sAmp = 0.1;
		float fAmp = 0.9;
		for (int i = 0 ; i < arm ; i ++) {
			PolyS mob = ar.get(i);
			t = (float)i/arm-0.5;
			x2 = mob.p.p.x/w.p.x*(noise(temp)*2+0.25);
			y2 = mob.p.p.y/w.p.y*(noise(temp*1.2)*2+0.25);
			z2 = mob.p.p.z/w.p.z*(noise(temp*0.9)*2+0.25);
			switch(mode) {
				case 0:
				x = (x2+y2); y = (y2+z2); z = (z2+x2);
				break;
				case 1:
				y = (x2+y2); z = (y2+z2); x = (z2+x2);
				break;
				case 2:
				z = (x2+y2); x = (y2+z2); y = (z2+x2);
				break;
				default:
				x = (x2+y2); y = (y2+z2); z = (z2+x2);
				break;	
			}
			
			mob.setStrokeStyle((rc+x*rcr)*sAmp,(gc+y*gcr)*sAmp,(bc+z*bcr)*sAmp,255, rcr,gcr,bcr,0, rc*amp,gc*amp,bc*amp,0, x*amp,y*amp,z*amp,0);
			mob.setFillStyle((rc+x*rcr)*fAmp,(gc+y*gcr)*fAmp,(bc+z*bcr)*fAmp,155, rcr,gcr,bcr,0, rc*amp,gc*amp,bc*amp,1, x*amp,y*amp,z*amp,0);
		}
		for (int i = 0 ; i < rings.arm ; i ++) {
			Ring mob = rings.ar.get(i);
			t = (float)i/arm-0.5;
			x2 = mob.p.p.x/w.p.x*(noise(temp)*2);
			y2 = mob.p.p.y/w.p.y*(noise(temp*1.2)*2);
			z2 = mob.p.p.z/w.p.z*(noise(temp*0.9)*2);
			switch(mode) {
				case 0:
				x = (x2+y2); y = (y2+z2); z = (z2+x2);
				break;
				case 1:
				y = (x2+y2); z = (y2+z2); x = (z2+x2);
				break;
				case 2:
				z = (x2+y2); x = (y2+z2); y = (z2+x2);
				break;
				default:
				x = (x2+y2); y = (y2+z2); z = (z2+x2);
				break;	
			}
			mob.fillStyle.setC((rc+x*rcr)*fAmp,(gc+y*gcr)*fAmp,(bc+z*bcr)*fAmp,255);
		}
	}

	void setIndex() {
		for (int i = 0 ; i < arm ; i ++) {
			PolyS mob = ar.get(i);
			mob.setIndex(i%binCount);
		}
	}

	boolean checkMobBorder(PolyS mob) {
		if (!mob.checkBorders) return false;
		flag = false;
		if (mob.p.p.x < -w.p.x - gw/2) {
			mob.p.P.x = -w.p.x - gw/2;
			mob.p.p.x = -w.p.x - gw/2;
			flag = true;
		}
		if (mob.p.p.y < -w.p.y - gw/2) {
			mob.p.P.y = -w.p.y - gw/2;
			mob.p.p.y = -w.p.y - gw/2;
			flag = true;
		}
		if (mob.p.p.z < -w.p.z - gw/2) {
			mob.p.P.z = -w.p.z - gw/2;
			mob.p.p.z = -w.p.z - gw/2;
			flag = true;
		}
		if (mob.p.p.x > w.p.x + gw/2) {
			mob.p.P.x = w.p.x + gw/2;
			mob.p.p.x = w.p.x + gw/2;
			flag = true;
		}
		if (mob.p.p.y > w.p.y + gw/2) {
			mob.p.P.y = w.p.y + gw/2;
			mob.p.p.y = w.p.y + gw/2;
			flag = true;
		}
		if (mob.p.p.z > w.p.z + gw/2) {
			mob.p.P.z = w.p.z + gw/2;
			mob.p.p.z = w.p.z + gw/2;
			flag = true;
		}
		return flag;
	}
}