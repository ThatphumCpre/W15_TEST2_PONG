PongGame game;   //Set game as object of PongGame 
void setup() {
  size(700, 700);
  game = new PongGame();   //Instance 
}

void draw() {
  background(40);
  game.drawPongGame();      //Draw The game 
  game.update();            //Update game 
}

class Ball {
  float positionX, positionY, size, speedX, speedY; 

  Ball(int sizeInput) {
    positionX = width/2;  //set position at Center
    positionY = height/2;
    size = sizeInput;     //set size
    speedX = -2;          //set  speed
    speedY = -3;
  }    
  void drawBall() {
    ellipse(positionX, positionY, size, size);  //draw Ball
  }               //Draw the ball 
  void move() {
    positionX += speedX;  //update position from speed
    positionY += speedY;
    if (positionY < 0  || positionY > height) { //bounce on Top
      speedY *= -1;    //invert speed
    }
    if (positionX < 0  || positionX > width) { //bounce on Top
      speedX *= -1;    //invert speed
    }
  }                   //Move the ball 
  float getPositionX() {
    return 0.0;
  }          //Get positionX of ball 
  float getPositionY() {
    return 0.0;
  }          //Get positionY of ball
  void setPositionX(int x) {
  }      //Set positionX of ball 
  void setPositionY(int y) {
  }      //Set positionY of ball
  void setSpeedX(float factor) {
  }  //Multiply Speed of ball by input 
  void defaultSet() {
  }              //Set Ball to Start point
}


class Paddle {
  int positionY, positionX, score;  //collect position and player score
  Ball objectBall;  //collect object from Class Ball

  Paddle(Ball bounceBall, int x, int y) {
  }  //collect Ball object that want to
  void bounce() {
  }                 //Make target Ball bounce
  void drawPaddle() {
  }             //Draw Paddle 
  int getPositionY() {
    return 0;
  }            //Get positionY of paddle 
  void addPositionY(int adder) {
  }  //Add value to position to move paddle 
  int getScore() {
    return 0;
  }                //Get score from player 
  void addScore() {
  }               //Add 1 score to player
}

class PongGame {
  Paddle player1;  //Set player1,2 as  object of Paddle
  Paddle player2;
  Ball pongBall;   //Set pongBall as object of Ball
  int pastMouse;   //Variable of the values of past mouse

  PongGame() {
    pongBall = new Ball(70);  //
  }
  void drawPongGame() {
     pongBall.drawBall(); //Draw the Ball
  }      
  void update() {
    pongBall.move();   //Move the ball 
  }              
  void serveBall(int factor) {
  } //Put factor or side to serve the ball
}
