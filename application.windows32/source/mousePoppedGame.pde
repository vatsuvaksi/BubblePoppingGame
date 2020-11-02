ArrayList<Bubble> bs = new ArrayList<Bubble>();
int time;
//0 = intro
//1 = start
//2 = end
int state;
void setup() {
  size(640, 360);
  state = 0;
}
void draw() {
  switch(state) {
  case 0:
    background(0);
    fill(255);
    textAlign(CENTER);
    textSize(32);
    text("BUBBLE CLICKER", width/2, height/2);
    textSize(16);
    text("Mouse(LEFT) to pop", width/2, height/2 + 20);
    text("Mouse(MIDDLE) to reset", width/2, height/2 + 40);
    text("Mouse(RIGHT) to add bubble", width/2, height/2 + 60);
    text("CLICK TO START", width/2, height/2 + 100);
    break;
  case 1:
    background(0);
    fill(255);
    textAlign(LEFT);
    textSize(24);
    text("Bubble= "+bs.size(), 10, 24);
    textAlign(RIGHT);
    textSize(16);
    text("F= "+floor(frameRate), width-10, 16);
    break;
  case 2:
    background(0);
    fill(255);
    textAlign(CENTER);
    textSize(24);
    text("YOU WIN", width/2, height/2);
    break;
  }




  //for (Bubble b : bs) {
  //  b.display();
  //  b.ascend();
  //  b.top();
  //}
  if (state != 2) {
    for (int i = bs.size() - 1; i >= 0; i--) {
      bs.get(i).display();
      bs.get(i).ascend();
      bs.get(i).top();
      if (bs.get(i).popped() == true) {
        bs.remove(i);
      }
    }
    
    spawnEvery(2, 1);
  }
  
  
  if (state == 1 && bs.size()<=0) {
    state =2;
  }
}


void mousePressed() {
  if (state ==0) {
    state = 1;
    bs.clear();
    bs.add(new Bubble(random(width), random(2, 64), color(random(255), random(255), random(255))));
  }
  if (mouseButton==RIGHT) {
    bs.add(new Bubble(random(width), random(2, 64), color(random(255), random(255), random(255))));
  } else if (mouseButton == CENTER) {
    bs.clear();
    state = 0;
  }
}


void spawnEvery(int count, float s) {
  if (time % floor(frameRate * s) ==0) {
    for (int i =0; i<count; i++) {
      bs.add(new Bubble(random(width), random(2, 64), color(random(255), random(255), random(255))));
    }
  }
  time++;
}


class Bubble {
  float x, y;
  float speedY;
  float size;
  color c;
  int delay;
  boolean isPop;


  Bubble(float pos, float s, color tempC) {
    x = pos;
    y = height;
    size = s;
    size = constrain(size, 16, 64);
    speedY = 64/size;
    c = tempC;
  }


  void display() {
    stroke(255);
    fill(c, 150);
    circle(x, y, size);
  }


  void ascend() {
    y -= speedY;
    x += random(-2*speedY, 2*speedY);
    x = constrain(x, size/2, width-size/2);
  }


  void top() {
    if (y < 0 - size/2 ) {
      y = height + size/2;
    }
  }


  boolean gotClicked() {
    float d = dist(x, y, mouseX, mouseY);
    return d < size/2;
  }


  boolean popped() {
    if (mousePressed && mouseButton == LEFT && gotClicked()) {
      return true;
    }
    return false;
  }
}
