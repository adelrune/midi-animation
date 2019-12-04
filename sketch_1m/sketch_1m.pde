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
void setup() {
  that = this;
  Ani.init(this);
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
}

int lastHalfFrame = -1;

void flute(int halfFrame, JSONObject obj) {
  int dur = obj.getInt("dur");
  if (false) {

  } else if (halfFrame < 11111142) {
    Tri r = new Tri();
    r.animate(max(dur,6), "h", 0, Ani.SINE_OUT);
    r.animate(max(dur,6), "c1", 0, Ani.SINE_OUT);
    r.animate(max(dur,6), "c2", 0, Ani.SINE_OUT);
    r.animate(max(dur,6), "x", width/2, Ani.SINE_IN_OUT);
    r.animate(max(dur,6), "y", height/2, Ani.CIRC_OUT, "onEnd:die");
    renderables.add((Renderable)r);
  }

}
void picc(int halfFrame, JSONObject obj) {
  int dur = obj.getInt("dur");
  if (false) {

  } else if (halfFrame < 11111142) {
    Tri r = new Tri();
    r.animate(max(dur,6), "h", 0, Ani.SINE_OUT);
    r.animate(max(dur,6), "c1", 0, Ani.SINE_OUT);
    r.animate(max(dur,6), "c2", 0, Ani.SINE_OUT);
    r.animate(max(dur,6), "x", width/2, Ani.SINE_IN_OUT);
    r.animate(max(dur,6), "y", height/2, Ani.CIRC_OUT, "onEnd:die");
    // r.animate(max(dur,6), "diameter", 0, Ani.SINE_OUT);
    // r.animate(max(dur,6), "x", width/2, Ani.SINE_IN_OUT);
    // r.animate(max(dur,6), "y", height/2, Ani.CIRC_OUT, "onEnd:die");
    renderables.add((Renderable)r);
  }

}
void guitar(int halfFrame, JSONObject obj) {
  int dur = obj.getInt("dur");
  if (false) {

  } else if (halfFrame < 1111112) {
    Tri r = new Tri();
    if (dur > 4) {
      dur = dur * 2;
      r.h = 150;
      r.c1 = 150;
      r.c2 = 150;
      r.isstroke = true;
      r.strokew = 1.4;
    }
    r.animate(max(dur,6) , "h", 0, Ani.SINE_OUT);
    r.animate(max(dur,6), "c1", 0, Ani.SINE_OUT);
    r.animate(max(dur,6), "c2", 0, Ani.SINE_OUT);
    r.animate(max(dur,6), "x", width/2, Ani.SINE_IN_OUT);
    r.animate(max(dur,6), "y", height/2, Ani.CIRC_OUT, "onEnd:die");
    // r.animate(max(dur,6), "diameter", 0, Ani.SINE_OUT);
    // r.animate(max(dur,6), "x", width/2, Ani.SINE_IN_OUT);
    // r.animate(max(dur,6), "y", height/2, Ani.CIRC_OUT, "onEnd:die");
    renderables.add((Renderable)r);
  }

}
void bass(int halfFrame, JSONObject obj) {
  int dur = obj.getInt("dur");
  if (false) {

  } else if (halfFrame < 1111111) {
    Circle r = new Circle();
    r.x = width/2;
    r.y = height/2;
    r.d = 2000;
    r.isstroke = false;
    r.strokew = 4;
    // r.issfill = false;
    r.fillg = 6;
    r.fillw = 0.8;
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
    r2.fillcv = 100;
    r2.fillcs = 5;
    r2.rough = 0;
    // r2.animate(3,"d",900, Ani.EXPO_IN, "onEnd:");
    r2.angle = random(0,360);
    r2.animate(dur * 4,0,"d", 0, Ani.CIRC_OUT, "onEnd:die");
    r2.animate(dur * 4,0,"strokew",0, Ani.CIRC_OUT);
    r2.animate(dur * 4,0,"angle",360, Ani.LINEAR);
    r2.animate(dur * 4,0,"rough",0, Ani.LINEAR);
    renderables.add((Renderable)r2);
  }

}
void drum(int halfFrame, JSONObject obj) {
  int dur = obj.getInt("dur");
  if (false) {

  } else if (halfFrame < 111112) {
    Circle r = new Circle();
    r.animate(max(dur,6), "d", 0, Ani.SINE_OUT, "onEnd:die");
    int[] xs = {45 + (int)r.d,(int) xsim(45 + r.d)};
    int[] ys = {45 + (int)r.d, (int) ysim(45 + r.d)};
    r.x = xs[(int)random(2)];
    r.y = ys[(int)random(2)];
    renderables.add((Renderable)r);
  }

}
int startframe = 150;
void draw() {
  int halfFrame = floor((frameCount-1)/2) + startframe;
  strokeWeight(10);
  JSONArray events = frames.getJSONArray("" + halfFrame);
  if (events != null && lastHalfFrame != halfFrame) {
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
        drum(halfFrame, ev);
        break;
      }
    }
  }
  // background(bg);
  background(color(0, 0, 100));
  // draw the circles
  for(int i=0; i<renderables.size(); i++) renderables.get(i).render();
  lastHalfFrame = halfFrame;
  // saveFrame("rec/line-######.png");
}
