public class GameEngine {
  public Station[] masterStationList;
  public int masterSize;
  public TrainLine[] TrainLines = new TrainLine [100];
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
    TrainLines[0] = new TrainLine(color( (int)(Math.random() * 255), (int)(Math.random() * 255), (int)(Math.random() * 255)));
    masterStationList = new Station[100]; //fix array resizing when this works
    size = 1;
  }


  public void drawStations() {
    for (int i = 0; i < masterSize; i++) {//chnage this after adding grow and size
      masterStationList[i].paint();
    }
  }

  public void spawnStations() {//for now will add to existing trainline, but I want the stations that spawn to be unafiliated until the user connects them, we should discuss this in class
    if ((int)(Math.random() * 1000) == 1) {
      Station s1 = new Station((int)(Math.random() * 1280), (int)(Math.random() * 720), 1);
      masterStationList[masterSize] = (s1);
      masterSize++;
      //createStation((int)(Math.random() * 1280), (int)(Math.random() * 720));
    }
  }

  //----------------------------------------------Everything below is the User Interface Stuff----------------------------------------------

  public void spawnStation(int i) { //very basic framework for the user interface, we can discuss how this will work in class
    System.out.println(timer);
    if (size == 0) {
      return; //I don't think this anomaly should ever occur, I think we should start off with one station, and therefore one trainline
    }
    if (i<size && i>=0 && mousePressed && timer >= 0) {
      TrainLines[i].addStation(Math.round(mouseX/30)*30, Math.round(mouseY/30) * 30);
      timer = 0;
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
    int ans = 0;
    for (int k = 0; k < TrainLines[i].stationSize; k++) {
      if (s.dist(TrainLines[i].stationList[k]) < 10) {               
        return k;
      }
    }
    return -1;
  }
}                         