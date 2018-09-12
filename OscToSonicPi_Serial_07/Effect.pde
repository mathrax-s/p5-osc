class Effect {

  float bright;
  int xx, yy, ww, hh;
  color col;

  Effect(int x, int y, int w, int h, color c) {
    bright = 0;
    col = c;
  }

  void draw() {
    bright*=0.9;
    fill(col);
    rect(xx, yy*bright, ww, hh*bright);
  }

  void setBright(int x, int y, color c, float b) {
    xx = x;
    yy = y;
    bright = b;
  }
}