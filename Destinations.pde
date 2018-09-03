PVector[] setupDestinations(String fileName){
  PVector[] d = new PVector[DESTINATIONS];
  if(fileName.length() > 0){
    d = loadDestinations(fileName);
  }
  else{ 
    d = generateDestinations();
    saveDestinations(d);
  }
  return d;
}

PVector[] generateDestinations(){
  PVector[] d = new PVector[DESTINATIONS];
  for (int i = 0; i<DESTINATIONS; i++) {
    d[i] = new PVector(random(width-20)+10, random(height-20)+10, i+1);
  }
  return d;
}

void saveDestinations(PVector[] d){
  String fileName = "/destinations/" + year()+"_"+month()+"_"+day()+"_"+hour()+"_"+minute()+"_"+second()+".json";
  JSONObject data = new JSONObject();
  data.setInt("length", DESTINATIONS);
  data.setInt("routes", ROUTES);
  data.setInt("civs", CIVILIZATIONS);
  JSONArray values = new JSONArray();
  for (int i = 0; i < DESTINATIONS; i++) {
    JSONObject destination = new JSONObject();
    destination.setFloat("x", d[i].x);
    destination.setFloat("y", d[i].y);
    destination.setFloat("z", d[i].z);
    values.setJSONObject(i, destination);
  }
  data.setJSONArray("destinations", values);
  saveJSONObject(data, fileName);
}

PVector[] loadDestinations(String fileName){
  JSONObject data = new JSONObject();
  data = loadJSONObject("/destinations/" + fileName + ".json");
  int len = data.getInt("length");
  JSONArray values = data.getJSONArray("destinations");
  PVector[] destinations = new PVector[len];
  for (int i = 0; i < len; i++) {
    JSONObject d = values.getJSONObject(i);
    destinations[i] = new PVector(d.getInt("x"), d.getInt("y"), d.getInt("z"));
  }
  return destinations;
}
