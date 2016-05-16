public class Train implements Locatable{

  public int passengers;
  public int personLimit;
  public boolean traveling;
  public Station start;
  public Station end;
  public float xcor;
  public float ycor;
  public int dist;//I think we should change this to float
  public int soFar;
  
  public float getXcor(){
     return this.xcor; 
  }
  
  public float getYcor(){
     return this.ycor; 
  }

  public Train(Station start, Station end) {
    this.start = start;
    this.end = end;
    xcor = start.xcor;
    ycor = start.ycor;
    traveling  = true; //true for now, determined by consrtuctor later
    dist = (int) Math.sqrt( (start.xcor - end.xcor) * (start.xcor - end.xcor) +  (start.ycor - end.ycor) * (start.ycor - end.ycor));//calculate distance between stations
    soFar = dist / 2;
  }

  public void paint() {
    System.out.println(xcor + " " + ycor);
    rect(xcor, ycor, 10, 20); //need to chnage facing direction later
  }

  public void recalculate() {
    dist = (int) Math.sqrt( (start.xcor - end.xcor) * (start.xcor - end.xcor) +  (start.ycor - end.ycor) * (start.ycor - end.ycor));//calculate distance between stations
    soFar = dist / 2;
  }
}