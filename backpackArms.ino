#include <Servo.h>

double pos = 90;
Servo myservo;

Servo clawLeft1;
Servo clawLeft2;

Servo elbowLeft;
double elbowLeftPos = 90;
bool elbowLeftToggle = false;
bool lastElbowLeftToggle = false;
Servo shoulderLeft;
double shoulderLeftPos = 90;
bool shoulderLeftMoveUp = false;
bool shoulderLeftMoveDown = false;
Servo baseShoulderLeft;
double baseShoulderLeftPos = 90;
bool baseShoulderLeftTurnLeft = false;
bool baseShoulderLeftTurnRight = false;

Servo camera;
Servo elbowRight;
double elbowRightPos = 90;
bool elbowRightToggle = true;
bool lastElbowRightToggle = false;
Servo shoulderRight;
double shoulderRightPos = 90;
bool shoulderRightMoveUp = false;
bool shoulderRightMoveDown = false;
Servo baseShoulderRight;
double baseShoulderRightPos = 90;
bool baseShoulderRightTurnLeft = false;
bool baseShoulderRightTurnRight = false;

bool servoTurnLeft = false;
bool servoTurnRight = false;

void setup() {
  clawLeft1.attach(2);
  clawLeft2.attach(3);

  elbowLeft.attach(4);
  shoulderLeft.attach(5);
  baseShoulderLeft.attach(6);

  elbowRight.attach(9);
  shoulderRight.attach(8);
  baseShoulderRight.attach(7);

  camera.attach(10);

  Serial.begin(9600);

}

void loop() {
  // if there's any serial available, read it:
  while (Serial.available() > 0) {
    char in = Serial.read();
    switch (in) {
      case 'L':
        baseShoulderLeftTurnLeft = true;
        break;
      case 'R':
        baseShoulderLeftTurnRight = true;
        break;
      case 'U':
        shoulderLeftMoveUp = true;
        break;
      case 'D':
        shoulderLeftMoveDown = true;
        break;


      case 'l':
        baseShoulderRightTurnLeft = true;
        break;
      case 'r':
        baseShoulderRightTurnRight = true;
        break;
      case 'u':
        shoulderRightMoveUp = true;
        break;
      case 'd':
        shoulderRightMoveDown = true;
        break;


      case 'S':
        baseShoulderLeftTurnLeft = false;
        baseShoulderLeftTurnRight = false;

        shoulderLeftMoveUp = false;
        shoulderLeftMoveDown = false;
        break;
      case 's':
        baseShoulderRightTurnLeft = false;
        baseShoulderRightTurnRight = false;

        shoulderRightMoveUp = false;
        shoulderRightMoveDown = false;
        break;



      case 'E':
        if (elbowLeftToggle) {
          elbowLeftToggle = false;
        } else {
          elbowLeftToggle = true;
        }
        break;
      case 'e':
        if (elbowRightToggle) {
          elbowRightToggle = false;
        } else {
          elbowRightToggle = true;
        }
        break;
    }

  }

  if(elbowLeftToggle){
    elbowLeft.write(70);
  } else {
    elbowLeft.write(140);
  }
  
  if(elbowRightToggle){
    elbowRight.write(50);
  } else {
    elbowRight.write(110);
  }

  if (baseShoulderLeftTurnLeft == true && baseShoulderLeftPos <= 180) {
    baseShoulderLeftPos += 0.03;
  }
  if (baseShoulderLeftTurnRight == true && baseShoulderLeftPos >= 0) {
    baseShoulderLeftPos -= 0.03;
  }
  baseShoulderLeft.write(baseShoulderLeftPos);

  if (shoulderLeftMoveDown == true && shoulderLeftPos >= 0) {
    shoulderLeftPos -= 0.03;
  } else if (shoulderLeftMoveUp == true && shoulderLeftPos <= 180) {
    shoulderLeftPos += 0.03;
  }
  shoulderLeft.write(shoulderLeftPos);



  if (baseShoulderRightTurnLeft == true && baseShoulderRightPos <= 180) {
    baseShoulderRightPos += 0.03;
  }
  if (baseShoulderRightTurnRight == true && baseShoulderRightPos >= 0) {
    baseShoulderRightPos -= 0.03;
  }
  baseShoulderRight.write(baseShoulderRightPos);

  if (shoulderRightMoveDown == true && shoulderRightPos <= 180) {
    shoulderRightPos += 0.03;
  } else if (shoulderRightMoveUp == true && shoulderRightPos >= 0) {
    shoulderRightPos -= 0.03;
  }
  shoulderRight.write(shoulderRightPos);



}
