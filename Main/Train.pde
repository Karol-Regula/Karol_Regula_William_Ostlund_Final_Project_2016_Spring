public class Train implements Locatable {
  
  PShape s;
  public int passengers;
  public int personLimit;
  public boolean traveling;
  public Station start;
  public Station end;
  public float xcor;
  public float ycor;
  public int dist;//I think we should change this to float
  public float soFar;
  public float angle;
  public int currentNumber;
  public color whatColor;
  public int waiting;
  public int capacity;
  public ArrayList<Passenger> Passengers;
  public boolean forward;
  public float getXcor() {
    return this.xcor;
  }

  public float getYcor() {
    return this.ycor;
  }

  public Train(Station start, Station end, color whatColor) {
    this.start = start;
    this.end = end;
    xcor = start.Txcor;
    ycor = start.Tycor;
    traveling  = true; //true for now, determined by consrtuctor later
    dist = (int) Math.sqrt( (start.Txcor - end.Txcor) * (start.Txcor - end.Txcor) +  (start.Tycor - end.Tycor) * (start.Tycor - end.Tycor));//calculate distance between stations
    soFar = dist / 2;
    currentNumber = 0;
    this.whatColor = whatColor;
    Passengers = new ArrayList<Passenger>();
    capacity = 0;
    forward = true;
  }
  
  public void boardPassengers(){
    while (capacity <= 5 && end.Passengers.size() > 0){
      Passengers.add(end.Passengers.remove(0));
      capacity++;
    }
  }
  
  public void deboardPassengers(){
    System.out.println("deboard");
    for (int i = 0; i < capacity; i++){
      if (Passengers.get(i).shape == end.shape){
        Passengers.remove(i);
        i--;
        capacity--;
      }
    }
  }

  public void setAngle() {
    this.angle = atan((start.getYcor() - end.ycor)/(start.getXcor() - end.xcor));//Does not work when implemented, moved improperly, I think we should work on
  }
  
  public void sha(){
    float ang = atan(0.5);
    float dist = (float)Math.sqrt(15*15 + 7.5 * 7.5);
     s = createShape();
     s.beginShape();
     s.vertex((float)(xcor + dist * Math.cos(angle + ang)), (float)(ycor + dist*Math.sin(angle+ang)) + 7.5);
     s.vertex((float)(xcor + dist * Math.cos(angle - ang)), (float)(ycor + dist*Math.sin(angle-ang)) + 7.5);
     s.vertex((float)(xcor - dist * Math.cos(angle + ang)), (float)(ycor - dist*Math.sin(angle+ang)) + 7.5);
     s.vertex((float)(xcor - dist * Math.cos(angle - ang)), (float)(ycor - dist*Math.sin(angle-ang)) + 7.5);
     s.vertex((float)(xcor + dist * Math.cos(angle + ang)), (float)(ycor + dist*Math.sin(angle+ang)) + 7.5);
     s.endShape();
  }

  public void paint() {
    //System.out.println(xcor + " " + ycor);
    //pushMatrix();
    //translate(-xcor + 10, -ycor + 5);

    //popMatrix();
    fill(whatColor);
    this.sha();//need to chnage facing direction later
    shape(s);
    fill(50);
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
    dist = (int) Math.sqrt( (start.Txcor - end.Txcor) * (start.Txcor - end.Txcor) +  (start.Tycor - end.Tycor) * (start.Tycor - end.Tycor));//calculate distance between stations
    soFar = dist / 2;
    setAngle();
    //System.out.println(angle);
  }
}