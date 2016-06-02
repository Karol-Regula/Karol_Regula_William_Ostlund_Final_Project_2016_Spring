public class Passenger{
  
  public int shape;
  public char targetTrainLine;
  public Station targetStation; //only used if the Passenger is on the wrong TrainLine and needs to get off at a SPECIFIC station to transfer to another TrainLine
  public Station currentStation;
  
  public Passenger(int shape){
    this.shape = shape;
    
  }
  
  public void paint(int xcor, int ycor){
    if (shape == 0){
      fill(50);
      rect(xcor, ycor, 6, 6);
    }
    if (shape == 1){
      fill(50);
      ellipse(xcor + 3, ycor + 3, 6, 6);
    }
    if (shape == 2){
      fill(50);
      triangle(xcor + 3, ycor, xcor, ycor + 6, xcor + 6, ycor + 6);
    }
  }
  
  public void calculatePath(){//needs to work dynamically all the time as the user will keep shifting connections
  //I'm starting to worry that if we run all of our for loops on a large train system at the same time this game will explode.
  }
  
  
}