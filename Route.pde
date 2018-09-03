class Route {

  PVector[] path;

  Route(PVector[] p, int randSwaps) {
    path = new PVector[p.length];
    System.arraycopy(p, 0, path, 0, p.length);
    this.swap(randSwaps); //make "random"
  }

  void show(int gen, int civ) {
    background(120);
    //Draw lines
    stroke(2);
    for (int i = 0; i<path.length-1; i++) {
      line(path[i].x, path[i].y, path[i+1].x, path[i+1].y);
    }
    line(path[0].x, path[0].y, path[path.length-1].x, path[path.length-1].y);

    noStroke();
    for (PVector v : path) {
      ellipse(v.x, v.y, 10, 10);
    }
    //Draw numbers
    //fill(255);
    //for (PVector v : path) {  
    //  text((int)v.z, v.x+4, v.y-4);
    //}
    print("gen:" + gen + "\tciv:" + civ + "\teval: " + eval() + "\ttime:" + str(s.time()/1000.0) + "\n");
  }

  float eval() {
    float dist = 0;
    for (int i=0; i<path.length-1; i++) {
      dist += sqrt((path[i].x-path[i+1].x)*(path[i].x-path[i+1].x)+(path[i].y-path[i+1].y)*(path[i].y-path[i+1].y));
    }
    dist += sqrt((path[0].x-path[path.length-1].x)*(path[0].x-path[path.length-1].x)+(path[0].y-path[path.length-1].y)*(path[0].y-path[path.length-1].y));
    return dist;
  }

  void swap(int swaps) {
    PVector temp;
    for (int k = 0; k<swaps; k++) {
      int i = floor(random(path.length));
      int j = floor(random(path.length));
      temp = path[i];
      path[i] = path[j];
      path[j] = temp;
    }
  }

  void shift() {
    int sectionLength = floor(random(1, path.length-2)); //pick some number of locations
    int startingIndex = floor(random(0, path.length-sectionLength-1)); //beginning of section
    int shiftAmount = floor(random(1, path.length-sectionLength-startingIndex)); //distance to shift
    //print("sectionLength: " + sectionLength + " startingIndex: " + startingIndex + " shiftAmount: " + shiftAmount + "\n");

    PVector[] section1 = new PVector[sectionLength];
    PVector[] section2 = new PVector[shiftAmount];
    System.arraycopy(path, startingIndex, section1, 0, sectionLength);
    System.arraycopy(path, startingIndex+sectionLength, section2, 0, shiftAmount);
    if (random(1) > 0.5) {
      PVector tempSection;
      for (int i=0; i<section1.length/2; i++)
      {
        tempSection = section1[i];
        section1[i] = section1[section1.length-i-1];
        section1[section1.length-i-1] = tempSection;
      }
    }
    System.arraycopy(section1, 0, path, startingIndex+shiftAmount, sectionLength);
    System.arraycopy(section2, 0, path, startingIndex, shiftAmount);
  }

  boolean uncross() {
    int i, j, k;
    int offset = floor(random(path.length-1)); //create an offset so i'm not always starting at index 0
    for (k=0; k<path.length-3; k++) {
      i = (k+offset)%path.length;
      
      //use i+2 because a line will not intersect the very next line
      for (j=i+2; j<path.length-1; j++) { 
        if (doIntersect(path[i], path[i+1], path[j], path[j+1])) {
          reverseSubsection(i+1 ,j);
          return true;
        }
      }
    }
    return false;
  }
  
  void reverseSubsection(int i, int j){ // reverse the subsection that goes from index i to j
    int sectionLength = j-i+1;
    PVector tempSection;
    for (int k=0; k<sectionLength/2; k++)
    {
      tempSection = path[i+k];
      path[i+k] = path[i+sectionLength-k-1];
      path[i+sectionLength-k-1] = tempSection;
    }
  }
  
  void printOrder() {
    for (int i = 0; i<path.length-1; i++) {
      print((int)path[i].z + ", ");
    }
    print((int)path[path.length-1].z + "\n");
  }
}
