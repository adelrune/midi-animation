import de.looksgood.ani.*;
import de.looksgood.ani.easing.Easing;
import org.gicentre.handy.*;

float xsim(float x) {
  return width - x;
}

float ysim(float y) {
  return height - y;
}


interface Drawable {
  void draw();
}

interface Renderable extends Drawable{
  void render();
}

class CanDie {
  void die() {
    renderables.remove(this);
  };
}
public abstract class HandyThing extends CanDie {
  //This needs to know the render angle of the object to set hashure angle correctly.
  float angle;
  int fillch = (int)random(0,100);
  int fillcs = (int)random(0,100);
  int fillcv = (int)random(0,100);
  boolean isHandy = true;
  int fillsch = -1;
  int fillscs = -1;
  int fillscv = -1;
  boolean alt = false;
  int strokech = (int)random(0,100);
  int strokecs = (int)random(0,100);
  int strokecv = (int)random(0,100);
  float strokew = 0.0f;
  boolean isstroke = false;
  boolean issfill = true;
  float hangl = 55;
  float hpangl = 0;
  float fillg = 2;
  float fillw = 0.2;
  float rough = 2.0;
  HandyRenderer hr;
  HandyThing() {
    hr = new HandyRenderer(that);
  }

  float getAngle() {
    return angle;
  }

  void presetrender() {
    if (isstroke) {
      hr.setOverrideStrokeColour(true);
      stroke(color(strokech,strokecs,strokecv));
      strokeWeight(strokew);
    } else {
      hr.setOverrideStrokeColour(false);
      noStroke();
    }
    if (issfill) {
      hr.setOverrideFillColour(true);
      hr.setFillColour(color(fillch, fillcs, fillcv));
      fill(color(fillch, fillcs, fillcv));
    } else {
      hr.setOverrideFillColour(false);
      noFill();
    }

    hr.setFillWeight(fillw);
    hr.setRoughness(rough);
    hr.setHachurePerturbationAngle(hpangl);
    hr.setFillGap(fillg);
    hr.setFillWeight(fillw);

    hr.setHachureAngle(getAngle() + hangl);
    hr.setIsAlternating(alt);
    hr.setUseSecondaryColour(fillsch > 0);
    hr.setSecondaryColour(color(fillsch, fillscs, fillscv));
    hr.setFillColour(color(fillch, fillcs, fillcv));
    hr.setIsHandy(isHandy);
  }
}

public abstract class Animatable extends HandyThing implements Renderable {
  float x = random(10, width -10);
  float y = random(10, height -10);
  void render() {
    presetrender();
    pushMatrix();
    translate(x, y);
    rotate(radians(getAngle()));
    draw();
    popMatrix();
  }
  public void animate(){};
  public void animate(int dur, int delay, String var, float value, Easing curve, String callback) {
    Ani.to(this, dur*2, delay*2, var, value, curve, callback);
  }
  public void animate(int dur, String var, float value, Easing curve, String callback) {
    Ani.to(this, dur*2, var, value, curve, callback);
  }
  public void animate(int dur, int delay, String var, float value, Easing curve) {
    Ani.to(this, dur*2, delay*2, var, value, curve);
  }
  public void animate(int dur, String var, float value, Easing curve) {
    Ani.to(this, dur*2, var, value, curve);
  }

  public void animate(int dur, int delay, String var, int value, Easing curve, String callback) {
    Ani.to(this, dur*2, delay*2, var, value, curve, callback);
  }
  public void animate(int dur, String var, int value, Easing curve, String callback) {
    Ani.to(this, dur*2, var, value, curve, callback);
  }
  public void animate(int dur, int delay, String var, int value, Easing curve) {
    Ani.to(this, dur*2, delay*2, var, value, curve);
  }
  public void animate(int dur, String var, int value, Easing curve) {
    Ani.to(this, dur*2, var, value, curve);
  }
}

class Rect extends Animatable implements Renderable  {
  float w = 100;
  float h = 100;
  Rect() {
  }
  void draw() {
    hr.rect(0,0,w,h);
  }
}

class Circle extends Animatable implements Renderable  {
  float d = 100;
  Circle() {
  }
  void draw() {
    hr.ellipse(0,0,d,d);
  }
}


class Line extends Animatable implements Renderable  {
  float d = 100;
  boolean vertical = false;
  float s = width*1.5;
  Line() {
    isstroke = true;
    isHandy = false;
  }
  void draw() {
    if (vertical) {
      hr.line(0,-s/2,0,s/2);
    } else {
      hr.line(-s/2,0,s/2,0);
    }
  }
}


class Tri extends Animatable implements Renderable  {
  float h = 100;
  float c1 = 100;
  float c2 = 100;

  float getAngle() {
    return 10 * x/10;
  }

  Tri() {
  }
  void draw() {
    hr.triangle(-c1, -h/2 ,0,h ,c2,-h/2);
  }
}

PImage bg;
JSONObject frames;
PApplet that;
ArrayList<Renderable> renderables;
float drumAng;
void setup() {
  Ani.init(this);
  drumAng = 0;
  that = this;
  frames = loadJSONObject("../frames.json");
  size(1920, 1080);
  textAlign(CENTER);
  blendMode(MULTIPLY);
  smooth();
  rectMode(CENTER);
  frameRate(32);
  renderables = new ArrayList<Renderable>();
  Ani.setDefaultTimeMode(Ani.FRAMES);
  colorMode(HSB,100);
  bg = loadImage("kek.jpg");
  Ani.to(this, 3000, "drumAng", 3000, Ani.LINEAR);
}

int lastHalfFrame = -1;

void flute(int halfFrame, JSONObject obj) {
  int dur = obj.getInt("dur");
  if (false) {

  } else if (halfFrame > 32 && halfFrame < 70) {
    appearingSquare();
    // Tri r = new Tri();
    // r.animate(max(dur,6), "h", 0, Ani.SINE_OUT);
    // r.animate(max(dur,6), "c1", 0, Ani.SINE_OUT);
    // r.animate(max(dur,6), "c2", 0, Ani.SINE_OUT);
    // r.animate(max(dur,6), "x", width/2, Ani.SINE_IN_OUT);
    // r.animate(max(dur,6), "y", height/2, Ani.CIRC_OUT, "onEnd:die");
    // renderables.add((Renderable)r);
  } else if (halfFrame == 70) {

  }

}
void picc(int halfFrame, JSONObject obj) {
  int dur = obj.getInt("dur");
  if (false) {

  } else if (halfFrame > 32 && halfFrame < 64) {
    appearingCircle();
  } else if (halfFrame < 11111142) {
    // Tri r = new Tri();
    // r.animate(max(dur,6), "h", 0, Ani.SINE_OUT);
    // r.animate(max(dur,6), "c1", 0, Ani.SINE_OUT);
    // r.animate(max(dur,6), "c2", 0, Ani.SINE_OUT);
    // r.animate(max(dur,6), "x", width/2, Ani.SINE_IN_OUT);
    // r.animate(max(dur,6), "y", height/2, Ani.CIRC_OUT, "onEnd:die");
    // renderables.add((Renderable)r);
  }

}
void guitar(int halfFrame, JSONObject obj) {
  int dur = obj.getInt("dur");
  if (false) {

  } else if (halfFrame < 1111112) {
    // Tri r = new Tri();
    // if (dur > 4) {
    //   dur = dur * 2;
    //   r.h = 150;
    //   r.c1 = 150;
    //   r.c2 = 150;
    //   r.isstroke = true;
    //   r.strokew = 1.4;
    // }
    // r.animate(max(dur,6) , "h", 0, Ani.SINE_OUT);
    // r.animate(max(dur,6), "c1", 0, Ani.SINE_OUT);
    // r.animate(max(dur,6), "c2", 0, Ani.SINE_OUT);
    // r.animate(max(dur,6), "x", width/2, Ani.SINE_IN_OUT);
    // r.animate(max(dur,6), "y", height/2, Ani.CIRC_OUT, "onEnd:die");
    // renderables.add((Renderable)r);
  }

}

void bassCirc(int dur) {
  Circle r = new Circle();
  r.x = width/2;
  r.y = height/2;
  r.d = 2000;
  r.isstroke = false;
  r.strokew = 4;
  // r.issfill = false;
  r.fillg = 6;
  // r.fillg = 60;
  r.fillw = 0.8;
  r.fillch = degToPercent(206);
  r.fillcv = 100;
  r.fillcs = 5;
  r.rough = 1.3;
  // r.alt = true;
  // r.animate(3,"d",900, Ani.EXPO_IN, "onEnd:");
  r.angle = random(0,360);
  r.animate(dur * 4,0,"d", 0, Ani.CIRC_OUT, "onEnd:die");
  r.animate(dur * 4,0,"strokew",0, Ani.CIRC_OUT);
  r.animate(dur * 4,0,"angle",360, Ani.LINEAR);
  r.animate(dur * 4,0,"rough",0, Ani.LINEAR);
  renderables.add((Renderable)r);

  Circle r2 = new Circle();
  r2.x = width/2;
  r2.y = height/2;
  r2.d = 2000;
  r2.isstroke = true;
  r2.strokew = 4;
  r2.issfill = false;
  r2.fillg = 5;
  r2.fillw = 0.6;
  r2.strokecv = 70;
  r2.strokecs = 0;
  r2.rough = 0;
  r2.isHandy = false;
  // r2.animate(3,"d",900, Ani.EXPO_IN, "onEnd:");
  r2.angle = random(0,360);
  r2.animate(dur * 4,0,"d", 0, Ani.CIRC_OUT, "onEnd:die");
  r2.animate(dur * 4,0,"strokew",0, Ani.CIRC_OUT);
  r2.animate(dur * 4,0,"angle",360, Ani.LINEAR);
  r2.animate(dur * 4,0,"rough",0, Ani.LINEAR);
  renderables.add((Renderable)r2);
}
int degToPercent(int deg){
  return (int) (((float)deg/360)*100);
}

String oed = "onEnd:die";
int divSquareCnt = 0;
void divSquare(int dur) {
  divSquareCnt+=1;
  for (int i = 0; i < divSquareCnt; i++) {
    for (int j = 0; j < divSquareCnt; j++) {
      Rect r = makeAppSq(i,j,divSquareCnt);
      r.animate((int)(dur), "w", 0, Ani.CIRC_OUT, oed);
      // r.animate((int)(dur * 1.5), "d", 0, Ani.EXPO_OUT, oed);
      r.animate(dur * 2, "fillcs", 0, Ani.CIRC_OUT);
      r.animate((int)(dur), "h", 0, Ani.CIRC_OUT);
      renderables.add((Renderable)r);
    }
  }
}

Rect makeAppSq(int i, int j, int num, int add) {
  Rect r = new Rect();
  r.h = add + 23 + 230/num;
  r.w = add + 23 + 230/num;
  r.x = (( (i*width/num+1) - 0)) + 0 + width/(num*2);
  r.y = (( (j*height/num+1) - 0)) + 0 + height/(num*2);
  r.fillg = 0.24;
  r.fillch = degToPercent(206);
  r.fillcs = (int) 100 - (int) (abs(r.x - width / 2)/10) - (int) (abs(r.y - height / 2)/10);
  r.fillcv = 96;
  return r;
}


Rect makeAppSq(int i, int j, int num) {
  Rect r = new Rect();
  r.h = 23 + 230/num;
  r.w = 23 + 230/num;
  r.x = (( (i*width/num+1) - 0)) + 0 + width/(num*2);
  r.y = (( (j*height/num+1) - 0)) + 0 + height/(num*2);
  r.fillg = 0.24;
  r.fillch = degToPercent(206);
  r.fillcs = (int) 100 - (int) (abs(r.x - width / 2)/10) - (int) (abs(r.y - height / 2)/10);
  r.fillcv = 96;
  return r;
}


Circle makeAppCirc(int i, int j, int num) {
  Circle r = new Circle();
  r.d = 23 + 770/num;
  r.x = (( (i*width/num+1) - 0)) + 0 + width/(num*2);
  r.y = (( (j*height/num+1) - 0)) + 0 + height/(num*2);
  r.isstroke = false;
  r.fillg = 0.2;
  r.hangl = -45;
  r.fillch = degToPercent(0);
  r.fillcs = 20 + (int) 100 - (int) (abs(r.x - width / 2)/10) - (int) (abs(r.y - height / 2)/10);
  r.fillcv = 96;
  return r;
}

int appCCnt = 0;
ArrayList<Circle> appC = new ArrayList<Circle>();
void appearingCircle() {
  int lol = appCCnt;
  int appCCnt = lol-1;
  int inv = 24 - appCCnt;
  Circle r1 = makeAppCirc(appCCnt % 5, appCCnt / 5, 5);
  Circle r2 = makeAppCirc(inv % 5, inv / 5, 5);
  r1.animate((int)(6), "d", 0, Ani.CIRC_OUT, oed);
  r1.animate(8 * 2, "fillcs", 0, Ani.CIRC_OUT);
  // r.animate((int)(dur * 1.55), "d", 0, Ani.EXPO_OUT, oed);
  r2.animate(8 * 2, "fillcs", 0, Ani.CIRC_OUT);
  r2.animate((int)(6), "d", 0, Ani.CIRC_OUT);
  appC.add(r1);
  appC.add(r2);
  renderables.add((Renderable)r1);
  renderables.add((Renderable)r2);
}

int appSqCnt = 0;
ArrayList<Rect> appsqs = new ArrayList<Rect>();
void appearingSquare() {
  int inv = 24 - appSqCnt;
  Rect r1 = makeAppSq(appSqCnt % 5, appSqCnt / 5, 5, 40);
  Rect r2 = makeAppSq(inv % 5, inv / 5, 5, 40);
  r1.animate((int)(6), "w", 0, Ani.CIRC_OUT, oed);
  // r.animate((int)(dur * 1.5), "d", 0, Ani.EXPO_OUT, oed);
  r1.animate(6 * 2, "fillcs", 0, Ani.CIRC_OUT);
  r1.animate((int)(6), "h", 0, Ani.CIRC_OUT);
  r2.animate((int)(6), "w", 0, Ani.CIRC_OUT, oed);
      // r.animate((int)(dur * 1.5), "d", 0, Ani.EXPO_OUT, oed);
  r2.animate(6 * 2, "fillcs", 0, Ani.CIRC_OUT);
  r2.animate((int)(6), "h", 0, Ani.CIRC_OUT);
  appsqs.add(r1);
  appsqs.add(r2);
  renderables.add((Renderable)r1);
  renderables.add((Renderable)r2);
  appSqCnt+=1;
  appCCnt+=1;
  // lol
}

void bass(int halfFrame, JSONObject obj) {
  int dur = obj.getInt("dur");
  if (false) {

  } else if (halfFrame == 0) {
    divSquare(16);
  } else if (halfFrame <= 32) {
    divSquare(dur * 4);
  } else if (halfFrame >=64 && halfFrame < 124) {
    bassCirc(dur);
  }

}
void drawDrums(int drumNum) {
  for(int i=0; i<drumNum*5; i++) {
    Line r1 = new Line();
    r1.y = (( (i*height/(drumNum*5)+1) - 0)) + 0 + height/(drumNum*5*2);
    r1.x = width/2;
    r1.strokech = degToPercent(206);
    r1.strokecs = 0;
    r1.strokecv = 30;
    r1.animate(4, "strokecv", 100, Ani.EXPO_OUT, oed);
    r1.angle = drumAng;
    Line r2 = new Line();
    r2.x = (( (i*width/(drumNum*5)+1) - 0)) + 0 + width/(drumNum*5*2);
    r2.y = height/2;
    r2.strokech = degToPercent(206);
    r2.strokecs = 0;
    r2.strokecv = 30;
    r2.vertical = true;
    r2.animate(4, "strokecv", 100, Ani.EXPO_OUT, oed);
    r2.angle = drumAng;
    renderables.add((Renderable)r1);
    renderables.add((Renderable)r2);
  }
}

void drum(int halfFrame, int drumNum) {
  if (false) {

  } else if (halfFrame < 111112) {
    drawDrums(drumNum);
  }

}
int startframe = 71;
int endframe = 124;
// int startframe = 64;
// int endframe = 2230;
void draw() {
  if (frameCount > endframe*2) {
    exit();
  }
  int halfFrame = floor((frameCount-1)/2) + startframe;
  JSONArray events = frames.getJSONArray("" + halfFrame);
  if (events != null && lastHalfFrame != halfFrame) {
    int drumnum = 0;
    for (int i = 0; i < events.size(); i++) {
      JSONObject ev = events.getJSONObject(i);
      switch (ev.getString("part")) {
      case "flute":
        flute(halfFrame, ev);
        break;
      case "picc":
        picc(halfFrame, ev);
        break;
      case "guit":
        guitar(halfFrame, ev);
        break;
      case "bass":
        bass(halfFrame, ev);
        break;
      case "drum":
        drumnum+=1;
        break;
      }
      drum(halfFrame, drumnum);
    }
  }
  // background(bg);
  background(color(0, 0, 100));
  // draw the circles
  for(int i=0; i<renderables.size(); i++) renderables.get(i).render();
  lastHalfFrame = halfFrame;
  saveFrame(String.format("rec/line-%06d.png",(frameCount-1)+startframe*2));
}
