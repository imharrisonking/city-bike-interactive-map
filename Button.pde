class Button
{
  PImage play;
  PImage pause;
  PImage fastForward;
  PImage rewind;
  PImage reset;
  
  PImage times60;
  PImage times1800;
  PImage times3600;
  
  PImage blueplay;
  PImage bluepause;
  PImage bluefastForward;
  PImage bluerewind;
  PImage bluereset;

  PImage activefastForward;
  PImage activereset;
    
  boolean over = false;
  
  boolean run_forwards = false;
  boolean run_backwards = false;
  boolean run_play = false;
  boolean run_stopped = false;
  
  Button()
  {
  play = loadImage("play-button.png");
  pause = loadImage("pause-button.png");
  fastForward = loadImage("fast-forward-button.png");
  rewind = loadImage("rewind-button.png");   
  reset = loadImage("reset-button.png");
  
  times60= loadImage("times-60.png");
  times1800= loadImage("times-1800.png");
  times3600= loadImage("times-3600.png");
  
  blueplay = loadImage("blue-play-button.png");
  bluepause = loadImage("blue-pause-button.png");
  bluefastForward = loadImage("blue-fast-forward-button.png");
  bluerewind = loadImage("blue-rewind-button.png");   
  bluereset = loadImage("blue-reset-button.png"); 
  
  activefastForward = loadImage("active-fast-forward-button.png");
  activereset = loadImage("active-reset-button.png");   
  }
  
  // Increase the animation counter when the fast forward button is pressed
  void forwardclicked(float px, float py)
  {
    float d = dist(px, py, -432.5, 125-height/2);
    if (d < 20)
    {
      run_forwards = true;
      animationcount++;
    }
  } 
  
  // Speed up the animation when the fast forward button is pressed
  void increaseSpeed(float px, float py)
  {
    if (animationcount == 0)
    {
      animationspeed = 1;
    }
    
    float d = dist(px, py, -432.5, 125-height/2);
    if ((animationcount == 1) && (run_forwards == true))
    {
      capturetime = artificialtime;
      startTimer.decrease_endTime(endTime);
      startTimer.save_displayTime(capturetime);
      for (int i = 1; i < trips.length; i++)
      {
        trips[i].starttime = trips[i].starttime/60;
        trips[i].endtime = trips[i].endtime/60;
      }
      run_forwards = false;
     }
         
    if (animationcount == 1)
    {
      animationspeed = 60;
      image(activefastForward, -432.5, 125-height/2, 25, 25);
      image(times60, -432.5, 85-height/2, 50, 50);
    }
    
   if ((animationcount == 2) && (run_forwards == true))
    {
      capturetime = artificialtime;
      startTimer.decrease_endTime(endTime);
      startTimer.save_displayTime(capturetime);      
      for (int i = 1; i < trips.length; i++)
      {
        trips[i].starttime = trips[i].starttime/30;
        trips[i].endtime = trips[i].endtime/30;
      }
      run_forwards = false;
     }

    if (animationcount == 2)
    {
      animationspeed = 1800;
      image(activefastForward, -432.5, 125-height/2, 25, 25);
      image(times1800, -432.5, 85-height/2, 50, 50);
    }     
    
    if ((animationcount == 3) && (run_forwards == true))
    {
      capturetime = artificialtime;
      startTimer.decrease_endTime(endTime);
      startTimer.save_displayTime(capturetime);      
      for (int i = 1; i < trips.length; i++)
      {
        trips[i].starttime = trips[i].starttime/2;
        trips[i].endtime = trips[i].endtime/2;
      }
      run_forwards = false;
     }

    if ((animationcount == 4) && (run_forwards == true))
    {
      animationcount =3;
      run_forwards = false;
     }     

    if (animationcount == 3)
    {
      animationspeed = 3600;
      image(activefastForward, -432.5, 125-height/2, 25, 25);
      image(times3600, -432.5, 85-height/2, 50, 50);
    } 
     
    if (d < 20)
    {
      over = true;  
      cursor(HAND);
      image(bluefastForward, -432.5, 125-height/2, 25, 25);
    }
    
    else
    {
      over = false;
      image(fastForward, -432.5, 125-height/2, 25, 25);
    }
  }
  
  // Decrease the animation counter when the rewind button is pressed
  void backclicked(float px, float py)
  {
    float d = dist(px, py, -587.5, 125-height/2);
    if ((d < 20) && (animationcount > 0))
    {
      run_backwards = true;
      animationcount--;
    }
  }
  
  // Slow down the animation when the rewind button is pressed
  void decreaseSpeed(float px, float py)
  {
    float d = dist(px, py, -587.5, 125-height/2);
    if ((animationcount == 0) && (run_backwards == true))
    {
      capturetime = artificialtime;
      startTimer.increase_endTime(endTime);
      startTimer.save_displayTime(capturetime);      
      for (int i = 1; i < trips.length; i++)
      {
        trips[i].starttime = trips[i].starttime*60;
        trips[i].endtime = trips[i].endtime*60;
      }
      run_backwards = false;
     }
     
    if ((animationcount == 1) && (run_backwards == true))
    {
      capturetime = artificialtime;
      startTimer.increase_endTime(endTime);
      startTimer.save_displayTime(capturetime);      
      for (int i = 1; i < trips.length; i++)
      {
        trips[i].starttime = trips[i].starttime*30;
        trips[i].endtime = trips[i].endtime*30;
      }
      run_backwards = false;
     }
     
    if ((animationcount == 2) && (run_backwards == true))
    {
      capturetime = artificialtime;
      startTimer.increase_endTime(endTime);
      startTimer.save_displayTime(capturetime);      
      for (int i = 1; i < trips.length; i++)
      {
        trips[i].starttime = trips[i].starttime*2;
        trips[i].endtime = trips[i].endtime*2;
      }
      run_backwards = false;
     }     
     
    if (d < 20)
    {
      over = true;      
      cursor(HAND);
      image(bluerewind, -587.5, 125-height/2, 25, 25);
    }
    
    else
    {
      image(rewind, -587.5, 125-height/2, 25, 25);
    }    
  }

  // Increase the play/pause counter when the play/pause button is clicked
  void playclicked(float px, float py)
  {
    float d = dist(px, py, -484.1, 125-height/2);
    if (d < 20)
    {
      run_play = true;
      playcount++;
      stopped++;
    }
  }

  // Play or pause the animation when play/pause counter is odd or even
  void playPause(float px, float py)
  {
    float d = dist(px, py, -484.1, 125-height/2);
    if (((playcount%2) == 0) && (run_play == true))
    {
      running = 0;
      run_play = false;
    }
    
    if (((playcount%2) == 0) || (stopped == 0))
    {
      image(play, -484.1,125-height/2, 25, 25);
    }

    if ((((playcount%2) == 0) || (stopped == 0)) && (d < 20))
    {
      image(blueplay, -484.1, 125-height/2, 25, 25);
    }    
    
    if (((playcount%2) > 0) && (run_play == true))
    {
      running = 1;
      run_play = false;
    }

    if (((playcount%2) > 0) && (stopped > 0))
    {
      image(pause, -484.1,125-height/2, 25, 25);
    }    
    
    if ((((playcount%2) > 0) && (stopped > 0)) && (d < 20))
    {
      image(bluepause, -484.1, 125-height/2, 25, 25);
    }
    
    if (d <20)
    {
      over = true;
      cursor(HAND);
    }
  }    
  
  // Increase the play/pause counter when the play/pause button is clicked
  void stopclicked(float px, float py)
  {
    float d = dist(px, py, -535.7, 125-height/2);
    if (d < 20)
    {
      run_stopped = true;
      stopped++;
    }
  }

  // Stop and reset the animation
  void stopAnimation(float px, float py)
  {
    float d = dist(px, py, -535.7, 125-height/2);
    if ((stopped > 0) && (run_stopped == true))
    {
      running = 0;
      startTimer.reset_Time();
      for (int i = 0; i < stations.length; i++)
      {
        stations[i].resetBikes();
      }
      stopped = 0;
      run_stopped = false;
    }
    
    if (stopped > 0)
    {
      image(reset, -535.7, 125-height/2, 25, 25);
    }
    
    if (stopped == 0)
    {
      image(activereset, -535.7, 125-height/2, 25, 25);
    }    

    if ((stopped > 0) && (d < 20))
    {
      image(bluereset, -535.7, 125-height/2, 25, 25);
    }
    
    if (d < 20)
    {
      over = true;      
      cursor(HAND);
    }
  }
}  
