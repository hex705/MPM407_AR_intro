
//includes
import processing.video.*;
import topcodes.*;
import java.util.List; // need this to be explicit in 2.0 onward

// decalrations
Capture cam;
topcodes.Scanner scanner; // top code scanner


void setup() {
  
  size(640, 480);
  String[] cameras = Capture.list();
  cam = new Capture(this, 640,480);
    cam.start();  

  scanner = new topcodes.Scanner();  // instantiate the object
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
           text(code.getCode(), 0, 0);
           rotate(code.getOrientation());
           rect(0, 0, code.getDiameter(), code.getDiameter());
       popMatrix();
       println(code.getCode());
    }
  }
}


