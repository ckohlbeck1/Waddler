
class Penguin {
  
  PImage currentState;
  boolean isJumping = false;
  boolean isDucking = false;
  
  Penguin(PImage peng) {
    currentState = peng;
  }
  
  void jump(PImage j) {
    currentState = j;
    isJumping = true;
    isDucking = false;
  }
  
  void duck(PImage d) {
    currentState = d; 
    isJumping= false;
    isDucking = true;
  }
  
  void run(PImage r) {
    currentState = r; 
    isJumping= false;
    isDucking = false;
  }
  
  // Prints penguin in current State
  void display() {
    currentState.resize(60, 60);
    if(isJumping) {
      image(currentState, 75, 205);
    }
    else if(isDucking) {
      image(currentState, 75, 300);
    }
    else {
      image(currentState, 75, 275);
    }
  }
  
  
  
}
