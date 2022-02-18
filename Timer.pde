class Timer
{
  float Time;
  float displayTime;
  
  // Create the timer and set the time
  Timer()
  {
    clockTime = 0;
  }

  // Updates the timer counting upwards, using the set framerate
  void countUp()
  {
    clockTime += running/frameRate;
    displayTime += (running/frameRate)*animationspeed;
  }
  
  // Display and return the current time 
  void returnTime()
  {
//    textSize(12);
//    fill(0,0,0);
//    text(clockTime, width/2-50,-height/2+15);
    return clockTime*1000;
  }
  
  // Return the current displayTime 
  void returndisplayTime()
  {
//    textSize(12);    
//    fill(255,0,0);
//    text(displayTime, width/2-50,-height/2+40);
    return displayTime*1000;
  }
    
  // Used to decrease the current endTime after the fast forward button is pressed
  void decrease_endTime(float set)
  {
    clockTime = set*(1/(1000*animationspeed));
  }
  
  // Used to decrease the current endTime after the fast forward button is pressed
  void increase_endTime(float set)
  {
    clockTime = set*animationspeed/1000;
  }
  
  // Used to decrease the current displayTime after the fast forward button is pressed
  void save_displayTime(float set)
  {
    displayTime = set/1000;
  }
  
  // Used to reset all clocks to start the animation again when the stop button is pressed
  void reset_Time()
  {
    clockTime = 0;
    displayTime = 0;
  }
  
  void display()
  {
    var date = new Date(2021, 2, 1);
    date.setSeconds(displayTime);
  
    var day = date.getDate();
    var month = (date.getMonth() + 1) + "";
    var year = date.getFullYear() + "";
    var hour = date.getHours() + "";
    var minutes = date.getMinutes() + "";
    var seconds = date.getSeconds() + "";
  
    // Formatting the time 
    if (day < 10)
    {
      day = "0" + date.getDate() + "";
    } else
    {
      day = date.getDate() + "";
    }
  
    if (month < 10)
    {
      month = "0" + (date.getMonth() + 1) + "";
    } else
    {
      month = (date.getMonth() + 1) + "";
    }
  
    if (hour < 10)
    {
      hour = "0" + date.getHours() + "";
    } else
    {
      hour = date.getHours() + "";
    }
  
    if (minutes < 10)
    {
      minutes = "0" + date.getMinutes() + "";
    } else
    {
      minutes = date.getMinutes() + "";
    }
  
    if (seconds < 10)
    {
      seconds = "0" + date.getSeconds() + "";
    } else
    {
      seconds = date.getSeconds() + "";
    }    
  
    String formatdate = day + "/" + month + "/" + year + " " + hour + ":" + minutes + ":" + seconds;
  
    // Display the formatted and scaled time
    fill(5, 43, 108);
    textFont(boldfont, 30);
    textAlign(LEFT); 
    text(formatdate, 35-width/2, 30-height/2, 200, 200);    
  }
}
