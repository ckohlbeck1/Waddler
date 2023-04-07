
class Obstacles {
  
  PImage[] images = new PImage[3];
  
  PImage ob1;
  PImage ob2;
  PImage ob3;
    
  boolean hit = false;
  
  Obstacles(PImage jump1, PImage jump2, PImage duck) {
      ob1 = jump1;
      ob2 = jump2;
      ob3 = duck;
      
      ob1.resize(60, 60);
      ob2.resize(60, 60);
      ob3.resize(30, 30);
      
      images[0] = ob1;
      images[1] = ob2;
      images[2] = ob3;
      
      hit = false;
  }
  
  // Consistently display obstacles
  void display() {
    fill(255);
    rectMode(CENTER);
    rect(width/2, 375, width, 85);
  }
  
  void obstaclesMove(int moving) {

    for(int i = 0; i < 100000000; i = i + 2400) {
      image(ob1, moving + i, height * 0.7);
      image(ob2, moving + i + 200, height * 0.7);
      image(ob3, moving + i + 400, height * 0.65);
      image(ob2, moving + i + 600, height * 0.7);
      image(ob3, moving + i + 800, height * 0.65);
      image(ob1, moving + i + 1000, height * 0.7);
      image(ob3, moving + i + 1200, height * 0.65);
      image(ob1, moving + i + 1400, height * 0.7);
      image(ob3, moving + i + 1600, height * 0.65);
      image(ob2, moving + i + 1800, height * 0.7);
      image(ob2, moving + i + 2000, height * 0.7);
      image(ob3, moving + i + 2200, height * 0.65);
    }

  }
  
  void beenhit() {
    hit = true;
  }

  boolean checkHit() {
    return hit;
  }
  
}
