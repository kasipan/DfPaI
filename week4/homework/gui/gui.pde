final float SLIDER_W = 200;
final float SLIDER_H = 20;
final float STROKE_W = 1;

ArrayList<Slider> sliders = new ArrayList<Slider>();


void setup() {
  size(500, 500);
  background(0);

  sliders.add(new Slider(100, 100));
}

void draw() {
  for (Slider s : sliders) {
    if (s.update_flag) {
      s.update(mouseX, mouseY);
    }
    s.draw();
  }
}

void mousePressed() {
  float mx = mouseX;
  float my = mouseY;
  for (Slider s : sliders) {
    if (s.checkMouseover(mx, my)) {
      s.update_flag = true;
    }
  }
}

// be more user-friendly than using mouseDragged :)
void mouseReleased() {
  for (Slider s : sliders) {
    s.update_flag = false;
  }
}


class Slider {
  float pos_x, pos_y;
  float indicator_w, indicator_h;  // only for x-index
  //float handle_x, handle_y;
  boolean update_flag;
  float slider_bgcolor = 0;
  float indicator_color = 220;


  Slider(float x, float y) {
    pos_x = x;
    pos_y = y;
  }

  Boolean checkMouseover(float mx, float my) {
    return pos_x < mx && mx < pos_x+SLIDER_W && pos_y < my && my < pos_y+SLIDER_H;
  }

  void update(float mx, float my) {
    //handle_x = mx;
    //handle_y = pos_y;

    indicator_w = mx - pos_x+STROKE_W;
    indicator_h = SLIDER_H;
    if (indicator_w < 0) {
      indicator_w = 0;  // min
    } else if (indicator_w > SLIDER_W-STROKE_W) {
      indicator_w = SLIDER_W-STROKE_W;  // max
    }
  }

  void draw() {
    pushMatrix();
    translate(pos_x, pos_y);

    // backside
    strokeWeight(STROKE_W);
    stroke(indicator_color);
    fill(slider_bgcolor);
    rect(0, 0, SLIDER_W, SLIDER_H);

    // indicator
    noStroke();
    fill(indicator_color);
    rect(STROKE_W, STROKE_W, indicator_w, indicator_h);
    popMatrix();
  }
}
