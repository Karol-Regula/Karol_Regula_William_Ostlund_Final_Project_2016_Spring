public class GameEngine {

  public Station[] stationList;
  public int stationSize;
  public Train[] trainList;
  public int trainSize;

  public GameEngine() {
    stationList = new Station[10];//make grow method for this
    stationSize = 0;
  }

  public void drawStations() {
    for (int i = 0; i < stationSize; i++) {//chnage this after adding grow and size
      stationList[i].paint();
    }
  }

  public void grow() {
    Station[] temp = new Station[stationList.length * 2];
    for (int i = 0; i < stationList.length; i++) {
      temp[i] = stationList[i];
    }
    stationList = temp;
  }

  public void createStation(int xcor, int ycor) {
    if (stationSize >= stationList.length) {
      grow();
    }
    Station s1  = new Station(xcor, ycor);
    stationList[stationSize] = s1;//temporary
    stationSize++;
  }
}