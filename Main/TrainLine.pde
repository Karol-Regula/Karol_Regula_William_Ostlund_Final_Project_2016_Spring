public class TrainLine {

  public Station[] stationList;
  public int stationSize;
  public Train[] trainList;
  public int trainSize;
  public Rail[] railList;
  public int railSize;
  public color whatColor;

  public TrainLine(color whatColor) {
    stationList = new Station[10];//make grow method for this
    stationSize = 0;
    railList = new Rail[10];
    railSize = 0;
    trainList = new Train[10];
    trainSize = 0;
    this.whatColor = whatColor;
  }

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









  public void addStation(int x, int y){
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
      if (t1.traveling && t1.soFar != 0) {
        //System.out.println(t1. dist);
        t1.xcor += (t1.end.xcor - t1.xcor) / (double)(t1.soFar);
        t1.ycor += (t1.end.ycor - t1.ycor) / (double)(t1.soFar);
        t1.soFar--;
        trainList[i].paint();
      } 
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
      else {  
        Station next;
        if (t1.end.identifier == stationSize - 1) {
          next = stationList[0];
        } else {
          next = stationList[t1.end.identifier + 1];
        }
        t1.start = t1.end;
        t1.end = next;
        t1.recalculate();
      }
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
    Station s1  = new Station(xcor, ycor, stationSize);
    stationList[stationSize] = s1;
    stationSize++;
  }

  public void createRail(Station start, Station end) {
    if (railSize >= railList.length) {
      growRail();
    }
    Rail r1  = new Rail(start, end);
    railList[railSize] = r1;
    railSize++;
  }

  public void createTrain() {
    if (trainSize >= trainList.length) {
      growTrain();
    }
    Train t1  = new Train(stationList[0], stationList[1]);
    trainList[trainSize] = t1;
    trainSize++;
  }

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
}