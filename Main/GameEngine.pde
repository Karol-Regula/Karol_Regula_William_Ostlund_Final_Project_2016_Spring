public class GameEngine {
  public Station[] masterStationList;
  
  public TrainLine[] TrainLines;
  public int size, timer;
  
  public GameEngine(){
    TrainLines = new TrainLine[10];
    TrainLines[0] = new TrainLine();
    size = 1;
  }

  public void spawnStations() {//for now will add to existing trainline, but I want the stations that spawn to be unafiliated until the user connects them, we should discuss this in class
    if ((int)(Math.random() * 1000) == 1) {
      Station s1 = new Station(1,1,1);
      //createStation((int)(Math.random() * 1280), (int)(Math.random() * 720));
    }
  }
  
  //----------------------------------------------Everything below is the User Interface Stuff----------------------------------------------

  public void spawnStation(int i){
     System.out.println(timer);
     if(size == 0){
       return; //I don't think this anomaly should ever occur, I think we should start off with one station, and therefore one trainline
     }
     if (i<size && i>=0 && mousePressed && timer >= 25){
       TrainLines[i].addStation(mouseX,mouseY);
       timer = 0;
     }
     timer++;
  }

}