class Station 
{
  float id;
  float x;
  float y;
  float bikes;
  float radius;
  String name;
  float stationlat;
  float stationlon;

  boolean over = false;
  boolean selected = false;

  // Create the Station
  Station(float id_, float x_, float y_, 
  float bikes_, String s) 
  {
    id = id_;
    x = projectX(x_) - centrex;
    y = projectY(y_) - centrey;
    bikes = bikes_;
    name = s;
    stationlat = y_;
    stationlon = x_;
    radius = 25*bikes;
  }

  // Check to see if the mouse is hovering over a station
  void hover(float px, float py) 
  {
    float d = dist(px, py, x, y);
    if (d < sqrt(radius)/2) 
    {
      cursor(HAND);
      over = true;
    }
    else 
    {
      over = false;
    }
  }

  // Function to select a station, keep station showing when clicking within the animation control box
  void clicked(float px, float py)
  { 
    float w = visuals.getRectw(mouseX-(width/2), mouseY-(height/2));
    float h = visuals.getRecth(mouseX-(width/2), mouseY-(height/2));
    float d = dist(px, py, x, y);
    if (d < sqrt(radius)/2)
    {
      selected = true;
    }   
    if ((d > sqrt(radius)/2) && (w > visuals.box_width/2))
    {
      selected = false;
    }
    if ((d > sqrt(radius)/2) && (h > visuals.top_box_height/2))
    {
      selected = false;
    }
  }

  // Display the Station
  void display() 
  {
    if (bikes == 10)
    {
      if ((over == true) || (selected == true))
      {
        strokeWeight(1);
        stroke(253, 174, 97, 140);        
        fill(253, 174, 97, 140);
        ellipse(x, y, 0.85*sqrt(radius), 0.85*sqrt(radius));
      } 
      if ((over != true) && (selected != true))
      {
        // Draw circle at lat and long point
        fill(253, 174, 97, 140);
        strokeWeight(1);
        stroke(253, 174, 97, 140);
        ellipse(x, y, sqrt(radius), sqrt(radius));
      }
    }

    if (bikes > 10)
    {
      if ((over == true) || (selected == true))
      {
        strokeWeight(1);
        stroke(0, 215, 149, 140);        
        fill(0, 215, 149, 140);
        ellipse(x, y, 0.85*sqrt(radius), 0.85*sqrt(radius));
      }       
      if ((over != true) && (selected != true))
      {
        // Draw circle at lat and long point
        strokeWeight(1);
        stroke(0, 215, 149, 140);
        fill(0, 215, 149, 140);
        ellipse(x, y, sqrt(radius), sqrt(radius));
      }
    }

    if (bikes < 10)
    {
      if ((over == true) || (selected == true))
      {
        strokeWeight(1);
        stroke(215, 15, 28, 140);        
        fill(215, 15, 28, 140);
        ellipse(x, y, max(4.25, 0.85*sqrt(radius)), max(4.25, 0.85*sqrt(radius)));
      } 
      if ((over != true) && (selected != true))
      {
        // Draw circle at lat and long point
        fill(215, 15, 28, 140);
        strokeWeight(1);
        stroke(215, 15, 28, 140);
        ellipse(x, y, max(5, sqrt(radius)), max(5, sqrt(radius)));
      }
    }
  }

  void displayCallout()
  {
    if (over == true)
    {
      visuals.displayStationCallout(x, y, sqrt(radius), bikes, name);
    }
  }

  // Display the station name to the left of the screen when hovering over
  void displayName()
  {
    if (selected == true) 
    {
      visuals.displayPin(x, y);
      visuals.displayStationTopRect();

      if (bikes == 10)
      {
        visuals.displayStationBotRect(253, 174, 97);
      }

      if (bikes > 10)
      {
        visuals.displayStationBotRect(0, 215, 149);
      }

      if (bikes < 10)
      {
        visuals.displayStationBotRect(215, 15, 28);
      }

      fill(109, 109, 109);
      textFont(boldfont, 15);
      textAlign(LEFT);
      text(name, 30-width/2, 170-height/2, 210, 50);

      fill(109, 109, 109);
      textFont(bodyfont, 15);  
      text(bikes + " Citi Bikes at this station", 30-width/2, 220-height/2, 210, 50);
    }
  }

  // Reset the number of bikes to 10, called when the reset button is pressed
  void resetBikes()
  {
    bikes = 10;
    radius = 25*bikes;
  }
}

