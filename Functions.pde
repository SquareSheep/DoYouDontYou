/*
Useful general-purpose functions
*/
int ceilR(float x) {
	if (x > 0) {
		return ceil(x);
	} else {
		return (int)x;
	}
}

int floorR(float x) {
	if (x > 0) {
		return (int)x;
	} else {
		return ceil(x);
	}
}

float randomR(float minR, float maxR) {
	if (random(1) < 0.5) {
		return random(-maxR,-minR);
	} else {
		return random(minR,maxR);
	}
}

int randomD() {
	if (random(1) > 0.5) {
		return 1;
	}
	return -1;
}

void fillStyleSet(IColor[] fillStyle, float rc, float gc, float bc, float ac, float rcr, float gcr, float bcr, float acr, 
	float rm, float gm, float bm, float am, float rmr, float gmr, float bmr, float amr, float index) {
	float t;
	for (int i = 0 ; i < fillStyle.length ; i ++) {
		t = (float)i/fillStyle.length-0.5;
		fillStyle[i].set(rc+rcr*t,gc+gcr*t,bc+bcr*t,ac+acr*t,rm+rmr*t,gm+gmr*t,bm+bmr*t,am+amr*t,index);
	}
}

void fillStyleSet(IColor[] fillStyle, float rc, float gc, float bc, float ac, float rm, float gm, float bm, float am, float index) {
	for (int i = 0 ; i < fillStyle.length ; i ++) fillStyle[i].set(rc,gc,bc,ac,rm,gm,bm,am,index);
}

void fillStyleSetC(IColor[] fillStyle, float r, float g, float b, float a, float rr, float gr, float br, float ar) {
	float t;
	for (int i = 0 ; i < fillStyle.length ; i ++) {
		t = (float)i/fillStyle.length-0.5;
		fillStyle[i].setC(r+rr*t,g+gr*t,b+br*t,a+ar*t);
	}
}

void fillStyleSetC(IColor[] fillStyle, float r, float g, float b, float a) {
	for (int i = 0 ; i < fillStyle.length ; i ++) fillStyle[i].setC(r,g,b,a);
}

void fillStyleSetM(IColor[] fillStyle, float r, float g, float b, float a, float rr, float gr, float br, float ar) {
	float t;
	for (int i = 0 ; i < fillStyle.length ; i ++) {
		t = (float)i/fillStyle.length-0.5;
		fillStyle[i].setM(r+rr*t,g+gr*t,b+br*t,a+ar*t);
	}
}

void fillStyleSetM(IColor[] fillStyle, float r, float g, float b, float a, float index) {
	for (int i = 0 ; i < fillStyle.length ; i ++) fillStyle[i].setM(r,g,b,a,index);
}

void fillStyleSetMass(IColor[] fillStyle, float mass) {
	for (int i = 0 ; i < fillStyle.length ; i ++) fillStyle[i].setMass(mass);
}

void fillStyleSetVMult(IColor[] fillStyle, float vMult) {
	for (int i = 0 ; i < fillStyle.length ; i ++) fillStyle[i].setVMult(vMult);
}