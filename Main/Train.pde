public class Train implements Locatable {

  public int passengers;
  public int personLimit;
  public boolean traveling;
  public Station start;
  public Station end;
  public float xcor;
  public float ycor;
  public int dist;//I think we should change this to float
  public int soFar;
  public float angle;
  public int currentNumber;

  public float getXcor() {
    return this.xcor;
  }

  public float getYcor() {
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
    currentNumber = 0;
  }

  public void setAngle() {
    this.angle = atan((start.getYcor() - end.ycor)/(start.getXcor() - end.xcor));//Does not work when implemented, moved improperly, I think we should work on
  }

  public void paint() {
    //System.out.println(xcor + " " + ycor);
    //pushMatrix();
    //translate(-xcor + 10, -ycor + 5);

    //popMatrix();
    rect(xcor, ycor, 20, 10); //need to chnage facing direction later
    //rotate(angle);
    //popMatrix();
    //translate(xcor - 10, ycor - 5);
    //pushMatrix();
    //rotate(-angle);
    //popMatrix();
    //popMatrix();
    //rotate(-1*this.getAngle(start));
  }

  public void recalculate() {
    dist = (int) Math.sqrt( (start.xcor - end.xcor) * (start.xcor - end.xcor) +  (start.ycor - end.ycor) * (start.ycor - end.ycor));//calculate distance between stations
    soFar = dist / 2;
    setAngle();
    //System.out.println(angle);
  }
}