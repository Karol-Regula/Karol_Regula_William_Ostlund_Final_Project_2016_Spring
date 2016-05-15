public class Train {

  public int passengers;
  public int personLimit;
  public boolean traveling;
  public Station start;
  public Station end;
  public float xcor;
  public float ycor;
  public int dist;
  public int soFar;

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