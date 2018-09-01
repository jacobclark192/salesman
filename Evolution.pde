class Evolution{
  Route[] routes;
  int generation = 0;
  float best = 0;
  
  Evolution(PVector[] d, int popSize){
    routes = new Route[popSize];
    for (int i = 0; i<popSize; i++) {
      routes[i] = new Route(d, 10);
    }
    sortRoutes();
  }
 
  void evolve(){
    sortRoutes();
    breed();
    naturalSelection();
  }
  
  //OPTIMIZE
  void sortRoutes(){
    Route temp;
    for(int i=0; i<routes.length-1; i++){
      for(int j=i+1; j<routes.length; j++){
        if(routes[j].eval() < routes[i].eval()){
          temp = routes[i];
          routes[i] = routes[j];
          routes[j] = temp;
        }
      }
    }
    best = routes[0].eval();
  }
  
  //This can do anything you want, you just need to make a new generation based off the
  // winners of the last generation. My children are all currently asexual and generate
  // children on their own.
  void breed(){
    int TOP_WINNERS = 10;
    int VARIANTS = (routes.length/(2*TOP_WINNERS))-1;
    generation++;
    
    //foreach of the top TOP_WINNER positions,
    // Create VARIANTS number of new children
    for(int i=0; i<TOP_WINNERS; i++){
      for(int j=0; j<VARIANTS; j++){
        int index = (i*VARIANTS)+j+TOP_WINNERS;
        routes[index] = new Route(routes[i].path,0); //copy the good route into the new route
        
        switch(index%3){
          case 0: 
            routes[index].swap(floor(random(1,4)));
            break;
          case 1:
            routes[index].shift();
            break;
          case 2:
            if(!routes[index].uncross(false)){ //try to uncross
              routes[index].shift(); //just shift if no intersections were found
            }
            break;
        }
      }
    }
  }
  
  void naturalSelection(){
    for (int i = (routes.length/2); i<routes.length; i++) {
      routes[i] = new Route(routes[0].path, floor(random(routes.length/2))+1);
    }
  }
}
