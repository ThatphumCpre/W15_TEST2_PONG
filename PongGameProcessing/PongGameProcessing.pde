PongGame game;
void setup() {
  size(700, 700);
  game = new PongGame();
}
void draw() {
  background(40);
  game.drawPongGame();
  game.update();
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
    ellipse(positionX, positionY, size, size);
  }

  void move() {
    positionX += speedX;  //update position from speed
    positionY += speedY;
    if (positionY < 0  || positionY > height) { //bounce on Top
      speedY *= -1;    //invert speed
    }

    if (positionX < 10) {
      speedX *= -1;
    }
    if (speedX >10 ) {
      speedX = 10;
    }
    if (speedY >10 ) {
      speedY = 10; 
    }
    println(speedX);
    println(speedY);
  }

  float getPositionX() {
    return  positionX;
  }

  float getPositionY() {
    return positionY;
  }

  void setPositionX(int x) {
    positionX = x;
  }

  void setPositionY(int y) {
    positionY = y;
  }

  void setSpeedX(float factor) {
    speedX = factor*speedX; //multiply speed by factor
  }

  void defaultSet() {
    positionX = width/2;
    positionY = height/2;
    speedX = -random(3, 5); //Set Ball to Start point
    speedY = -random(3, 5);
  }
}


class Paddle {
  int positionY, positionX, score;  //collect position and player score
  boolean bounced;
  Ball objectBall;  //collect object from Class Ball

  Paddle(Ball bounceBall, int x, int y) {
    objectBall = bounceBall;   //collected ball class
    positionX=x;  //set position
    positionY=y;
    score = 0;    //start score for each player
    bounced = false;
  }


  void bounce() {
    if ( circleRect(objectBall.getPositionX(), objectBall.getPositionY(), 35, positionX, positionY, 50, 200) && !bounced ) {
      objectBall.setSpeedX(-1.5);
      bounced = true;
    }
    if (!circleRect(objectBall.getPositionX(), objectBall.getPositionY(), 35, positionX, positionY, 50, 200)) {
      bounced = false;
    }
  }

  void drawPaddle() {
    rect(positionX, positionY, 50, 200);  //draw a Paddle
  }

  int getPositionY() {
    return positionY;  //return positionX
  }

  void addPositionY(int adder) {
    positionY += adder ;     //add to move position
  }

  int getScore() {
    return score; //Get score from player
  }

  void addScore() {
    score += 1;  //Add 1 score to player
  }
}

class PongGame {
  Paddle player1;  //Set player1,2 as  object of Paddle
  Paddle player2;
  Paddle wall;
  Paddle wall2;
  Ball pongBall;   //Set pongBall as object of Ball
  int pastMouse;   //Variable of the values of past mouse
  int time = 0;  //use to count delay time

  PongGame() {
    pongBall = new Ball(70);  //Instance Ball that size 70
    //player1 = new Paddle(pongBall, 0, 0);           //instance player 1
    wall = new Paddle(pongBall, int(random(width/4, width/1.5)), int(random(0, height/3)));
    wall2 = new Paddle(pongBall, int(random(width/4, width/2)), int(random(0, height)));
    player2 = new Paddle(pongBall, width-50, 0);    //instance player 2
    pastMouse = 0;
  }

  void drawPongGame() {
    textSize(54);
    //text(player1.getScore(), width/4, height/8);    //draw player  1 score
    text(player2.getScore(), width*3/4, height/8);  //draw player  2 score
    rect(width/2, 0, 10, height);                   //draw center line
    pongBall.drawBall();      //Draw PongBall
    wall.drawPaddle(); 
    wall2.drawPaddle(); 
    //player1.drawPaddle();                           //draw player1 Paddle
    player2.drawPaddle();                           //draw player2 Paddle
  }

  void update() {
    if (time==0) {
      pongBall.move();         //Move the Ball
    } else {
      time -=1;
    }
    if ( mousePressed) {                         //if mouse press
      if (mouseX < width/2) {                   //and player 1 zone move player'1Paddle
        //player1.addPositionY(mouseY-pastMouse);
      } else {
        player2.addPositionY(mouseY-pastMouse);  //if player 2 zone move player'2 Paddle
      }
    }


    if (pongBall.getPositionX() > width/2) { //if in player2 side
      player2.bounce();        //bounce player2 Paddle when ball on player2 side
    } else {

      //player1.bounce();        //bounce player1 Paddle when ball on player2 side
    }

    wall.bounce();
    wall2.bounce();

    if (pongBall.getPositionX() > width) {    //if over the edge then plus the score
      player2.addScore();    //add score to player2
      serveBall(1);         //serveballto left side
    } else if  (pongBall.getPositionX() > width)
    {
      //player1.addScore();    //add score to player1
      serveBall(-1);          //serve to right side
    }
    /* if(player1.getScore() >= 5){
     rect(width/4,height/3,400,200);
     fill(30);
     text("Player 2 Wins!",width/4+20,height/3+120);
     noLoop();
     } */
    else if (player2.getScore() >= 5) {
      rect(width/4, height/3, 400, 200);
      fill(30);
      text("Player 2 Wins!", width/4+20, height/3+120);
      noLoop();
    }

    pastMouse = mouseY;      //collect position of mouse
  }

  void serveBall(int factor) {
    pongBall.setPositionX(width/2);         //set PongBall to center
    pongBall.setPositionY(height/2);
    pongBall.defaultSet();                  //set to default speed
    pongBall.setSpeedX(factor);           //set direction to factor
    time = 60;
  }
}

boolean circleRect(float cx, float cy, float radius, float rx, float ry, float rw, float rh) {

  // temporary variables to set edges for testing
  float testX = cx;
  float testY = cy;

  // which edge is closest?
  if (cx < rx)         testX = rx;      // test left edge
  else if (cx > rx+rw) testX = rx+rw;   // right edge
  if (cy < ry)         testY = ry;      // top edge
  else if (cy > ry+rh) testY = ry+rh;   // bottom edge

  // get distance from closest edges
  float distX = cx-testX;
  float distY = cy-testY;
  float distance = sqrt( (distX*distX) + (distY*distY) );

  // if the distance is less than the radius, collision!
  if (distance <= radius) {
    return true;
  }
  return false;
}
