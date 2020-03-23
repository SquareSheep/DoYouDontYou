class PolySBox extends Entity {
	ArrayList<PolyS> ar = new ArrayList<PolyS>();
	int arm = 0;
	ArrayList<PolyS> par = new ArrayList<PolyS>();
	RingPool rings = new RingPool();
	Point p;
	Point w;
	Point ang;
	int gx; int gy; int gz;
	float gw;
	boolean checkBorders = true;
	boolean dieBorders = true;
	boolean drawBorders = true;

	boolean flag;

	PolySBox(int x, int y, int z, int wx, int wy, int wz, float gw) {
		p = new Point(x*gw,y*gw,z*gw);
		ang = new Point();
		w = new Point(wx*gw,wx*gw,wz*gw);
		gx = wx; gy = wx; gz = wz;
		this.gw = gw;
	}

	void update() {
		for (int i = arm - 1 ; i >= 0 ; i --) {
			ar.get(i).update();
		}
		for (int i = 0 ; i < arm ; i ++) {
			if (ar.get(i).finished) remove(i);
		}
		rings.update();
		w.update();
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
		for (PolyS mob : par) {
			temp = sqrt(mob.p.p.x*mob.p.p.x+mob.p.p.y*mob.p.p.y+mob.p.p.z*mob.p.p.z);
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

	void setFillStyle(float rc, float gc, float bc, float rcr, float gcr, float bcr, 
		float rm, float gm, float bm, float rmr, float gmr, float bmr) {
		float x,y,z,t;
		for (int i = 0 ; i < arm ; i ++) {
			PolyS mob = ar.get(i);
			t = (float)i/arm-0.5;
			x2 = mob.p.p.x/w.p.x;
			y2 = mob.p.p.y/w.p.y;
			z2 = mob.p.p.z/w.p.z;
			x = (x2+y2);
			y = (y2+z2);
			z = (z2+x2);
			mob.setStrokeStyle(rc+t*rcr,gc+t*gcr,bc+t*bcr,255, rcr,gcr,bcr,0, rm+t*rmr,gm+t*gmr,bm+t*bmr,0, rmr,gmr,bmr,0);
			mob.setFillStyle((rc+t*rcr)*0.5,(gc+t*gcr)*0.5,(bc+t*bcr)*0.5,175, rcr,gcr,bcr,0, rm+t*rmr,gm+t*gmr,bm+t*bmr,1, rmr,gmr,bmr,0);
			// mob.setStrokeStyle(rc+x*rcr,gc+y*gcr,bc+z*bcr,255, rcr,gcr,bcr,0, rm+x*rmr,gm+y*gmr,bm+z*bmr,0, rmr,gmr,bmr,0);
			// mob.setFillStyle((rc+x*rcr)*0.5,(gc+y*gcr)*0.5,(bc+z*bcr)*0.5,175, rcr,gcr,bcr,0, rm+x*rmr,gm+y*gmr,bm+z*bmr,1, rmr,gmr,bmr,0);
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