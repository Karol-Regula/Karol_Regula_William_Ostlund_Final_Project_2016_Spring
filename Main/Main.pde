public int size;
public int xd;
public int yd;

void setup() {
  size = 40;
  frameRate(30);
  size(1280, 720);//window size
  background(255, 255, 0);//background color
  //noStroke();//disables border
  //mode?


  //to be placed in correct mode later
  GameEngine g1 = new GameEngine();
  for (int i = 0; i < 5; i++) {
    g1.createStation((int)(Math.random() * 1280), (int)(Math.random() * 720));
    //ifrandomly creating stations, add check to see if too close to other station
  }
  g1.createRail(g1.stationList[0], g1.stationList[1]);
  //g1.createStation(100,100);
  g1.drawStations();
  g1.drawRails();
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