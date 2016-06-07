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
  public float soFarOriginal;
  public float angle;
  public int currentNumber;
  public color whatColor;
  public int waiting;
  public int capacity;
  public ArrayList<Passenger> Passengers;
  public boolean forward;
  public char identifier;
  public TrainLine trainLine;
  public boolean deboardExtra;
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
    soFarOriginal = soFar;
    currentNumber = 0;
    this.whatColor = whatColor;
    Passengers = new ArrayList<Passenger>();
    capacity = 0;
    forward = true;
  }

  public void boardPassenger() {
    if (capacity <= 5 && start.Passengers.size() > 0) {
      boolean board = false;
      int whichTested = 0;
      while (whichTested < start.Passengers.size() && board == false) {
        if (start.Passengers.get(whichTested).route != null) {
          if (start.Passengers.get(whichTested).route.size() > 0 && start.Passengers.get(whichTested).route.get(0) == end) {
            board = true;
          } else if (trainLine.typesHere.contains(start.Passengers.get(whichTested).shape) && trainLine.loop) {
            board = true;
          }else if (Arrays.asList(trainLine.stationList).contains(start.Passengers.get(whichTested).route.get(0)) && trainLine.loop){
            board = true;
          } else {
            whichTested++;
          }
        } else {
          whichTested++;
        }
      }
      if (whichTested < start.Passengers.size() && (board == true)) {
        Passengers.add(start.Passengers.remove(whichTested));
        capacity++;
        //System.out.println("board");
      }
    }
  }



  public void deboardPassenger() {
    if (deboardExtra) {
      deboardExtra = false;
      //System.out.println("DeboardExtra");
      for (int j = 0; j < Passengers.size(); j++) {
        Passengers.get(j).currentStation = start;
        Passengers.get(j).processed = false;
        if (Passengers.get(j).route.size() > 0) {
          Passengers.get(j).route.remove(0);
        }
      }
    }
    //System.out.println("deboard");
    //boolean removed = false;
    int i = 0;
    //cutting off a station of passenger's route 

    //moving to next passenger to be processed
    while (i < Passengers.size() && Passengers.get(i).processed) {
      i++;
    }
    if (i < Passengers.size()) {
      //if passenger needs to get off and his/her journey is finished
      if (Passengers.get(i).shape == start.shape) {
        //System.out.println("deboarding passenger completely");
        Passengers.remove(i);
        capacity--;
        g1.highScore++;

        //if passenger needs to stay on train
      } else if (Passengers.get(i).route.size() > 0 && Passengers.get(i).route.get(0) == end) {
        //System.out.println("passenger staying on btrain"); 
        Passengers.get(i).processed = true;

        //if passenger needs to get off and wait for another train
      } else if (Passengers.get(i).route.size() > 0 && Passengers.get(i).shape != start.shape && Passengers.get(i).route.get(0) != end) {
        //System.out.println("deboarding and waiting passenger");
        start.Passengers.add(0, Passengers.get(i));
        Passengers.remove(i);
        capacity--;
      }
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
    soFarOriginal = soFar;
    setAngle();
    //System.out.println(angle);
  }
}