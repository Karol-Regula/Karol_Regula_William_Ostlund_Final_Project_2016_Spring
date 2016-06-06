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
public boolean loop;
public int state = 0;
public boolean ok = false;
public PFont p1;

void setup() {
  
  p1 = createFont("Souvenir Bold.ttf", 14); 
  size = 40;
  frameRate(60);
  size(1280, 720);//window size
  background(0, 0, 0);
}

void menu() {
  background(255, 255, 230);
  fill(0);
  //PFont p1 = createFont("Souvenir Bold.ttf", 14);
  textFont(p1);
  textSize(64);
  text("Mini Metro", 450, 200);
  textSize(32);
  text("A Computer Science Project by Karol Regula and Will Ostlund", 100, 250);
  if (mouseX > 525 && mouseY > 320 && mouseX < 740 && mouseY < 410) {
    textSize(80);
    text("Start", 535, 403);
  } else {
    textSize(72); 
    text("Start", 540, 400);
  }
  if (mouseX > 475 && mouseY > 495 && mouseX < 825 && mouseY < 530) {
    textSize(54);
    text("Instructions", 490, 528);
  } else {
    textSize(48); 
    text("Instructions", 500, 525);
  }
}

void setup1() {
  //background color
  //noStroke();//disables border
  //mode?
  //lines[0] = t1;
  //g1.TrainLines = lines;
  size = 40;
  frameRate(60);
  size(1280, 720);//window size
  background(0, 0, 0);  
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
  Station s3  = new Station(800, 150, 0, 2);
  g1.masterStationList[g1.masterSize] = s3;
  g1.masterSize++;

  //remove this
  Station s4  = new Station(800, 300, 0, 2);
  g1.masterStationList[g1.masterSize] = s4;
  g1.masterSize++;
  loop = true;
}

void instructions() {
  background(255, 255, 230);
  fill(0);
  //PFont p1 = createFont("Souvenir Bold.ttf", 14);
  textFont(p1);
  textSize(64);
  text("Instructions", 450, 100);
  textSize(24);
  text("1. Your main objective is to create a functional train system connecting randomly", 100, 200);
  text("located stations", 100, 250);
  text("2. If a station becomes overcrowded for too long, you lose!", 100, 300);
  text("3. To successfully transfer a passenger, you must move them to the station ", 100, 350);
  text("of the corresponding shape", 100, 400);
  text("4. To add or remove a rail, press the button (this will be obvious due labeling)", 100, 450);
  text("and click on the two stations between which you want the rail to be created/removed", 100, 500);
  if (mouseX > 525 && mouseY > 520 && mouseX < 740 && mouseY < 610) {
    textSize(80);
    text("Start", 535, 603);
  } else {
    textSize(72); 
    text("Start", 540, 600);
  }
}

void draw() {
  if (state == 0) {
    menu();
  } else if (state == 2) {
    instructions();
  } else if (state == 1) {
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
    //g1.drawPassengerRoutes();
    g1.drawExtra();


    //g1.spawnStations();
    g1.hover(10, 40, 30, 70);
    //rect(10, 30, 30, 30);
    fill(50);
    strokeWeight(3);
    //text("New TrainLine", 50, 50);
    //System.out.println(p1.list());
    //PFont p1 = createFont("Souvenir Bold.ttf", 14);
    textFont(p1);
    textSize(20);
    text("HighScore: "+ g1.highScore, 20, 70);
    textSize(14);


    g1.hover(10, 40, 100, 130);

    fill(g1.currentColor);
    rect(10, 100, 30, 30);
    fill(50);

    text("Cycle Lines: " + g1.currentNumber, 50, 120);
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
    text("Number of TrainLines: " + g1.trainLineSize, 15, 22);
    g1.printText();

    g1.detectRail();//moved out of draw ino function in GameEngine
    rect(10, 240, 30, 30);
    fill(50);
    text("Add Rail", 50, 260);
    g1.hover(10, 40, 310, 340);

    //createTrain
    rect(10, 310, 30, 30);
    fill(50);
    text("Spawn Train", 50, 330);
    fill(0, 225, 225);

    //pause button
    g1.hover(1230, 1260, 10, 40);
    rect(1230, 10, 10, 30);
    rect(1250, 10, 10, 30);


    strokeWeight(1);
    g1.railCheck(g1.currentNumber);
  }
}

void mouseReleased(){
  if(state == 2){
    ok = true; 
  }
}

void mouseClicked() {
  if (state == 0) {
    if (mouseX > 525 && mouseY > 320 && mouseX < 740 && mouseY < 410) {
      state = 1;
      setup1();
    }
    if (mouseX > 475 && mouseY > 495 && mouseX < 825 && mouseY < 530) {
      state = 2;
    }
  }
  if(state == 2){
      if (mouseX > 525 && mouseY > 520 && mouseX < 740 && mouseY < 610 && ok) {
        state = 1;
        setup1();
      }
  }
  if (state == 1) {
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

    if (mouseX > 1230 && mouseX < 1260 && mouseY > 10 && mouseY < 40) {
      if (loop) {
        textSize(20);
        fill(40);
        text("PAUSED", 600, 30);
        textSize(15);
        noLoop();
      } else {
        loop();
      }
      loop = !loop;
    }
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