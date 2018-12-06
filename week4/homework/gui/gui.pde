final String RED = "red";
final String GREEN = "green";
final String BLUE = "blue";
float slider_w = 200;
float slider_h = 20;
float stroke_w = 1;
float max_indicator_w = slider_w - stroke_w;

ArrayList<Slider> sliders = new ArrayList<Slider>();
float r, g, b = 0;

// window frame's setting
final float tab_h = 10;
final float tab_w = slider_w;
float window_pos_x, window_pos_y, window_offset_x, window_offset_y;
color window_color = color(200);
boolean window_update_flag = false;
float window_total_h = slider_h*3+tab_h;

void setup() {
  size(500, 500);
  background(0);

  window_pos_x = (width-tab_w)/2;
  window_pos_y = (height-window_total_h)/2;

  sliders.add(new Slider(0, tab_h, RED));
  sliders.add(new Slider(0, tab_h+slider_h, GREEN));
  sliders.add(new Slider(0, tab_h+slider_h*2, BLUE));
}


void draw() {
  background(r, g, b);

  // draw window frame
  translate(window_pos_x, window_pos_y);
  stroke(window_color);
  fill(window_color);
  rect(0, 0, tab_w, tab_h);

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

  // start handling window
  if (checkMouseoverTab(mx, my)) {
    window_update_flag = true;
    window_offset_x = mx - window_pos_x;
    window_offset_y = my - window_pos_y;
  }
}

// be more user-friendly than using mouseDragged :)
void mouseReleased() {
  for (Slider s : sliders) {
    s.update_flag = false;
  }

  window_update_flag = false;
}

void mouseDragged() {
  // handling window continuously
  if (window_update_flag) {
    window_pos_x = mouseX - window_offset_x;
    window_pos_y = mouseY - window_offset_y;
  }
  
  // prevent hidden window
  if (window_pos_x < 0) {
    window_pos_x = 0;
  } else if(window_pos_x > width-tab_w) {
    window_pos_x = width-tab_w;
  }
  if (window_pos_y < 0) {
    window_pos_y = 0;
  } else if(window_pos_y > height-window_total_h) {
    window_pos_y = height-window_total_h;
  }
}

boolean checkMouseoverTab(float mx, float my) {
  return window_pos_x < mx && mx < window_pos_x+tab_w && window_pos_y < my && my < window_pos_y+tab_h;
}


class Slider {
  float pos_x, pos_y;
  float indicator_w, indicator_h;
  //float handle_x, handle_y;
  boolean update_flag = false;
  color slider_bgcolor = color(0);
  color indicator_color = color(220);
  String hue;


  Slider(float x, float y, String hue) {
    pos_x = x;
    pos_y = y;
    this.hue = hue;
  }

  boolean checkMouseover(float mx, float my) {
    // window_pos becomes offset
    return window_pos_x+pos_x < mx && mx < window_pos_x+pos_x+slider_w && window_pos_y+pos_y < my && my < window_pos_y+pos_y+slider_h;
  }

  void update(float mx, float my) {
    //handle_x = mx;
    //handle_y = pos_y;

    indicator_w = mx - window_pos_x+pos_x+stroke_w;
    indicator_h = slider_h;
    if (indicator_w < 0) {
      indicator_w = 0;  // min
    } else if (indicator_w > max_indicator_w) {
      indicator_w = max_indicator_w;  // max
    }

    // update background color
    switch(hue) {
    case RED:
      r = map(indicator_w, 0, max_indicator_w, 0, 255);
      break;
    case GREEN:
      g = map(indicator_w, 0, max_indicator_w, 0, 255);
      break;
    case BLUE:
      b = map(indicator_w, 0, max_indicator_w, 0, 255);
      break;
    }
  }

  void draw() {
    pushMatrix();
    translate(pos_x, pos_y);

    // backside
    strokeWeight(stroke_w);
    stroke(window_color);
    fill(slider_bgcolor);
    rect(0, 0, slider_w, slider_h);

    // indicator
    noStroke();
    fill(indicator_color);
    rect(stroke_w, stroke_w, indicator_w, indicator_h);
    popMatrix();
  }
}
