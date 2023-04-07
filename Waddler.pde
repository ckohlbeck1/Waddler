

// TO DO:
// 1. Losing Condition, when to call beenhit()

// OPTIONAL:
// 1. Make penguin look like he's running 


import processing.sound.*;

SoundFile BG;
SoundFile youLost;
SoundFile youWin;
SoundFile jump;
SoundFile duck;

PImage menuBG;
PImage gameBG;
PImage howToPlayBG;
PImage runningPeng;
PImage jumpingPeng;
PImage duckingPeng;

PImage jumpingObstacle1;
PImage jumpingObstacle2;
PImage duckingObstacle1;

PImage loosingScreen;
PImage winningScreen;

PFont menuFont;
PFont startingMessageFont;
PFont Xfont;

int level = 0;
int moving = 600;
int startingMesTime = 0;
int backToRunTime = 0;
int timeDone = 0;
int score = 0;
boolean levelChosen = false;
boolean won = false;
boolean lost = false;

int highScore1 = 0;
int highScore2 = 0;
int highScore3 = 0;

int scoreNeeded = 0;

// 1: Duck, 0: Jump
int[] order = {0,0,1,0,1,0,1,0,1,0,0,1};

Penguin player1;
Obstacles path;

void setup() {
    
  size(600, 400);
  loadAllSounds();
  loadAllImages();
  displayMenu();
  
  player1 = new Penguin(runningPeng);
  
  BG.loop();
 
}

void draw() {
  
  if(!levelChosen && !won && !lost) {
    whichLevel();
  }
  
  if(level == 4) {
    levelChosen = true;
    if(mousePressed == true) {
      if(mouseX > width * 0.1 && mouseX < width * 0.1 + 40 && mouseY > height * 0.05 && mouseY < height * 0.05 + 40) {
        levelChosen = false;
        level = 0;
        displayMenu();
      }
    }
    
  }
  

  if(level != 0 && level != 4 && !won && !lost) {
    if(!levelChosen) {
      if(level == 1) {
        scoreNeeded = 120;
      }
      
      // Need to add level 2 and 3

    }
    levelChosen = true;
    path = new Obstacles(jumpingObstacle1, jumpingObstacle2, duckingObstacle1);
    
    path.display();
    player1.display();
    
    startingMessageFont = createFont("Calibri-Bold-48", 25);
    fill(#5E6386);
    textAlign(CENTER);
    textFont(startingMessageFont);

    if((millis() > startingMesTime + 1900 && millis() < startingMesTime + 2100) ||
      (millis() > startingMesTime + 2900 && millis() < startingMesTime + 3100) ||
        (millis() > startingMesTime + 3900 && millis() < startingMesTime + 4100)) {
          
          background(gameBG);
          path.display();
          player1.display();
          
    }
    else if(millis() < startingMesTime + 1900) {
      text("Help Waddles Get Home!", width/2, height * 0.4);
    }
    else if(millis() > startingMesTime + 2100 && millis() < startingMesTime + 2900) {
      text("3", width/2, height * 0.4);
    }
    else if(millis() > startingMesTime + 3100 && millis() < startingMesTime + 3900) {     
      text("2", width/2, height * 0.4);
    }
    else if(millis() > startingMesTime + 4100 && millis() < startingMesTime + 5000) {
      text("1", width/2, height * 0.4);
    }

    if(millis() > startingMesTime + 5100) {
      score++;
      background(gameBG);
      path.display();
      player1.display();
      
      fill(#5E6386);
      textAlign(CENTER);
      textFont(startingMessageFont);
      
      String scoreString = str(score);
      text(scoreString, width/2, height * 0.4);
  
      if(millis() > startingMesTime + 5200) {
        
        path.obstaclesMove(moving);
        
        if(level == 1) {
          moving = moving - 4;
          if(millis() > backToRunTime + 1800) {
            player1.run(runningPeng); 
          }
        }
        else if(level == 2) {
          moving = moving - 6;
          if(millis() > backToRunTime + 1200) {
            player1.run(runningPeng); 
          }
        }
        else if(level == 3) {
          moving = moving - 8;
          if(millis() > backToRunTime + 800) {
            player1.run(runningPeng); 
          }
        }
        
        // HERE: Need to check If an obstacle is hit
        if(keyPressed) {
          
          // Need to debug
          // Things to account for: jump versus duck obstacles, not pressing a key at all, pressing key too late too early 
          //if(level == 1) {
          // if(score < scoreNeeded - 4 || score > scoreNeeded + 4) {
          //  path.beenhit();
          // }
          // if(score > scoreNeeded + 10) {
          //  scoreNeeded = scoreNeeded + 50;
          // }
           
         }
         
         
        }
        
        
        
        
      }

     // You Lost
    if(path.checkHit()) {
      lost = true;
      moving = 600;
      levelChosen = false;
      player1.run(runningPeng);
      gameWonLost();
    }
    
    // You Won 
    // MAX SCORE: 10,000
    if(score == 10000) {
      won = true;
      moving = 600;
      levelChosen = false;
      player1.run(runningPeng);
      gameWonLost();
    }
    
  }
  
  if(won) {
    fill(#5E6386);
    textAlign(CENTER);
    textFont(startingMessageFont);
    background(winningScreen);
    
    rectMode(CENTER);
    rect(width/2, height * 0.85, 260, 80, 20);
    
    fill(255);
    
    if(level == 1) {
      if(score > highScore1) {
        highScore1 = score;
      }
      String highScore = str(highScore1);
      text("High Score: " + highScore, width/2, height * 0.9);
    }
    else if(level == 2) {
      if(score > highScore2) {
        highScore2 = score;
      }
      String highScore = str(highScore2);
      text("High Score: " + highScore, width/2, height * 0.9);
    }
    else if(level == 3) {
      if(score > highScore3) {
        highScore3 = score;
      }
      String highScore = str(highScore3);
      text("High Score: " + highScore, width/2, height * 0.9);
    }
      
    String scoreString = str(score);
    text("Score: " + scoreString, width/2, height * 0.82);
    
    if(millis() > timeDone + 7000) {
      displayMenu();
      won = false;
      score = 0;
      level = 0;
    }
    
    
  }
  
  if(lost) {
    
    fill(#5E6386);
    textAlign(CENTER);
    textFont(startingMessageFont);
    background(loosingScreen);
    
    rectMode(CENTER);
    rect(width/2, height * 0.85, 260, 80, 20);
    
    fill(255);
    
    if(level == 1) {
      if(score > highScore1) {
        highScore1 = score;
      }
      String highScore = str(highScore1);
      text("High Score: " + highScore, width/2, height * 0.9);
    }
    else if(level == 2) {
      if(score > highScore2) {
        highScore2 = score;
      }
      String highScore = str(highScore2);
      text("High Score: " + highScore, width/2, height * 0.9);
    }
    else if(level == 3) {
      if(score > highScore3) {
        highScore3 = score;
      }
      String highScore = str(highScore3);
      text("High Score: " + highScore, width/2, height * 0.9);
    }
      
    String scoreString = str(score);
    text("Score: " + scoreString, width/2, height * 0.82);
    
    
    if(millis() > timeDone + 7000) {
      displayMenu();
      won = false;
      score = 0;
      level = 0;
    }
    
  }
  
}











// FUNCTIONS

void gameWonLost() {
  timeDone = millis();
  if(won) {
    youWin.play();
  }
  else if(lost) {
    youLost.play();
  }
}


void keyPressed() {
  if(keyCode == UP) {
    player1.jump(jumpingPeng);
    jump.play();
    backToRunTime = millis(); 
  }
  
  if(keyCode == DOWN) {
    player1.duck(duckingPeng);
    duck.play();
    backToRunTime = millis();
  }
  
}

void whichLevel() {
  if(mousePressed == true) {
    if(dist(mouseX, mouseY, width/2, height * 0.81) < 70/2) {
      level = 2;
      background(gameBG);
      startingMesTime = millis();
    }
    if(dist(mouseX, mouseY, width/2 - 140, height * 0.81) < 70/2) {
      level = 1;
      background(gameBG);
      startingMesTime = millis();
    }
    if(dist(mouseX, mouseY, width/2 + 140, height * 0.81) < 70/2) {
      level = 3;
      background(gameBG);
      startingMesTime = millis();
    }
    if(mouseX > width * 0.79 && mouseX < width * 0.79 + 100 && mouseY > height * 0.05 && mouseY < height * 0.05 + 40) {
      background(howToPlayBG);
      
      stroke(#5E6386);
      fill(255);
      strokeWeight(3);
      rectMode(CENTER);
      rect(width * 0.134, height * 0.1, 40, 40, 10);
      
      Xfont = createFont("Calibri-48", 30);
      fill(#5E6386);
      textAlign(CENTER);
      textFont(Xfont);
      text("X", width * 0.134, height * 0.13);
      
      level = 4;
    }

  }
}

void gameLost() {
  
}

void gameWin() {
  
}

void loadAllSounds() {
  
  BG = new SoundFile(this, "backgroundMusic.mp3");
  youLost = new SoundFile(this, "youLost.wav");
  youWin = new SoundFile(this, "youWin.mp3");
  jump = new SoundFile(this, "jump.wav");
  duck = new SoundFile(this, "duck.wav");

}

void loadAllImages() {
  
  menuBG = loadImage("Waddler.jpg");
  gameBG = loadImage("GameBackground.png");
  runningPeng = loadImage("RunningPeng.png");
  jumpingPeng = loadImage("JumpingPeng.png");
  duckingPeng = loadImage("DuckingPeng.png");
  jumpingObstacle1 = loadImage("jumpingOb1.png");
  jumpingObstacle2 = loadImage("jumpingOb2.png");
  duckingObstacle1 = loadImage("duckingOb1.png");
  loosingScreen = loadImage("youLost.png");
  winningScreen = loadImage("youWon.png");
  howToPlayBG = loadImage("howToPlay.png");
  
}


void displayMenu() {
  
  menuFont = createFont("Arial Bold", 18);
  background(menuBG);
  
  noStroke();
  fill(255);
  
  ellipse(width/2, height * 0.81, 70, 70);
  ellipse(width/2 + 140, height * 0.81, 70, 70);
  ellipse(width/2 - 140, height * 0.81, 70, 70);
  
  stroke(#5E6386);
  strokeWeight(4);
  rectMode(CENTER);
  rect(width * 0.87, height * 0.105, 100, 40, 14);
  
  noStroke();
  fill(#5E6386);
  textAlign(CENTER);
  textFont(menuFont);
  text("EASY", width/2 - 140, height * 0.83);
  text("MED", width/2, height * 0.83);
  text("HARD", width/2 + 140, height * 0.83);
  text("HELP", width * 0.87, height * 0.12);
  
}
