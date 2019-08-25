import processing.serial.*;
import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

ControlDevice cont;
ControlIO control;

Serial myPort;

float leftHorizontalJoy;
float lastLeftHorizontalJoy = 0;

float leftVerticalJoy;
float lastLeftVerticalJoy = 0;

float rightHorizontalJoy;
float lastRightHorizontalJoy = 0;

float rightVerticalJoy;
float lastRightVerticalJoy = 0;

float grips;
float lastGrips = 0;

boolean leftElbow;
boolean lastLeftElbow = false;

boolean rightElbow;
boolean lastRightElbow = false;

boolean A;
boolean lastA = false;

boolean B;
boolean lastB = false;

void setup(){
 size(360, 200);
 control = ControlIO.getInstance(this);
 cont = control.getMatchedDevice("BackpackArms");
 
 String portName = Serial.list()[2];
 myPort = new Serial(this, portName, 9600);
 
 if(cont == null){
   println("invalid controller");
   System.exit(-1);
 }

}

public void getUserInput(){
  leftHorizontalJoy = cont.getSlider("LR").getValue();
  leftVerticalJoy = cont.getSlider("UD").getValue();
  rightHorizontalJoy = cont.getSlider("lr").getValue();
  rightVerticalJoy = cont.getSlider("ud").getValue();
  
  grips = cont.getSlider("Grips").getValue();
  
  leftElbow = cont.getButton("LeftElbow").pressed();
  rightElbow = cont.getButton("RightElbow").pressed();
  
  A = cont.getButton("A").pressed();
  B = cont.getButton("B").pressed();
}

void draw(){
  getUserInput();
  //background(leftHorizontalJoy,199,255);
    
  if(A == true && lastA == false){
   myPort.write('A'); 
  }
  lastA = A;
  
  if(B == true && lastB == false){
    myPort.write('B');
  }
  lastB = B;
  
  if(leftElbow == true && lastLeftElbow == false){
   myPort.write('E'); 
  }
  lastLeftElbow = leftElbow;
  
  if(rightElbow == true && lastRightElbow == false){
    myPort.write('e');
  }
  lastRightElbow = rightElbow;
  
  
  //Left Horizontal
  if(leftHorizontalJoy < -0.5 && lastLeftHorizontalJoy > -0.5){
    myPort.write('L');
    println('L');
  }
  if(leftHorizontalJoy > 0.5 && lastLeftHorizontalJoy < 0.5){
    myPort.write('R');
    println('R');
  }
  if(leftHorizontalJoy > -0.5 && leftHorizontalJoy < 0.5 && (lastLeftHorizontalJoy <-0.5 || lastLeftHorizontalJoy >0.5)){
   myPort.write('S');
   println('S');
  }
  lastLeftHorizontalJoy = leftHorizontalJoy;
  
  
  
  //Left Vertical
  if(leftVerticalJoy < -0.5 && lastLeftVerticalJoy > -0.5){
    myPort.write('D');
  }
  if(leftVerticalJoy > 0.5 && lastLeftVerticalJoy < 0.5){
    myPort.write('U');
  }
  if(leftVerticalJoy > -0.5 && leftVerticalJoy < 0.5 && (lastLeftVerticalJoy <-0.5 || lastLeftVerticalJoy >0.5)){
   myPort.write('S'); 
  }
  lastLeftVerticalJoy = leftVerticalJoy;
  
  
  
  //Right Horizontal
  if(rightHorizontalJoy < -0.5 && lastRightHorizontalJoy > -0.5){
    myPort.write('l');
  }
  if(rightHorizontalJoy > 0.5 && lastRightHorizontalJoy < 0.5){
    myPort.write('r');
  }
  if(rightHorizontalJoy > -0.5 && rightHorizontalJoy < 0.5 && (lastRightHorizontalJoy <-0.5 || lastRightHorizontalJoy >0.5)){
   myPort.write('s'); 
  }                                                                                                                                                                                                                                                                                                                                                        
  lastRightHorizontalJoy = rightHorizontalJoy;
  
  
  
  //Right Vertical
  if(rightVerticalJoy < -0.5 && lastRightVerticalJoy > -0.5){
    myPort.write('d');
  }
  if(rightVerticalJoy > 0.5 && lastRightVerticalJoy < 0.5){
    myPort.write('u');
  }
  if(rightVerticalJoy > -0.5 && rightVerticalJoy < 0.5 && (lastRightVerticalJoy <-0.5 || lastRightVerticalJoy >0.5)){
   myPort.write('s'); 
  }
  lastRightVerticalJoy = rightVerticalJoy;
  
  
  
}
