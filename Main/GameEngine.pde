public class GameEngine {
  public Station[] masterStationList;

  public TrainLine[] TrainLines;


  public void spawnStations() {//for now will add to existing trainline, but I want the stations that spawn to be unafiliated until the user connects them, we should discuss this in class
    if ((int)(Math.random() * 1000) == 1) {
      Station s1 = new Station(1,1,1);
      //createStation((int)(Math.random() * 1280), (int)(Math.random() * 720));
    }
  }
}