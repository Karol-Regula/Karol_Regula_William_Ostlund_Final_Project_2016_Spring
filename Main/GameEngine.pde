public class GameEngine {

  public Station[] stationList;
  public int stationSize;
  public Train[] trainList;
  public int trainSize;
  public Rail[] railList;
  public int railSize;

  public GameEngine() {
    stationList = new Station[10];//make grow method for this
    stationSize = 0;
    railList = new Rail[10];
    railSize = 0;
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

  public void createStation(int xcor, int ycor) {
    if (stationSize >= stationList.length) {
      growStation();
    }
    Station s1  = new Station(xcor, ycor);
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
}