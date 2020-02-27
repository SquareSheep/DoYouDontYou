Poly newPoly(float type, float x, float y, float z, float ax, float ay, float az, float w) {
  Poly poly;
  switch ((int)type) {
    case 0: // Pyramid
    poly = new Poly(x,y,z, ax,ay,az, w, new float[]{-1,-1,-1, 1,-1,-1, 1,1,-1, -1,1,-1, 0,0,1},
    new int[][]{new int[]{0,1,2,3}, new int[]{0,1,4}, new int[]{1,2,4}, new int[]{2,3,4}, new int[]{3,0,4}});
    break;
    case 1: // Box
    poly = new Poly(x,y,z, ax,ay,az, w, new float[]{-1,-1,-1, 1,-1,-1, 1,1,-1, -1,1,-1, -1,-1,1, 1,-1,1, 1,1,1, -1,1,1},
    new int[][]{new int[]{0,1,2,3}, new int[]{0,1,5,4}, new int[]{1,2,6,5}, new int[]{2,3,7,6}, new int[]{3,0,4,7}, new int[]{4,5,6,7}});
    break;
    case 2: // Crystal
    poly = new Poly(x,y,z, ax,ay,az, w, new float[]{-1,-1,-1, 1,-1,-1, 1,1,-1, -1,1,-1, -1,-1,1, 1,-1,1, 1,1,1, -1,1,1, 0,2.5,0, 0,-2.5,0},
      new int[][]{new int[]{0,1,2,3}, new int[]{0,1,5,4}, new int[]{1,2,6,5}, new int[]{2,3,7,6}, new int[]{3,0,4,7}, new int[]{4,5,6,7},
      new int[]{9,0,1}, new int[]{9,1,5}, new int[]{9,4,5}, new int[]{9,4,0}}); //0,1,4,5
    break;
    default:
    poly = new Poly();
    break;
  }
  return poly;
}

class Poly extends PolyS {
  Point[] vert;
  int[][] faces;

  Poly(float x, float y, float z, float ax, float ay, float az, float w, float[] vert, int[][] faces) {
    this.p = new Point(x,y,z);
    this.ang = new Point(ax,ay,az);
    this.gw = w*2;
    this.w = w;
    this.vert = new Point[vert.length/3];
    this.faces = faces;
    fillStyle = new IColor[faces.length];
    strokeStyle = new IColor[faces.length];

    for (int i = 0 ; i < vert.length ; i += 3) {
      this.vert[i/3] = new Point(vert[i]*w, vert[i+1]*w, vert[i+2]*w);
    }
    for (int i = 0 ; i < faces.length ; i ++) {
      fillStyle[i] = defaultFill.copy();
      strokeStyle[i] = defaultStroke.copy();
    }
  }

  Poly() {}

  void update() {
    super.update();
    for (int i = 0 ; i < vert.length ; i ++) {
      vert[i].update();
    }
  }

  void render() {
    setDraw();
    for (int i = 0 ; i < faces.length ; i ++) {
      fillStyle[i].fillStyle();
      strokeStyle[i].strokeStyle();
      beginShape();
      for (int k = 0 ; k < faces[i].length ; k ++) {
        vertex(vert[faces[i][k]].p.x, vert[faces[i][k]].p.y, vert[faces[i][k]].p.z);
      }
      vertex(vert[faces[i][0]].p.x, vert[faces[i][0]].p.y, vert[faces[i][0]].p.z);
      endShape();
    }
    pop();
  }
}