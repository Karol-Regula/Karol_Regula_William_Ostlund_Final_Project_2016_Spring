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
  public int highScore;


  public GameEngine() {
    TrainLines = new TrainLine[10];
    //TrainLines[0] = new TrainLine(color( (int)(Math.random() * 255), (int)(Math.random() * 255), (int)(Math.random() * 255)));
    TrainLines[0] = new TrainLine(color(255, 0, 0));
    TrainLines[0].identifier = 'r';
    TrainLines[1] = new TrainLine(color(0, 255, 255));
    TrainLines[1].identifier = 'c';
    TrainLines[2] = new TrainLine(color(0, 255, 0));
    TrainLines[2].identifier = 'g';
    TrainLines[3] = new TrainLine(color(0, 0, 255));
    TrainLines[3].identifier = 'b';
    TrainLines[4] = new TrainLine(color(255, 255, 0));
    TrainLines[4].identifier = 'y';
    masterStationList = new Station[10000]; //fix array resizing when this works
    size = 1;
    highScore = 0;
  }

  public void drawExtra() {
    fill(0);
    boolean drawStopHere = true;
    if (drawStopHere) {
      for (int i = 0; i < masterSize; i++) {
        for (int j = 0; j < masterStationList[i].stopHere.size(); j++) {
          //System.out.println("DRAWSTOPHERE");
          text(masterStationList[i].stopHere.get(j), masterStationList[i].xcor + j * 15, masterStationList[i].ycor - 20);
          text(masterStationList[i].toString(), masterStationList[i].xcor, masterStationList[i].ycor - 30);
        }
      }
    }
  }


  public void drawDuplicateRails() {
    int totalRails = 0; 
    for (int i = 0; i < 5; i++) {
      totalRails += TrainLines[i].railSize;
    }
    Rail[] masterRailList = new Rail[totalRails]; 
    int index = 0; 
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < TrainLines[i].railSize; j++) {
        masterRailList[index] = TrainLines[i].railList[j]; 
        index++;
      }
    }
    //at this point all existing rails are in one big array
    ArrayList<ArrayList<Rail>> duplicateRailGroups = new ArrayList<ArrayList<Rail>>(); // groups of rails that run between the same stations 
    for (int i = 0; i < masterRailList.length; i++) {
      ArrayList<Rail> current = new ArrayList<Rail>(); 
      current.add(masterRailList[i]); 
      for (int j = 0; j < masterRailList.length - 1; j++) {
        if (j != i) {
          /*
          for (int d = 0; d < masterRailList.length; d++){
           System.out.println(masterRailList[d].start);
           System.out.println(masterRailList[d].end);
           }
           System.out.println(masterRailList[i].start);
           System.out.println(masterRailList[i].end);
           System.out.println(j);
           System.out.println(masterRailList.length);
           System.out.println(masterRailList[j]);
           System.out.println(masterRailList[j].end);
           */
          if (masterRailList[i].start == masterRailList[j].start && masterRailList[i].end == masterRailList[j].end) {
            current.add(masterRailList[j]);
          }
        }
      }
      if (current.size() > 1) {
        duplicateRailGroups.add(current);
      }
    }
    //System.out.println("duplicateRailGroups.size() = " + duplicateRailGroups.size()); 
    //all duplicate Rails are now groups in an ArrayList of ArrayLists
    for (int i = 0; i < duplicateRailGroups.size(); i++) {
      if (duplicateRailGroups.get(i).size() == 2) {
        //System.out.println("Repeating rails: 2"); 

        //the most important part
        float xOff = abs(duplicateRailGroups.get(i).get(0).start.xcor - duplicateRailGroups.get(i).get(0).end.xcor); //difference in x between stations
        float yOff = abs(duplicateRailGroups.get(i).get(0).start.ycor - duplicateRailGroups.get(i).get(0).end.ycor); //difference in y between stations
        float angle = atan(yOff / xOff); 
        //System.out.println(angle); 
        float ratio = xOff /(xOff + yOff); 
        float extra = (0.8 * (1 - abs((1 - (ratio * 2))))); // this magic is meant to fix diagonal lines
        //System.out.println(ratio); 
        boolean specialCase =  duplicateRailGroups.get(i).get(0).sXcor > duplicateRailGroups.get(i).get(1).sXcor && duplicateRailGroups.get(i).get(0).sYcor < duplicateRailGroups.get(i).get(1).sYcor; 


        if (true) {
          duplicateRailGroups.get(i).get(0).sXcor = duplicateRailGroups.get(i).get(0).start.xcor + (2 * (1 - ratio)) + extra; 
          duplicateRailGroups.get(i).get(0).sYcor = duplicateRailGroups.get(i).get(0).start.ycor - (2 * (ratio)) - extra; 
          duplicateRailGroups.get(i).get(0).eXcor = duplicateRailGroups.get(i).get(0).end.xcor + (2 * (1 - ratio)) + extra; 
          duplicateRailGroups.get(i).get(0).eYcor = duplicateRailGroups.get(i).get(0).end.ycor - (2 * (ratio)) - extra; 
          duplicateRailGroups.get(i).get(0).paintAlternate = true; 
          duplicateRailGroups.get(i).get(0).paint(); //painting the rail using the special offset coordinates
          //
          duplicateRailGroups.get(i).get(1).sXcor = duplicateRailGroups.get(i).get(0).start.xcor - (2 * (1 - ratio)) - extra; 
          duplicateRailGroups.get(i).get(1).sYcor = duplicateRailGroups.get(i).get(0).start.ycor + (2 * (ratio)) + extra; 
          duplicateRailGroups.get(i).get(1).eXcor = duplicateRailGroups.get(i).get(0).end.xcor - (2 * (1 - ratio)) - extra; 
          duplicateRailGroups.get(i).get(1).eYcor = duplicateRailGroups.get(i).get(0).end.ycor + (2 * (ratio)) + extra; 
          duplicateRailGroups.get(i).get(1).paint(); //painting the rail using the special offset coordinates
          duplicateRailGroups.get(i).get(1).paintAlternate = true;
        }
        /*
        else{
         duplicateRailGroups.get(i).get(0).sXcor = duplicateRailGroups.get(i).get(0).start.xcor + (2 * (ratio)) + extra * 4;
         duplicateRailGroups.get(i).get(0).sYcor = duplicateRailGroups.get(i).get(0).start.ycor + (2 * (1 - ratio)) + extra * 4;
         duplicateRailGroups.get(i).get(0).eXcor = duplicateRailGroups.get(i).get(0).end.xcor + (2 * (ratio)) + extra * 4;
         duplicateRailGroups.get(i).get(0).eYcor = duplicateRailGroups.get(i).get(0).end.ycor + (2 * (1 - ratio)) + extra * 4;
         duplicateRailGroups.get(i).get(0).paintAlternate = true;
         duplicateRailGroups.get(i).get(0).paint(); //painting the rail using the special offset coordinates
         //
         duplicateRailGroups.get(i).get(1).sXcor = duplicateRailGroups.get(i).get(0).start.xcor - (2 * (ratio)) - extra * 4;
         duplicateRailGroups.get(i).get(1).sYcor = duplicateRailGroups.get(i).get(0).start.ycor - (2 * (1 - ratio)) - extra * 4;
         duplicateRailGroups.get(i).get(1).eXcor = duplicateRailGroups.get(i).get(0).end.xcor - (2 * (ratio)) - extra *  4;
         duplicateRailGroups.get(i).get(1).eYcor = duplicateRailGroups.get(i).get(0).end.ycor - (2 * (1 - ratio)) - extra * 4;
         duplicateRailGroups.get(i).get(1).paint(); //painting the rail using the special offset coordinates
         duplicateRailGroups.get(i).get(1).paintAlternate = true;
         }
         */
      }
    }
  }



  public void spawnPassengers() {
    for (int i = 0; i < masterSize; i++) {
      if ((int)(Math.random() * 600) == 2 && masterStationList[i].Passengers.size() < 10 ) {//------------------------------ probability for passengers << change here
        Passenger p1 = new Passenger((int)(Math.random() * 3)); 
        if (p1.shape != masterStationList[i].shape) {
          masterStationList[i].Passengers.add(p1);
          p1.currentStation = masterStationList[i];
        }
      }
    }
  }

  public void drawPassengers() {
    for (int i = 0; i < masterSize; i++) {
      for (int j = 0; j < masterStationList[i].Passengers.size(); j++) {

        if (masterStationList[i].shape == 0) {
          masterStationList[i].Passengers.get(j).paint((int)masterStationList[i].xcor + j * 10 + 24, (int)masterStationList[i].ycor - 8);
        }
        if (masterStationList[i].shape == 1) {
          masterStationList[i].Passengers.get(j).paint((int)masterStationList[i].xcor + j * 10 + 11, (int)masterStationList[i].ycor - 16);
        }
        if (masterStationList[i].shape == 2) {
          masterStationList[i].Passengers.get(j).paint((int)masterStationList[i].xcor + j * 10 + 10, (int)masterStationList[i].ycor - 20);
        }
      }
    }
  }

  public void drawPassengerRoutes() {
    for (int i = 0; i < masterSize; i++) {
      for (int j = 0; j < masterStationList[i].Passengers.size(); j++) {
        masterStationList[i].Passengers.get(j).solve(masterStationList[i].Passengers.get(j).currentStation);
        //System.out.println("--------------------------------------------");
        //System.out.println("Passenger number " + j + " in Station " + masterStationList[i].toString() + ".");
        if (masterStationList[i].Passengers.get(j).route != null) {
          //System.out.println("ROUTE");
          for (int k = 0; k < masterStationList[i].Passengers.get(j).route.size(); k++) {
            //System.out.println(masterStationList[i].Passengers.get(j).route.get(k));
          }
        } else {
          //System.out.println("Route is null.");
        }
        //System.out.println("----------------------------------------------------------------------------");
      }
    }
  }

  public void drawPassengersOnTrains() {
    for (int i = 0; i < trainLineSize; i++) {
      for (int j = 0; j < TrainLines[i].trainSize; j++) {
        for (int k = 0; k < TrainLines[i].trainList[j].Passengers.size(); k++) {
          if (k <= 2) {
            //if(k == 0){
            /*TrainLines[i].trainList[j].Passengers.get(k).paint((int)(TrainLines[i].trainList[j].xcor + 2 + 5 * 
             cos(TrainLines[i].trainList[j].angle)), 
             (int)(TrainLines[i].trainList[j].ycor + 10*sin(TrainLines[i].trainList[j].angle)));*/
            TrainLines[i].trainList[j].Passengers.get(k).paint((int)TrainLines[i].trainList[j].xcor + 2 + 10 * (k), (int)TrainLines[i].trainList[j].ycor + 1 + 10);
            //}
          }
          if (k > 2) {
            TrainLines[i].trainList[j].Passengers.get(k).paint((int)TrainLines[i].trainList[j].xcor + 2 + 10 * (k - 3), (int)TrainLines[i].trainList[j].ycor + 1);
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
        if (s.dist(masterStationList[k]) < 20) {               
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
        for (int i = 0; i < this.currentLine.railSize; i++) {
          if ((this.currentLine.railList[i].end == this.masterStationList[x] && this.currentLine.railList[i].start == this.masterStationList[y]) ||
            (this.currentLine.railList[i].end == this.masterStationList[y] && this.currentLine.railList[i].start == this.masterStationList[x])) {
            this.masterStationList[y].selected = false; 
            this.masterStationList[x].selected = false;  
            x=-1; 
            y=-1;
            return;
          }
        }
        if (g1.currentLine.createRail(g1.masterStationList[x], g1.masterStationList[y], g1.currentColor) == -1) {
          g1.currentLine.createRail(g1.masterStationList[y], g1.masterStationList[x], g1.currentColor);
        }

        this.masterStationList[y].selected = false; 
        this.masterStationList[x].selected = false;
        if (this.masterStationList[x].connections[this.currentNumber] == 0) {
          this.masterStationList[x].connects.add(this.TrainLines[g1.currentNumber]);
        }
        if (this.masterStationList[y].connections[this.currentNumber] == 0) {
          this.masterStationList[y].connects.add(this.TrainLines[g1.currentNumber]);
        }
        this.masterStationList[x].connections[this.currentNumber]++; 
        this.masterStationList[y].connections[this.currentNumber]++; 
        //this.TrainLines[this.currentNumber].stationSize++;
        x=-1; 
        y=-1;
      }
    } else {
      this.hover(10, 40, 240, 270);
    }
    drawPassengerRoutes();
    drawPassengersOnTrains();
  }

  public void findRail() {
    if (removingRail) {
      fill(10); 
      Operations s = new Operations(); 
      for (int k = 0; k < masterSize; k++) {
        if (s.dist(masterStationList[k]) < 20) {               
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
          g1.masterStationList[getStation(g1.currentNumber)].connections[this.currentNumber] > 0) {
          y = g1.getStation(g1.currentNumber); 
          this.masterStationList[y].selected = true;
        }
        if (g1.getStation(g1.currentNumber) != -1 && y == -1 && 
          g1.masterStationList[getStation(g1.currentNumber)].connections[this.currentNumber] > 0) {
          x = g1.getStation(g1.currentNumber); 
          this.masterStationList[x].selected = true;
        }
        //System.out.println("x: " + x);
        //System.out.println("y: " + y);
        //System.out.println(g1.masterStationList[1]);
      } else {
        if (g1.currentLine.removeRail(g1.masterStationList[x], g1.masterStationList[y]) == -1) {
          g1.currentLine.removeRail(g1.masterStationList[y], g1.masterStationList[x]);
        }
        this.masterStationList[y].selected = false; 
        this.masterStationList[x].selected = false; 
        if (this.masterStationList[y].connections[this.currentNumber] == 1) {
          for (int k = 0; k < this.masterStationList[y].connects.size(); k++) {
            if ( this.masterStationList[y].connects.get(k) == this.TrainLines[g1.currentNumber]) {
              this.masterStationList[y].connects.remove(k);
            }
          }
        }
        if (this.masterStationList[x].connections[this.currentNumber] == 1) {
          for (int k = 0; k < this.masterStationList[x].connects.size(); k++) {
            if ( this.masterStationList[x].connects.get(k) == this.TrainLines[g1.currentNumber]) {
              this.masterStationList[x].connects.remove(k);
            }
          }
        }
        this.masterStationList[x].connections[this.currentNumber]--; 
        this.masterStationList[y].connections[this.currentNumber]--; 
        x=-1; 
        y=-1;
      }
    } else {
      this.hover(10, 40, 170, 200);
    }
    drawPassengerRoutes();
    drawPassengersOnTrains();
  }

  public void spawnStations() {//for now will add to existing trainline, but I want the stations that spawn to be unafiliated until the user connects them, we should discuss this in class
    Operations o1= new Operations(); 
    if ((int)(Math.random() * 1000) == 0) {
      boolean good = false; 
      int counter = 0; 
      while (!good && counter < 100) {
        good = true; 
        Station s1 = new Station((int)(Math.random() * 1280), (int)(Math.random() * 720), 1, (int)(Math.random() * 3)); 
        if (masterSize > 0) {
          for (int i = 0; i < masterSize; i++) {
            if (o1.dist(s1, masterStationList[i]) < 120 || (s1.xcor < 250 && s1.ycor < 500) || s1.xcor > 1180 || s1.ycor > 670 || s1.ycor < 40 || s1.xcor < 40) {
              good = false;
            }
          }
        }
        if (good) {
          masterStationList[masterSize] = (s1); 
          masterSize++;
        }
        counter++;
      }
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
      if (s.dist(masterStationList[k]) < 20 && mousePressed) {               
        return k;
      }
    }
    return -1;
  }

  public void hover(int x1, int x2, int y1, int y2) {
    if (mouseX > x1 && mouseY > y1 && mouseX < x2 && mouseY < y2) {
      if (mouseX > 10 && mouseX < 40 && mouseY > 310 && mouseY < 340) {
        fill(currentLine.whatColor);
      } else {
        fill(50, 23, 232); //FIX COLOR LATER
      }
    } else {
      fill(0, 225, 225);
    }
  }

  public void railCheck(int i) {
    for (int k = 0; k < TrainLines[i].railSize - 1; k++) {
      //System.out.println(TrainLines[i].railList[k].end == TrainLines[i].railList[k+1].start);
    }
  }
}                         