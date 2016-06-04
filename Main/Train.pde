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
  public char identifier;
  public TrainLine trainLine;
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

  public void boardPassenger() {
    if (capacity <= 5 && end.Passengers.size() > 0) {
      boolean board = false;
      int whichTested = 0;
      while (whichTested < start.Passengers.size() && board == false) {
        if (start.Passengers.get(whichTested).route.get(0) == end) {
          board = true;
        } else if (trainLine.typesHere.contains(start.Passengers.get(whichTested).shape)) {
          board = true;
        } else {
          whichTested++;
        }
      }
      if (whichTested < start.Passengers.size() && (board == true)) {
        Passengers.add(start.Passengers.remove(whichTested));
        capacity++;
        System.out.println("board");
      }
    }
  }

  public void deboardPassenger() {
    System.out.println("deboard");
    boolean removed = false;
    for (int i = 0; i < capacity; i++) {
              Passengers.get(i).route.remove(0);
      if (Passengers.get(i).route.size() == 0 && Passengers.get(i).shape == start.shape) {
        System.out.println("debaording passenger completely");
        Passengers.remove(i);
        capacity--;
        i--;
        g1.highScore++;
      } else {
        if (removed == false) {
          if (Passengers.get(i).shape != start.shape && Passengers.get(i).route.get(0) != end) {
            start.Passengers.add(0, Passengers.get(i));
            Passengers.remove(i);
            removed = true;
            i--;
            capacity--;
          }
        }
        //if(!this.trainLine.hasType(Passengers.get(i).shape)){
        //for(int k = 0; k < this.end.connections.length; k++){
        // if(this.end.connects.get(k) != null && this.end.connects.get(k).hasType(Passengers.get(i).shape)){
        //  this.end.Passengers.add(Passengers.get(i));
        //this.Passengers.remove(i);
        //}
        // }
        //}
      }
    }
  }

  public void setAngle() {
    this.angle = atan((start.Tycor - end.Tycor)/(start.Txcor - end.Txcor));//Does not work when implemented, moved improperly, I think we should work on
  }

  public void sha() {
    float ang = atan(0.5);
    float dist = (float)Math.sqrt(15*15 + 7.5 * 7.5);
    s = createShape();
    s.beginShape();
    s.vertex((float)(xcor + dist * Math.cos(angle + ang) + 7.5), (float)(ycor + dist*Math.sin(angle+ang)) + 7.5);
    s.vertex((float)(xcor + dist * Math.cos(angle - ang) + 7.5), (float)(ycor + dist*Math.sin(angle-ang)) + 7.5);
    s.vertex((float)(xcor - dist * Math.cos(angle + ang) + 7.5), (float)(ycor - dist*Math.sin(angle+ang)) + 7.5);
    s.vertex((float)(xcor - dist * Math.cos(angle - ang) + 7.5), (float)(ycor - dist*Math.sin(angle-ang)) + 7.5);
    s.vertex((float)(xcor + dist * Math.cos(angle + ang) + 7.5), (float)(ycor + dist*Math.sin(angle+ang)) + 7.5);
    s.endShape();
  }

  public void paint() {
    //System.out.println(xcor + " " + ycor);
    //pushMatrix();
    //translate(-xcor + 10, -ycor + 5);
    //rotate(-angle);
    //rect(xcor, ycor, 30, 15);
    //popMatrix();
    fill(whatColor);
    this.sha();//need to chnage facing direction later
    shape(s);
    fill(50);
    //pushMatrix();
    //rotate(angle);
    //popMatrix();

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