/* @pjs font="OpenSans-Regular.ttf, OpenSans-SemiBold.ttf"; 
preload="active-fast-forward-button.png, active-reset-button.png, active-rewind-button.png, blue-fast-forward-button.png, blue-pause-button.png, blue-pin.png, blue-play-button.png, blue-reset-button.png, blue-rewind-button.png, fast-forward-button.png, pause-button.png, play-button.png, reset-button.png, rewind-button.png, times-1800.png, times-3600.png, times-60.png"; 
 */

// Size of the map
int width = 1280;
int height = 1280;

// Create the background map and fonts
PImage mapimage;
PFont boldfont;
PFont bodyfont;

// Assign the starting zoom level of the map and circle scale
float zoomlevel = 12.5;
float scale = 0.8;

// Create classes, including class arrays for station and trip data
Station[] stations;
Trip[] trips;
Button buttons;
Timer startTimer;
Visual visuals;

// Set intial speed and intial counter values globally for boolean button operations
int animationspeed = 1;
int animationcount = 0;
float playcount = 1;
int running = 1;
int stopped = 1;
float capturetime;

// Create string arrays for all unique Citi Bike station locations and trip data
String [] uniquestations;
String [] tripdata;

// Global functions to adjust lat and long using mercator projection to a 2D map
float projectX(float lon) 
{
  lon = radians(lon);
  float a = (256 / PI) * pow(2, zoomlevel) * (lon + PI);
  return a;
}

float projectY(float lat) 
{
  lat = radians(lat);
  float a  = (256 / PI) * pow(2, zoomlevel) * (PI - log(tan(PI / 4 + lat / 2)));
  return a;
}

// Centre the map to New York  lat: 40.734138, lng: -73.968665
float centrelat = 40.734138;
float centrelon = -73.968665;

float centrex = projectX(centrelon);
float centrey = projectY(centrelat);

void setup() 
{
  // Set the background settings and initialise the timer
  size(1280, 950);
  startTimer = new Timer();
  buttons = new Button();
  visuals = new Visual();
  capturetime = 0;

  // Load the map image using a Mapbox API token
  mapimage = loadImage("https://api.mapbox.com/styles/v1/mapbox/light-v10/static/" + 
  centrelon + "," + centrelat + "," + zoomlevel + "/" + width + "x" + height + 
  "?access_token=pk.eyJ1IjoiYm9tYm9taGkiLCJhIjoiY2pndHMwMmgzMHVxNTMzcDljdjFydzRqeiJ9.6mg_8MteZkdy2PYC0hhCfQ");

  // Load the Open Sans fonts used by Mapbox
  boldfont = loadFont("OpenSans-SemiBold.ttf");
  bodyfont = loadFont("OpenSans-Regular.ttf");

  // Process the initial data from the station and trip data csv files  
  processStationData();
  processTripData();
}

void draw() 
{   
  /* BACKGROUND */
  // Draw the background map, translating the origin to the centre of the bounding box, then re-centre and scale
  translate(width / 2, height / 2);
  imageMode(CENTER);
  image(mapimage, 0, 0);
  console.log(stations);
  
  
  visuals.displayTimeRect();
  
  /* TIME AND DATE */
  // Start and display the timer
  startTimer.countUp();
  startTimer.returnTime();
  startTimer.display();
  
  // Set the the end time, effectively pressing 'lap' on stopwatch
  endTime = startTimer.returnTime();
  artificialtime = startTimer.returndisplayTime();

  /* BUTTONS AND HOVERING */
  boolean hoveringOver = false;
  boolean stationOver = false;
  boolean buttonOver = buttons.over;
  
  buttons.increaseSpeed(mouseX-(width/2), mouseY-(height/2));
  buttons.decreaseSpeed(mouseX-(width/2), mouseY-(height/2));
  buttons.playPause(mouseX-(width/2), mouseY-(height/2));
  buttons.stopAnimation(mouseX-(width/2), mouseY-(height/2));
 
  /* STATION LOCATIONS */
  // Display all stations
  for (int i = 0; i < stations.length; i++)
  {
    stations[i].display();
    stations[i].hover(mouseX-(width/2), mouseY-(height/2));
  }
  // Displays the selected station on the left and drops a pin at selected station (seperate loop so that pin is always drawn above the previous circles)
  for (int i = 0; i < stations.length; i++)
  {
    stations[i].displayName();
    stations[i].displayCallout();
    
    stationOver |= stations[i].over;
  }

  /* ADJUST NUMBER OF BIKES OVER TIME */
  // Decrease the number of bikes at a station as a bike leaves and decrease the size of the circle accordingly
  for (int i = 1; i < trips.length; i++)
  {
    if ((endTime >= trips[i].starttime-(15)) && (endTime <= trips[i].starttime+(15)) && (running == 1))
    {
      int idx = stationObjectIndex(stations, trips[i].startid, "id");
      stations[idx].bikes--;
      stations[idx].radius = stations[idx].radius - 20;
    }
  }

  // Increase the number of bikes at a station as a bike arrives and increase the size of the circle accordingly
  for (int i = 1; i < trips.length; i++)
  {
    if ((endTime >= trips[i].endtime-(15)) && (endTime <= trips[i].endtime+(15)) && (running == 1))
    {
      int idx = stationObjectIndex(stations, trips[i].endid, "id");
      stations[idx].bikes++;
      stations[idx].radius = stations[idx].radius + 20;
    }
  }
  
  /* RESET THE CURSOR TO AN ARROW WHEN NOT HOVERING OVER CLICKABLE OBJECTS */
  if ((stationOver == true) || (buttonOver == true))
  {
   hoveringOver = true;
  }
  else
  {
    hoveringOver = false;
  }
  
  if (!hoveringOver)
  {
    cursor(ARROW);
  }
}

/* HELPER FUNCTIONS */
// Used in setup to pass through the station csv data to the array of Station class objects
void processStationData()
{
  // Load all unique Citi Bike stations from csv file
  uniquestations = loadStrings("unique-station-locations.csv");

  // Size of Station object array set by the number of unique stations in the csv file
  stations = new Station[uniquestations.length];

  // Iterate through the rows and extract the name, latitude, longitude and bikes of the station
  for (int i = 0; i < uniquestations.length; i++) 
  {
    String[] data = uniquestations[i].split(",");

    float id_ = float(data[0]);
    String name = data[1];
    float y_ = float(data[2]);
    float x_ = float(data[3]); 
    float bikes = float(data[4]); 

    stations[i] = new Station(id_, x_, y_, bikes, name);
  }
}

// Used in setup to pass through the trip data csv data to the array of Trip class objects  
void processTripData()
{
  // Load the second by second Citi Bike trip data for 1st week of April from csv file
  tripdata = loadStrings("202103-citibike-tripdata-1st-week.csv");

  // Size of Station object array set by the number of unique stations in the csv file
  trips = new Trip[tripdata.length];

  // Iterate through the rows and extract the data
  for (int i = 0; i < tripdata.length; i++) 
  {
    String[] data = tripdata[i].split(",");

    float startid_ = float(data[5]);
    float endid_ = float(data[9]);
    float startlat_ = float(data[7]);
    float startlon_ = float(data[8]);
    float endlat_ = float(data[11]);
    float endlon_ = float(data[12]);
    float starttime_ = float(data[2]);
    float endtime_ = float(data[4]);

    trips[i] = new Trip(startid_, endid_, startlat_, startlon_, endlat_, endlon_, starttime_, endtime_);
  }
}

// Retrieve the index of of a Station object by passing through one of its properties
function stationObjectIndex(Array array, int searchTerm, String property)
{
  for (int i = 0; i < array.length; i++) 
  {
    if (array[i][property] == searchTerm) return i;
  }
}

// Action button events when the mouse is clicked at a certain location
void mousePressed()
{
  buttons.forwardclicked(mouseX-(width/2), mouseY-(height/2));
  buttons.backclicked(mouseX-(width/2), mouseY-(height/2));
  buttons.playclicked(mouseX-(width/2), mouseY-(height/2));
  buttons.stopclicked(mouseX-(width/2), mouseY-(height/2));
  visuals.getRectw(mouseX-(width/2), mouseY-(height/2));
  visuals.getRecth(mouseX-(width/2), mouseY-(height/2));
  
  for (int i = 0; i < stations.length; i++)
  {
    stations[i].clicked(mouseX-(width/2), mouseY-(height/2));
  }
} 
