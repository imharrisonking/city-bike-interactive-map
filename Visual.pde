class Visual
{
  PImage pin;
  float x_padding;
  float y_padding;
  float box_width;
  float top_box_height;
  float bot_box_height_1;
  float bot_box_height_2;
  int fillet_radius;
  float box_gap;
    
  Visual()
  {
  pin = loadImage("blue-pin.png");
  
  x_padding = 20;
  y_padding = 20;
  box_width = 220;
  top_box_height = 130;
  bot_box_height_1 = 50;
  bot_box_height_2 = 30;
  fillet_radius = 10;
  box_gap = 30;
  }
  
  // Called to display a pin when a station is selected
  void displayPin(float x, float y)
  {
    image(pin, x, y-12, 30, 30);
  }

  // Grey rectangle behind the time and buttons  
  void displayTimeRect()
  {
    strokeWeight(0);
    stroke(246, 246, 244, 250);
    fill(255, 255, 255, 250);
    rect(x_padding-width/2, y_padding-height/2, box_width, top_box_height, fillet_radius, fillet_radius, fillet_radius, fillet_radius);
    
    // Dividing line within top box
    strokeWeight(1);
    stroke(221,221,221);
    line(x_padding-width/2, 80+y_padding-height/2, box_width+x_padding-width/2, 80+y_padding-height/2); 
  }
  
  // Check to see if the mouse is hovering over the top blue rectangle
  var getRectw(float px, float py) 
  {
    float w = dist(px, 0.5*top_box_height+y_padding-height/2, 0.5*box_width+x_padding-width/2, 0.5*top_box_height+y_padding-height/2);
    return w;
  }
  
  // Check to see if the mouse is hovering over the top grey rectangle
  var getRecth(float px, float py) 
  {
    float h = dist(0.5*box_width+x_padding-width/2, py, 0.5*box_width+x_padding-width/2, 0.5*top_box_height+y_padding-height/2);
    return h;
  }
  
  // Grey rectangle behind the the station information
  void displayStationTopRect()
  {
    strokeWeight(0);
    stroke(246, 246, 244, 250);
    fill(255, 255, 255, 250);
    rect(x_padding-width/2, box_gap+top_box_height-height/2, box_width, bot_box_height_1, fillet_radius, fillet_radius, 0, 0);
  }
  
  void displayStationBotRect(int R, int G, int B)
  {
    strokeWeight(0);
    stroke(R, G, B, 250);
    fill(R, G, B, 250);
    rect(x_padding-width/2, bot_box_height_1+box_gap+top_box_height-height/2, box_width, bot_box_height_2, 0, 0, fillet_radius, fillet_radius);
    
    strokeWeight(0);
    stroke(246, 246, 244, 240);
    fill(255, 255, 255, 240);
    rect(x_padding-1-width/2, bot_box_height_1+box_gap+top_box_height-height/2, box_width-7.5, bot_box_height_2+1, 0, 0, fillet_radius, fillet_radius);
    
    // Dividing line within bottom box
    strokeWeight(1);
    stroke(221,221,221);
    line(x_padding-width/2, bot_box_height_1+box_gap+top_box_height-height/2, box_width+x_padding-width/2, bot_box_height_1+box_gap+top_box_height-height/2); 
  }
  
  void displayStationCallout(float x, float y, float radius, int bikes, String name)
  {    
    strokeWeight(0);
    stroke(246, 246, 244, 250);
    fill(241, 243, 241, 230);
    rect(x+radius, y-2*radius, name.length*6.25, 30, fillet_radius/2, fillet_radius/2, fillet_radius/2, fillet_radius/2);
    
//    // Line connecting rectangle to station
//    strokeWeight(1);
//    stroke(221,221,221);
//    line(x+radius, y-2*radius, x+
    
    fill(107, 107, 107);
    strokeWeight(1);
    stroke(107, 107, 107);
    textAlign(LEFT);
    textFont(bodyfont, 12);
    text(name, 5+x+radius, 13+y-2*radius);
    text(bikes + " Citi Bikes", 5+x+radius, 27+y-2*radius);
  }
}

