public int size;
public int xd;
public int yd;
public TrainLine[] lines = new TrainLine[100]; //will fix 
public int trainLineSize;
public GameEngine g1 = new GameEngine();
public int holdText;
public int currentLine;
public color currentColor;

void setup() {
  size = 40;
  frameRate(120);
  size(1280, 720);//window size
  background(255, 255, 0);//background color
  //noStroke();//disables border
  //mode?
  TrainLine t1 = new TrainLine();
  lines[0] = t1;
  g1.TrainLines = lines;
  trainLineSize = 1;
}

void draw() {
  background(255, 255, 0);
  //mouseClicked();
  for (int i = 0; i < g1.size; i++) {
    //if (mousePressed){
    //lines[i].lineSetup();
    //lines[i].addStation(mouseX, mouseY);
    //}
    g1.TrainLines[i].drawRails();
    g1.TrainLines[i].moveTrains();
    g1.TrainLines[i].drawStations();
    g1.spawnStations();
    g1.drawStations();//draws unconnected stations
  }
  g1.spawnStations();
  rect(10, 10, 30, 30);
  fill(50);
  text("New TrainLine", 50, 30);
  fill(0, 225, 225);
  rect(10, 80, 30, 30);
  fill(50);
  text("Cycle Lines", 50, 100);
  fill(0, 225, 225);
  g1.printText();
}

void mouseClicked() {
  if (mouseX > 10 && mouseX < 40 && mouseY > 10 && mouseY < 40) {
    TrainLine t1 = new TrainLine();
    lines[trainLineSize] = t1;
    trainLineSize++;
    textSize(12);
    g1.addText("New TrainLine has been created.", 80, 30);
    g1.holdText = 400;
  }
  //g1.createStation(mouseX, mouseY);
  //g1.createRail(g1.stationList[g1.stationSize - 2], g1.stationList[g1.stationSize - 1]);
  //g1.createRail(g1.stationList[g1.stationSize - 2], g1.stationList[0]);
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

//when creating new stations, where to put them to make them unaffiliated with a trainline



//BUGS