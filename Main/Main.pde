public int size;
public int xd;
public int yd;
public GameEngine g1 = new GameEngine();  

void setup() {
  size = 40;
  frameRate(120);
  size(1280, 720);//window size
  background(255, 255, 0);//background color
  //noStroke();//disables border
  //mode?


  //to be placed in correct mode later
  for (int i = 0; i < 5; i++) {
    g1.createStation((int)(Math.random() * 1280), (int)(Math.random() * 720));
    //ifrandomly creating stations, add check to see if too close to other station
  }
  for (int i = 0; i < g1.stationSize - 1; i++){
    g1.createRail(g1.stationList[i], g1.stationList[i + 1]);
    g1.createRail(g1.stationList[g1.stationSize - 1], g1.stationList[0]);
  }
  g1.createTrain();
  //g1.createStation(100,100);
}

void draw() {
  background(255, 255, 0);
  g1.drawRails();
  g1.moveTrains();
  g1.drawStations();
}

//Questions to address:
//coordinate class
//naming
//arrays vs arraylists vs linked lists vs whatever

//use vectors for movement?

//WORLD SET UP
//makes trains
//make trains move
//make passengers
//allow them to board

//USER INTERFACE



//BUGS