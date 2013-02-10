
//includes
import processing.video.*;
import topcodes.*;
import java.util.List; // need this to be explicit in 2.0 onward

// decalrations
Capture cam;
topcodes.Scanner scanner; // top code scanner

PImage bull, chicago;

void setup() {
  
  size(640, 480);
  String[] cameras = Capture.list();
  cam = new Capture(this, 640,480);
    //cam.start();  
  
  bull = loadImage("bull.jpeg"); 
  chicago = loadImage("chicago.jpeg");
  println("Images loaded");
  
  scanner = new topcodes.Scanner();  // instantiate the object
  
  //i slowed this down because I found it really jumpy otherwise
  frameRate(10);
}

void draw() {

  if (cam.available() == true) {  // checking availability manually instead of with event
    cam.read();  

    // we need a copy of the pixels array
    // because the scanner modifies the image it is given
    int[] pixelsToTest = new int[cam.pixels.length];
    
    System.arraycopy(cam.pixels, 0, pixelsToTest, 0, cam.pixels.length);

    // List is a data type, codes is our copy of it
    // declare the List and set to to null (empty).
    List<TopCode> listOfcodes = null;
    
    // fill the list with any tags we might find
    listOfcodes = scanner.scan(pixelsToTest, cam.width, cam.height);

    // debug how many tags we found
    println(listOfcodes.size());
  
    // draw the image for reference
    image(cam, 0, 0);  

    // draw the codes (if any)
    rectMode(CENTER);
    stroke(0, 255, 0);
    noFill();
    // iterate over the List
    // this says for each item in List -- > or each TopCode code : codes
    for (TopCode code : listOfcodes) {
       pushMatrix();
           translate(code.getCenterX(), code.getCenterY());
           float codeSize = 2* code.getDiameter();
           rotate(code.getOrientation());
           
              if (code.getCode() == 31 ) {  
               // image (bull ,0 , 0, codeSize, codeSize);
               // we can move the image to the center of the tag
                image (bull ,-codeSize/2 , -codeSize/2, codeSize, codeSize);
              } 
              
              if (code.getCode() == 47 ) { 
                rotate(code.getOrientation());
               // image (bull ,0 , 0, codeSize, codeSize);
               // we can move the image to the center of the tag
                image (chicago ,-codeSize/2 , -codeSize/2, codeSize, codeSize);
              } 


       popMatrix();
       println(code.getCode());
    }
  }
}


