public class TrainLine { //<>// //<>// //<>// //<>// //<>//

  public Station[] stationList;
  public int stationSize;
  public Train[] trainList;
  public int trainSize;
  public Rail[] railList;
  public int railSize;
  public color whatColor;
  public boolean isLoop = true;
  public boolean loop;
  public int[] hasTypes;
  public char identifier;
  public ArrayList<Integer> typesHere; //related to stopHere, also has to do with TRANSFERRING, lists the types of stations avaliable on each trainline.

  public TrainLine(color whatColor) {
    stationList = new Station[10];//make grow method for this
    stationSize = 0;
    railList = new Rail[10];
    railSize = 0;
    trainList = new Train[10];
    trainSize = 0;
    this.whatColor = whatColor;
    loop = false;
    typesHere = new ArrayList<Integer>();
  }


  /*
  public void lineSetup() {
   for (int i = 0; i < 5; i++) {
   createStation((int)(Math.random() * 1280), (int)(Math.random() * 720));
   }
   for (int i = 0; i < stationSize - 1; i++) {
   createRail(stationList[i], stationList[i + 1]);
   }
   createRail(stationList[4], stationList[0]);
   createTrain();
   }
   */


  public boolean hasType(int i) {
    for (int k=0; k < stationSize; k++) {
      if (stationList[k].shape == i) {
        return true;
      }
    }
    return false;
  }


  public void isLoop() {
    if (railList[railSize - 1].end == railList[0].start) {
      loop = true;
    } else {
      loop = false;
    }
  }



  public void addStation(int x, int y) {
    createStation(x, y);
    //if(stationSize >= 2){
    //railList[railSize - 1] = new Rail(stationList[stationSize - 2], stationList[stationSize - 1]);
    //}
    //createRail(stationList[stationSize - 1], stationList[0]);
  }

  public void drawStations() {
    for (int i = 0; i < stationSize; i++) {//chnage this after adding grow and size
      stationList[i].paint();
    }
  }


  public void drawRails() {
    for (int i = 0; i < railSize; i++) {//chnage this after adding grow and size
      railList[i].paint();
    }
  }

  public void moveTrains() {
    for (int i = 0; i < trainSize; i++) {//chnage this after adding grow and size
      Train t1 = trainList[i];
      //System.out.println(t1.currentNumber);
      if (t1.traveling && t1.soFar >= 20) {
        //System.out.println("T: traveling");
        //System.out.println(t1. dist);
        t1.setAngle();
        t1.xcor += (t1.end.Txcor - (t1.xcor)) / (double)(t1.soFar);
        t1.ycor += (t1.end.Tycor - t1.ycor) / (double)(t1.soFar);
        t1.soFar--;
        trainList[i].paint();
      } else if (t1.traveling && t1.soFar <= 50 && t1.soFar >= 0.1) {
        // System.out.println("T: deccelarating");
        //System.out.println(t1. dist);
        t1.xcor += (t1.end.Txcor - t1.xcor) / (double)(t1.soFar)  * (0.02 * t1.soFar);
        t1.ycor += (t1.end.Tycor - t1.ycor) / (double)(t1.soFar)  * (0.02 * t1.soFar);
        t1.soFar -=  (0.004 * (50 - t1.soFar));
        //System.out.println(t1.soFar);
        trainList[i].paint();
        if (t1.soFar < 0.3) {
          t1.waiting = 140;// ======================= NOTE: for future purposes, this code executes way too may times
          t1.traveling = false;
          t1.dist = 0;
        }
      }
      //<>// //<>//

      /*
      }else if(t1.end.hasNext()){
       trainList[i].paint();
       t1.start.xcor = t1.end.xcor;
       t1.start.ycor = t1.end.ycor;
       t1.end.xcor = t1.end.next().end.getXcor();
       t1.end.ycor = t1.end.next().end.getYcor();
       t1.recalculate();
       }else {
       trainList[i].paint();
       float temp1 = t1.start.xcor;
       float temp2 = t1.start.ycor;
       t1.start.xcor = t1.end.xcor;
       t1.start.ycor = t1.end.ycor;
       t1.end.xcor = temp1;
       t1.end.ycor = temp2;
       */


      else if (t1.forward && t1.dist == 0) {  
        //System.out.println("T: recalculate 1");
        Station next;
        if (t1.currentNumber == railSize) {
          if (this.loop) {
            next = railList[0].start;
            t1.currentNumber = 0;
          } else {
            next = t1.start;
            t1.currentNumber = railSize - 1;
            t1.forward = false;
          }
        } else {
          next = railList[t1.currentNumber].end;
          t1.currentNumber++;
        }
        t1.start = t1.end;
        t1.end = next;
        t1.recalculate();
        t1.deboardExtra = true;
      } else if (t1.dist == 0) {
        Station last;
        //System.out.println("T: recalculate 2");
        if (t1.currentNumber == -1) {
          if (this.loop) { 
            last = railList[railSize - 1].end;
            t1.currentNumber = railSize - 1;
          } else {
            last = t1.end;
            t1.currentNumber = 0;
            t1.forward = true;
          }
        } else {
          last = railList[t1.currentNumber].start;
          t1.currentNumber--;
        }
        t1.start = t1.end;
        t1.end = last;
        t1.recalculate();
        t1.deboardExtra = true;
      } else if (t1.waiting > 0) {
        //System.out.println("T: waiting");
        t1.waiting--;
        if (t1.waiting == 130) {
          t1.deboardPassenger();
        }
        if (t1.waiting == 120) {
          t1.deboardPassenger();
        }
        if (t1.waiting == 110) {
          t1.deboardPassenger();
        }
        if (t1.waiting == 100) {
          t1.deboardPassenger();
        }
        if (t1.waiting == 90) {
          t1.deboardPassenger();
        }
        if (t1.waiting == 80) {
          t1.deboardPassenger();
        }
        if (t1.waiting == 70) {
          t1.boardPassenger();
        }
        if (t1.waiting == 60) {
          t1.boardPassenger();
        }
        if (t1.waiting == 50) {
          t1.boardPassenger();
        }
        if (t1.waiting == 40) {
          t1.boardPassenger();
        }
        if (t1.waiting == 30) {
          t1.boardPassenger();
        }
        if (t1.waiting == 20) {
          t1.boardPassenger();
        }
        t1.paint();
        //passengers board here
        if (t1.waiting == 0) {
          t1.traveling = true;
          //t1.soFar = 0;
          //t1.dist = 0;
        }
      }
      //System.out.println(t1.soFar);
    }
  }

  public void growStation() {
    Station[] temp = new Station[stationList.length * 2];
    for (int i = 0; i < stationList.length; i++) {
      temp[i] = stationList[i];
    }
    stationList = temp;
  }

  public void growRail() {
    Rail[] temp = new Rail[railList.length * 2];
    for (int i = 0; i < railList.length; i++) {
      temp[i] = railList[i];
    }
    railList = temp;
  }

  public void growTrain() {
    Train[] temp = new Train[trainList.length * 2];
    for (int i = 0; i < trainList.length; i++) {
      temp[i] = trainList[i];
    }
    trainList = temp;
  }

  public void createStation(int xcor, int ycor) {
    if (stationSize >= stationList.length) {
      growStation();
    }
    Station s1  = new Station(xcor, ycor, stationSize, (int)(Math.random() * 2));
    stationList[stationSize] = s1;
    stationSize++;
    mouseClickRail = false;
  }

  public int createRail(Station start, Station end, color whatColor) {
    if (railSize >= railList.length) {
      growRail();
    }
    Rail r1  = new Rail(start, end, whatColor);
    start.connectedStations.add(end);
    end.connectedStations.add(start);



    if (! start.stopHere.contains(this.identifier)) {
      start.stopHere.add(this.identifier);
    }
    if (! end.stopHere.contains(this.identifier)) {
      end.stopHere.add(this.identifier);
    }
    boolean contains = false;
    for (int i = 0; i < stationSize; i++) {
      if (stationList[i] == start) {
        contains = true;
      }
    }
    if (!contains) {
      if (stationSize >= stationList.length) {
        growStation();
      }
      stationList[stationSize] = start;
      stationSize++;
    }
    contains = false;
    for (int i = 0; i < stationSize; i++) {
      if (stationList[i] == end) {
        contains = true;
      }
    }
    if (!contains) {
      if (stationSize >= stationList.length) {
        growStation();
      }
      stationList[stationSize] = end;
      stationSize++;
    }
    if (!typesHere.contains(start.shape)) {
      typesHere.add(start.shape);
    }
    if (!typesHere.contains(end.shape)) {
      typesHere.add(end.shape);
    }



    if (railSize == 0) {
      railList[railSize] = r1;
      railSize++;
      mouseClickRail = false;
      isLoop();
    } else {
      //System.out.println("fdgvb gvrt");
      if (r1.start == railList[railSize - 1].end) {
        railList[railSize] = r1;
        railSize++;
        mouseClickRail = false;
        isLoop();
      } else if (r1.end == railList[0].start) {
        Rail[] a = new Rail[railList.length];
        a[0] = r1;
        for (int i = 0; i < railSize; i++) {
          a[i+1] = railList[i];
        }
        railSize++;
        railList = a;
        mouseClickRail = false;
        isLoop();
      } else {
        //message("Remember: All rails on a single trainline must be continuous");
        mouseClickRail = false;
        return -1;
      }
    }
    return 0;
  }

  public int removeRail(Station x, Station y) {
    for (int i = 0; i < x.connectedStations.size(); i++) {
      if (x.connectedStations.get(i) == y) {
        x.connectedStations.remove(i);
      }
    }
    for (int i = 0; i < y.connectedStations.size(); i++) {
      if (y.connectedStations.get(i) == x) {
        y.connectedStations.remove(i);
      }
    }


    for (int i = 0; i < railSize; i++) {
      if (railList[i].start == x && railList[i].end == y) {
        if (i == railSize - 1) {
          railList[railSize - 1] = null;
          railSize--;
        } else if (i==0) {
          Rail[] a = new Rail[railList.length];
          for (int k = 1; k < railSize; k++) {
            a[k-1] = railList[k];
          }
          for (Train t1 : trainList) {
            if (t1!= null && t1.currentNumber > i) {
              t1.currentNumber--;
            }
          }
          railSize--;
          railList = a;
        } else if (loop) {
          Rail[] a = new Rail[railList.length];
          for (int k = i+1; k < railSize+i; k++) {
            if (k<railSize) {
              a[k-i-1] = railList[k];
            } else {
              a[k - i - 1] = railList[k%railSize];
            }
          }
          for (Train t1 : trainList) {
            if (t1!= null) {
              if (t1.currentNumber > i) {
                t1.currentNumber -= (i);
                if (t1.forward) {
                  t1.currentNumber--;
                } else {
                  t1.currentNumber++;
                }
                t1.forward = !t1.forward;
                t1.recalculate();
              } else {
                t1.currentNumber = railSize - t1.currentNumber - 1; 
                t1.recalculate();
              }
            }
          }
          railSize--;
          railList = a;
        }
        removingRail = false; 
        loop = false;
        return 0;
      }
    }
    return -1;
  }

  public void createTrain() {
    if (trainSize >= trainList.length) {
      growTrain();
    }
    Train t1  = new Train(railList[0].start, railList[0].end, whatColor);
    t1.identifier = this.identifier;
    t1.trainLine = this;
    trainList[trainSize] = t1;
    trainSize++;
  }

  /*
  public void addStation(int i, Station g) {
   int x = stationList.length;
   if (stationList.length == stationSize) {
   x*=2;
   }
   int y = railList.length;
   if (stationList.length == railSize) {
   y*=2;
   }
   Station[] a = new Station[x];
   Rail[] b = new Rail[y];
   for (int k = 0; k < i; k++) {
   a[k] = stationList[k];
   }
   stationList[i] = g;
   for (int k = i+1; k<= x; k++) {
   a[k] = stationList[k-1];
   }
   for (int k = 1; k<y; k++) {
   b[k-1] = new Rail(a[k-1], a[k]);
   }
   b[y] = new Rail(a[y-1], a[0]);
   stationSize++;
   railSize++;
   }
   */
}