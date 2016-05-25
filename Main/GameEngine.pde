public class GameEngine {
  public Station[] masterStationList;
  public int masterSize;
  public TrainLine[] TrainLines = new TrainLine [5];
  public int trainLineSize;
  public int size, timer;
  public int holdText;
  public String text;
  public int xText;
  public int yText;
  public TrainLine currentLine;
  public color currentColor;
  public int currentNumber;


  public GameEngine() {
    TrainLines = new TrainLine[10];
    //TrainLines[0] = new TrainLine(color( (int)(Math.random() * 255), (int)(Math.random() * 255), (int)(Math.random() * 255)));
    TrainLines[0] = new TrainLine(color(255, 0, 0));
    TrainLines[1] = new TrainLine(color(0, 255, 255));
    TrainLines[2] = new TrainLine(color(0, 255, 0));
    TrainLines[3] = new TrainLine(color(0, 0, 255));
    TrainLines[4] = new TrainLine(color(255, 255, 0));
    masterStationList = new Station[100]; //fix array resizing when this works
    size = 1;
  }


  public void spawnPassengers() {
    for (int i = 0; i < masterSize; i++) {
      if ((int)(Math.random() * 200) == 2 && masterStationList[i].Passengers.size() < 10 ) {//------------------------------ probability for passengers << change here
        Passenger p1 = new Passenger((int)(Math.random() * 2));
        masterStationList[i].Passengers.add(p1);
      }
    }
  }

  public void drawPassengers() {
    for (int i = 0; i < masterSize; i++) {
      for (int j = 0; j < masterStationList[i].Passengers.size(); j++) {
        if (masterStationList[i].shape == 0) {
          masterStationList[i].Passengers.get(j).paint((int)masterStationList[i].xcor + j * 10 + 20, (int)masterStationList[i].ycor - 4);
        }
        if (masterStationList[i].shape == 1) {
          masterStationList[i].Passengers.get(j).paint((int)masterStationList[i].xcor + j * 10 + 10, (int)masterStationList[i].ycor - 10);
        }
      }
    }
  }

  public void drawPassengersOnTrains() {
    for (int i = 0; i < trainLineSize; i++) {
      for (int j = 0; j < TrainLines[i].trainSize; j++) {
        for (int k = 0; k < TrainLines[i].trainList[j].Passengers.size(); k++) {
          if (k <= 2) {
            TrainLines[i].trainList[j].Passengers.get(k).paint((int)TrainLines[i].trainList[j].xcor + 2 + 10 * k, (int)TrainLines[i].trainList[j].ycor + 1);
          }
          if (k > 2) {
            TrainLines[i].trainList[j].Passengers.get(k).paint((int)TrainLines[i].trainList[j].xcor + 2 + 10 * (k - 3), (int)TrainLines[i].trainList[j].ycor + 8);
          }
        }
      }
    }
  }

  public void drawStations() {
    for (int i = 0; i < masterSize; i++) {//chnage this after adding grow and size
      masterStationList[i].paint();
    }
  }

  public void detectRail() {
    if (mouseClickRail) {
      fill(10);
      Operations s = new Operations();
      for (int k = 0; k < masterSize; k++) {
        if (s.dist(masterStationList[k]) < 10) {               
          masterStationList[k].selected = true;
        } else {
          masterStationList[k].selected = false;
        }
      }
      if (x!=-1) {
        this.masterStationList[x].selected = true;
      }
      if (y!=-1) {
        this.masterStationList[y].selected = true;
      }
      if (y== -1) {
        if (g1.getStation(g1.currentNumber) != -1 && g1.getStation(g1.currentNumber) != x && x!= -1 && 
          g1.masterStationList[getStation(g1.currentNumber)].connections[this.currentNumber] < 2) {
          y = g1.getStation(g1.currentNumber);
          this.masterStationList[y].selected = true;
        }
        if (g1.getStation(g1.currentNumber) != -1 && y == -1 && 
          g1.masterStationList[getStation(g1.currentNumber)].connections[this.currentNumber] < 2) {
          x = g1.getStation(g1.currentNumber);
          this.masterStationList[x].selected = true;
        }
        //System.out.println("x: " + x);
        //System.out.println("y: " + y);
        //System.out.println(g1.masterStationList[1]);
      } else {
        if (g1.currentLine.createRail(g1.masterStationList[x], g1.masterStationList[y], g1.currentColor) == -1) {
          g1.currentLine.createRail(g1.masterStationList[y], g1.masterStationList[x], g1.currentColor);
        }
        this.masterStationList[y].selected = false;
        this.masterStationList[x].selected = false;
        this.masterStationList[x].connections[this.currentNumber]++;
        this.masterStationList[y].connections[this.currentNumber]++;
        x=-1;
        y=-1;
      }
    } else {
      this.hover(10, 40, 240, 270);
    }
  }

  public void spawnStations() {//for now will add to existing trainline, but I want the stations that spawn to be unafiliated until the user connects them, we should discuss this in class
    if ((int)(Math.random() * 5000) == 1) {
      Station s1 = new Station((int)(Math.random() * 1280), (int)(Math.random() * 720), 1, (int)(Math.random() * 2));
      masterStationList[masterSize] = (s1);
      masterSize++;
      //createStation((int)(Math.random() * 1280), (int)(Math.random() * 720));
    }
  }

  public void spawnTrain() {
    if (currentLine.railSize > 0) {    
      currentLine.createTrain();
    }
  }

  //----------------------------------------------Everything below is the User Interface Stuff----------------------------------------------

  public void spawnStation(int i) { //very basic framework for the user interface, we can discuss how this will work in class
    //System.out.println(timer);
    if (size == 0) {
      //return; //I don't think this anomaly should ever occur, I think we should start off with one station, and therefore one trainline
    }
    if (mousePressed && timer >= 0) { // commented out if (i<size && i>=0 && mousePressed...
      Station s1  = new Station(Math.round(mouseX/30)*30, Math.round(mouseY/30) * 30, 0, (int)(Math.random() * 2));
      masterStationList[masterSize] = s1;
      timer = 0;
      masterSize++;
      mouseClick = false;
    }
    timer++;
  }

  public void cycleLines() {
    if (currentNumber == trainLineSize - 1) {
      currentLine = TrainLines[0];
      currentColor = currentLine.whatColor;
      currentNumber = 0;
    } else {
      currentLine = TrainLines[currentNumber + 1];
      currentColor = currentLine.whatColor;
      currentNumber++;
    }
  }


  public void addText(String s, int x, int y) {
    text = s;
    xText = x;
    yText = y;
  }

  public void printText() {
    if (holdText > 0) {
      fill(50);
      text(text, xText, yText);
      fill(0, 225, 225);
    }
    holdText--;
  }

  public int getStation(int i) {
    Operations s = new Operations();
    for (int k = 0; k < masterSize; k++) {
      if (s.dist(masterStationList[k]) < 15 && mousePressed) {               
        return k;
      }
    }
    return -1;
  }

  public void hover(int x1, int x2, int y1, int y2) {
    if (mouseX > x1 && mouseY > y1 && mouseX < x2 && mouseY < y2) {
      fill(0); //FIX COLOR LATER
    } else {
      fill(0, 225, 225);
    }
  }

  public void railCheck(int i) {
    for (int k = 0; k < TrainLines[i].railSize - 1; k++) {
      System.out.println(TrainLines[i].railList[k].end == TrainLines[i].railList[k+1].start);
    }
  }
}                         