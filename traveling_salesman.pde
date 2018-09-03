import lord_of_galaxy.timing_utils.*;

//SETTINGS
static final int DESTINATIONS = 50;  //number of points on the screen
static final int ROUTES = 100;        //number of paths in a population
static final int CIVILIZATIONS = 100; //number of populations in the simulation

static final String useFile = "";

//GLOBALS
Stopwatch s = new Stopwatch(this);
boolean paused = false;
int civIndex = -1;
float currentBest = Float.MAX_VALUE;
Evolution[] civilization = new Evolution[CIVILIZATIONS];

//SETUP
void setup(){
  size(800,800);
  PVector[] destinations = setupDestinations(useFile);  
  for(int i=0; i<CIVILIZATIONS; i++){
    civilization[i] = new Evolution(destinations, ROUTES);
  }
  s.start();
}

//DRAW
void draw(){
  civIndex = -1;
  while (civIndex<0) {
    for(int i=0; i<CIVILIZATIONS; i++){
      civilization[i].evolve();
      if(civilization[i].best < currentBest){
        currentBest = civilization[i].best;
        civIndex = i;
      }
    }
  }
  civilization[civIndex].routes[0].show(civilization[civIndex].generation, civIndex);
}

void keyReleased() {
  if(key == ' '){
    if(paused) {
      loop();
      print("Running....\n");
    } else {
      noLoop();
      print("Paused....\n");
    }
    paused = !paused;
  }
}
