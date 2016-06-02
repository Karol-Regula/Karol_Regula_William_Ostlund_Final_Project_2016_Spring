public int size;
public int xd;
public int yd;
//public TrainLine[] lines = new TrainLine[100]; //will fix 
//public int trainLineSize;
public GameEngine g1 = new GameEngine();
public boolean mouseClick = false;
public boolean mouseClickRail = false;
public boolean removingRail = false;
public int x = -1;
public int y = -1;

void setup() {
  size = 40;
  frameRate(60);
  size(1280, 720);//window size
  background(0, 0, 0);//background color
  //noStroke();//disables border
  //mode?
  //lines[0] = t1;
  //g1.TrainLines = lines;
  g1.trainLineSize = 5;
  g1.cycleLines();
  g1.cycleLines();
  g1.cycleLines();
  g1.cycleLines();
  g1.cycleLines();
  smooth();
  Station s1  = new Station(400, 200, 0, 0);
  g1.masterStationList[g1.masterSize] = s1;
  g1.masterSize++;
  Station s2  = new Station(500, 350, 0, 1);
  g1.masterStationList[g1.masterSize] = s2;
  g1.masterSize++;
  Station s3  = new Station(800, 150, 0, 0);
  g1.masterStationList[g1.masterSize] = s3;
  g1.masterSize++;
}

void draw() {
  background(255, 255, 230);
  //mouseClicked();
  for (int i = 0; i < g1.trainLineSize; i++) {
    //if (mousePressed){
    //lines[i].lineSetup();
    //lines[i].addStation(mouseX, mouseY);
    //}
    g1.TrainLines[i].drawRails();
    g1.TrainLines[i].drawStations();
  }
  g1.drawDuplicateRails();
  for (int i = 0; i < g1.trainLineSize; i++) {
    g1.TrainLines[i].moveTrains();
    if (g1.TrainLines[i].typesHere.size() > 0) {
      //System.out.println(g1.TrainLines[i].typesHere.get(0));
    }
  }
  for (int i = 0; i < g1.masterSize; i++) {
    g1.masterStationList[i].reloadStopHere();
  }
  g1.spawnStations();
  g1.drawPassengersOnTrains();
  g1.drawStations();//draws unconnected stations
  g1.spawnPassengers();
  g1.drawPassengers();
  g1.drawExtra();


  //g1.spawnStations();
  g1.hover(10, 40, 30, 70);
  rect(10, 30, 30, 30);
  fill(50);
  text("New TrainLine", 50, 50);
  g1.hover(10, 40, 100, 130);

  fill(g1.currentColor);
  rect(10, 100, 30, 30);
  fill(50);
  text("Cycle Lines", 50, 120);
  text(g1.currentNumber, 130, 120);
  if (removingRail) {
    fill(10);
    g1.findRail();
  } else {
    g1.hover(10, 40, 170, 200);
  }
  //System.out.println(mouseClick);
  rect(10, 170, 30, 30);
  fill(50);
  text("Remove Rail", 50, 190);
  fill(0, 225, 225);

  fill(50);
  text("Number of TrainLines: ", 15, 22);
  text(g1.trainLineSize, 150, 22);
  g1.printText();

  g1.detectRail();//moved out of draw ino function in GameEngine
  rect(10, 240, 30, 30);
  fill(50);
  text("Add Rail", 50, 260);
  g1.hover(10, 40, 310, 340);

  //createTrain
  rect(10, 310, 30, 30);
  fill(50);
  text("Spawn Train (Current Train Line)", 50, 340);
  fill(0, 225, 225);
  g1.railCheck(g1.currentNumber);
}

void mouseClicked() {
  if (mouseX > 10 && mouseX < 40 && mouseY > 30 && mouseY < 70) {
    //I think the User should add a station here, I think its time we switch to a manual user interface rather than 

    //TrainLine t1 = new TrainLine(color( (int)(Math.random() * 255), (int)(Math.random() * 255), (int)(Math.random() * 255) ));
    //g1.TrainLines[g1.trainLineSize] = t1;
    //g1.trainLineSize++;
    //textSize(12);
    //g1.addText("New TrainLine has been created.", 200, 30);
    //g1.holdText = 300;
  }
  if (mouseX > 10 && mouseX < 40 && mouseY > 100 && mouseY < 130) {
    g1.cycleLines();
  }
  if (mouseX > 10 && mouseX < 40 && mouseY > 170 && mouseY < 200) {
    if (removingRail) {
      removingRail = false;
      for (int i = 0; i < g1.masterSize; i++) {
        g1.masterStationList[i].selected = false;
      }
      x = -1;
      y = -1;
    } else {
      mouseClickRail = false;
      for (int i = 0; i < g1.masterSize; i++) {
        g1.masterStationList[i].selected = false;
      }
      x = -1;
      y = -1;
      removingRail = true;
    }
  }
  if (mouseX > 10 && mouseX < 40 && mouseY > 240 && mouseY < 270) {
    if (mouseClickRail) {
      mouseClickRail = false;
      for (int i = 0; i < g1.masterSize; i++) {
        g1.masterStationList[i].selected = false;
      }
      x = -1;
      y = -1;
    } else {
      removingRail = false;
      for (int i = 0; i < g1.masterSize; i++) {
        g1.masterStationList[i].selected = false;
      }
      x = -1;
      y = -1;
      mouseClickRail = true;
    }
  }
  if (mouseX > 10 && mouseX < 40 && mouseY > 310 && mouseY < 340) {
    g1.spawnTrain();
  }
}


//use vectors for movement?

//WORLD SET UP
//makes trains
//make trains move
//make passengers
//allow them to board

//make sure stations don't spawn in text area

//USER INTERFACE

//when creating new stations, where to put them to make them unaffiliated with a trainline



//BUGS