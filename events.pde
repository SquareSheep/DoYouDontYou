void ringX(String[] modes, PolyTemp template, int x, int vx, float tick, float offset) {
	for (int i = -box.gz ; i <= box.gz ; i ++) box.add(modes, template, x,-box.gy,i, tick, offset, 16).setT(vx,0,0);
	for (int i = -box.gz ; i <= box.gz ; i ++) box.add(modes, template, x,box.gy,i, tick, offset, 16).setT(vx,0,0);
	for (int i = -box.gy ; i <= box.gy ; i ++) box.add(modes, template, x,i,z, tick, offset, 16).setT(vx,0,0);
	for (int i = -box.gy ; i <= box.gy ; i ++) box.add(modes, template, x,i,z, tick, offset, 16).setT(vx,0,0);
}

void ringY(String[] modes, PolyTemp template, int y, int vy, float tick, float offset) {
	for (int i = -box.gx ; i <= box.gx ; i ++) box.add(modes, template, i,y,-box.gz, tick, offset, 16).setT(0,vy,0);
	for (int i = -box.gx ; i <= box.gx ; i ++) box.add(modes, template, i,y,box.gz, tick, offset, 16).setT(0,vy,0);
	for (int i = -box.gz ; i <= box.gz ; i ++) box.add(modes, template, -box.gx,y,i, tick, offset, 16).setT(0,vy,0);
	for (int i = -box.gz ; i <= box.gz ; i ++) box.add(modes, template, box.gx,y,i, tick, offset, 16).setT(0,vy,0);
}

void ringZ(String[] modes, PolyTemp template, int z, int vz, float tick, float offset) {
	for (int i = -box.gx ; i <= box.gx ; i ++) box.add(modes, template, i,-box.gy,z, tick, offset, 16).setT(0,0,vz);
	for (int i = -box.gx ; i <= box.gx ; i ++) box.add(modes, template, i,box.gy,z, tick, offset, 16).setT(0,0,vz);
	for (int i = -box.gy ; i <= box.gy ; i ++) box.add(modes, template, -box.gx,i,z, tick, offset, 16).setT(0,0,vz);
	for (int i = -box.gy ; i <= box.gy ; i ++) box.add(modes, template, box.gx,i,z, tick, offset, 16).setT(0,0,vz);
}

void ringX(String[] modes, PolyTemp[] template, int x, int vx, float tick, float offset) {
	ringX(modes, template[(int)random(template.length)], x, vx, tick, offset);
}

void ringY(String[] modes, PolyTemp[] template, int y, int vy, float tick, float offset) {
	ringY(modes, template[(int)random(template.length)], y, vy, tick, offset);
}


void ringZ(String[] modes, PolyTemp[] template, int z, int vz, float tick, float offset) {
	ringZ(modes, template[(int)random(template.length)], z, vz, tick, offset);
}


class PointResetList extends Event {
	Point[] ar;
	float x,y,z,X,Y,Z;

	PointResetList(float time, Point[] ar, float x, float y, float z, float X, float Y, float Z) {
		super(time,time+1);
		this.ar = ar;
		this.x = x; this.y = y; this.z = z;
		this.X = X; this.Y = Y; this.Z = Z;
	}

	PointResetList(float time, Point[] ar, float x, float y, float z) {
		this(time,ar,x,y,z,x,y,z);
	}

	void spawn() {
		for (Point p : ar) {
			p.reset(x,y,z,X,Y,Z);
		}
	}
}

class PointSetMassList extends Event {
	Point[] ar;
	float mass;

	PointSetMassList(float time, Point[] ar, float mass) {
		super(time,time+1);
		this.ar = ar;
		this.mass = mass;
	}

	void spawn() {
		for (Point p : ar) {
			p.mass = mass;
		}
	}
}

class PointSetVMultList extends Event {
	Point[] ar;
	float vMult;

	PointSetVMultList(float time, Point[] ar, float vMult) {
		super(time,time+1);
		this.ar = ar;
		this.vMult = vMult;
	}

	void spawn() {
		for (Point p : ar) {
			p.vMult = vMult;
		}
	}
}

class PVectorSetList extends Event {
	PVector[] ar;
	float x,y,z;

	PVectorSetList(float time, PVector[] ar, float x, float y, float z) {
		super(time,time+1);
		this.ar = ar;
		this.x = x; this.y = y; this.z = z;
	}

	void spawn() {
		for (PVector p : ar) {
			p.set(x,y,z);
		}
	}
}

class PVectorAddList extends Event {
	PVector[] ar;
	float x,y,z;

	PVectorAddList(float time, PVector[] ar, float x, float y, float z) {
		super(time,time+1);
		this.ar = ar;
		this.x = x; this.y = y; this.z = z;
	}

	void spawn() {
		for (PVector p : ar) {
			p.add(x,y,z);
		}
	}
}

class PointReset extends Event {
	Point p;
	float x,y,z,X,Y,Z;

	PointReset(float time, Point p, float x, float y, float z, float X, float Y, float Z) {
		super(time,time+1);
		this.p = p;
		this.x = x; this.y = y; this.z = z;
		this.X = X; this.Y = Y; this.Z = Z;
	}

	PointReset(float time, Point p, float x, float y, float z) {
		this(time,p,x,y,z,x,y,z);
	}
}

class PointSetMass extends Event {
	Point p;
	float mass;

	PointSetMass(float time, Point p, float mass) {
		super(time,time+1);
		this.p = p;
		this.mass = mass;
	}

	void spawn() {
		p.mass = mass;
	}
}

class PointSetVMult extends Event {
	Point p;
	float vMult;

	PointSetVMult(float time, Point p, float vMult) {
		super(time,time+1);
		this.p = p;
		this.vMult = vMult;
	}

	void spawn() {
		p.vMult = vMult;
	}
}

class SpringValueSetX extends Event {
	SpringValue spr;
	float x;

	SpringValueSetX(float time, SpringValue spr, float x) {
		super(time,time+1);
		this.spr = spr;
		this.x = x;
	}

	void spawn() {
		spr.X = x;
	}
}

class SpringValueSetx extends Event {
	SpringValue spr;
	float x;

	SpringValueSetx(float time, SpringValue spr, float x) {
		super(time,time+1);
		this.spr = spr;
		this.x = x;
	}

	void spawn() {
		spr.x = x;
	}
}

class PVectorSet extends Event {
	PVector p;
	float x,y,z;

	PVectorSet(float time, PVector p, float x, float y, float z) {
		super(time,time+1);
		this.p = p;
		this.x = x; this.y = y; this.z = z;
	}

	void spawn() {
		p.set(x,y,z);
	}
}

class PVectorAdd extends Event {
	PVector p;
	float x,y,z;

	PVectorAdd(float time, PVector p, float x, float y, float z) {
		super(time,time+1);
		this.p = p;
		this.x = x; this.y = y; this.z = z;
	}

	void spawn() {
		p.add(x,y,z);
	}
}

class FillStyleSetC extends Event {
	IColor fillStyle;
	float r,g,b,a;

	FillStyleSetC(float time, IColor fillStyle, float r, float g, float b, float a) {
		super(time, time+1);
		this.fillStyle = fillStyle;
		this.r = r; this.g = g; this.b = b; this.a = a;
	}

	void spawn() {
		fillStyle.setC(r,g,b,a);
	}
}

class FillStyleSetM extends Event {
	IColor fillStyle;
	float r,g,b,a;

	FillStyleSetM(float time, IColor fillStyle, float r, float g, float b, float a) {
		super(time, time+1);
		this.fillStyle = fillStyle;
		this.r = r; this.g = g; this.b = b; this.a = a;
	}

	void spawn() {
		fillStyle.setM(r,g,b,a);
	}
}

class FillStyleSetMass extends Event {
	IColor fillStyle;
	float mass;

	FillStyleSetMass(float time, IColor fillStyle, float mass) {
		super(time, time+1);
		this.fillStyle = fillStyle;
		this.mass = mass;
	}

	void spawn() {
		fillStyle.setMass(mass);
	}
}

class FillStyleSetVMult extends Event {
	IColor fillStyle;
	float vMult;

	FillStyleSetVMult(float time, IColor fillStyle, float vMult) {
		super(time, time+1);
		this.fillStyle = fillStyle;
		this.vMult = vMult;
	}

	void spawn() {
		fillStyle.setMass(vMult);
	}
}