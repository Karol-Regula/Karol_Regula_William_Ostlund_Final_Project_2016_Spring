public class Station implements Locatable {

  public PShape avatar;
  public float xcor;
  public float ycor;
  public float Txcor;
  public float Tycor;
  public int shape;//will be used in paint()
  public int personLimit;
  private boolean hasNext;
  private boolean hasLast;
  private int identifier;
  public ArrayList<Passenger> Passengers;
  public boolean selected;
  public int[] connections;
  public ArrayList <Station> connectedStations;
  public ArrayList<TrainLine> connects;
  public ArrayList<Character> stopHere; //FOR TRANSFERRING, contains all the trainlines that connect to this station 
  public int tick;
  public boolean blink;
  public int seconds;
  public boolean loss;

  public float getXcor() {
    return this.xcor;
  }

  public float getYcor() {
    return this.ycor;
  }

  public Station(int Xcor, int Ycor, int identifier, int shape) {
    xcor = Xcor;
    ycor = Ycor;
    this.identifier = identifier;
    selected = false;
    connections = new int[5];
    this.shape = shape;
    if (shape == 2) {
      Txcor = xcor;
      Tycor = ycor - 8;
    } else if (shape == 1) {
      Txcor = xcor - 7.5;
      Tycor = ycor - 7.5;
    } else {
      Txcor = xcor;
      Tycor = ycor;
      blink = true;
    }
    connects = new ArrayList<TrainLine>();
    Passengers = new ArrayList<Passenger>();
    stopHere = new ArrayList<Character>(); //FOR TRANSFERRING, contains all the trainlines that connect to this station
    connectedStations  = new ArrayList<Station>();
    tick = 0;
    seconds = 40;
    loss = false;
  }

  public void advanceTicks() {
    System.out.println(tick);
    if (Passengers.size() > 8) {
      tick++;
      if (tick % 30 == 0) {
        blink = !blink;
      }
      if (tick % 60 == 0) {
        seconds--;
      }
      if (seconds == 0) {
        loss = true;
      }
      fill(color(255, 142, 28));

      if (seconds > 9) {
        if (shape == 0) {
          text (seconds, xcor - 2, ycor + 35);
        }
        if (shape == 1) {
          text (seconds, xcor - 12, ycor + 24);
        }
        if (shape == 2) {
          text (seconds, xcor - 9, ycor + 17);
        }
      } else {
        if (shape == 0) {
          text (seconds, xcor - 2 + 5, ycor + 35);
        }
        if (shape == 1) {
          text (seconds, xcor - 12 + 5, ycor + 24);
        }
        if (shape == 2) {
          text (seconds, xcor - 9 + 5, ycor + 17);
        }
      }
    } else {
      seconds = 40;
      tick = 0;
    }
  }

  public void reloadStopHere() {
    for (int i = 0; i < 5; i++) {
      //System.out.println("HERE2");
      for (int j = 0; j < g1.TrainLines[i].stationSize; j++) {
        //System.out.println("HERE1");
        if (g1.TrainLines[i].stationList[j] == this && ! this.stopHere.contains(g1.TrainLines[i].identifier)) {
          //this.stopHere.add(g1.TrainLines[i].identifier);
        }
      }
    }
  }

  public void paint() {
    strokeWeight(3);
    if (selected) {

      if (tick > 0) {
        if (!blink) {
          //System.out.println("here1");
          fill(color(255, 142, 28));
        } else {
          //System.out.println("here2");
          fill(#33C94A);
        }
      } else {
        fill(#33C94A);
      }




      switch (shape) {
      case 0: 
        avatar = createShape(RECT, this.getXcor()- 5, this.getYcor()-5, 25, 25);
        break;
      case 1:
        avatar = createShape(ELLIPSE, this.getXcor()-2.5, this.getYcor()-2.5, 25, 25);
        break;
      case 2:
        avatar = createShape(TRIANGLE, xcor, ycor - 22.5, xcor - 12.5, ycor + 2.5, xcor + 12.5, ycor + 2.5);
        break;
      case 3:
        avatar = createShape();
        avatar.beginShape();
        avatar.vertex(this.getXcor(), this.getYcor() - 10);
        avatar.vertex(this.getXcor() - sin((2*PI)/5)*10, this.getYcor() - cos((2*PI)/5)*10);
        avatar.vertex(this.getXcor() - sin((4*PI)/5)*10, this.getYcor() + cos((PI)/5)*10);
        avatar.vertex(this.getXcor() + sin((4*PI)/5)*10, this.getYcor() + cos((PI)/5)*10);
        avatar.vertex(this.getXcor() + sin((2*PI)/5)*10, this.getYcor() - cos((2*PI)/5)*10);
        avatar.endShape();
        break;
      case 4:
        avatar = createShape();
        avatar = createShape();
        avatar.beginShape();
        avatar.vertex(this.getXcor()+20, this.getYcor());
        avatar.vertex(this.getXcor()+5, this.getYcor()+5);
        avatar.vertex(this.getXcor(), this.getYcor()+20);
        avatar.vertex(this.getXcor()-5, this.getYcor()+5);
        avatar.vertex(this.getXcor()-20, this.getYcor());
        avatar.vertex(this.getXcor()-5, this.getYcor()-5);
        avatar.vertex(this.getXcor(), this.getYcor()-20);
        avatar.vertex(this.getXcor()+5, this.getYcor()-5);
        avatar.endShape();
        break;
      }
    } else {

      if (tick > 0) {
        if (!blink) {
          //System.out.println("here1");
          fill(color(255, 142, 28));
        } else {
          //System.out.println("here2");
          fill(255, 255, 255);
        }
      } else {
        fill(255, 255, 255);
      }

      switch (shape) {
      case 0: 
        avatar = createShape(RECT, this.getXcor()- 2.5, this.getYcor()-2.5, 20, 20);
        break;
      case 1:
        avatar = createShape(ELLIPSE, this.getXcor()-2.5, this.getYcor()-2.5, 20, 20);
        break;
      case 2:
        avatar = createShape(TRIANGLE, xcor, ycor - 20, xcor - 10, ycor, xcor + 10, ycor);
        break;
      case 3:
        avatar = createShape();
        avatar.beginShape();
        avatar.vertex(this.getXcor(), this.getYcor() - 10);
        avatar.vertex(this.getXcor() - sin((2*PI)/5)*10, this.getYcor() - cos((2*PI)/5)*10);
        avatar.vertex(this.getXcor() - sin((4*PI)/5)*10, this.getYcor() + cos((PI)/5)*10);
        avatar.vertex(this.getXcor() + sin((4*PI)/5)*10, this.getYcor() + cos((PI)/5)*10);
        avatar.vertex(this.getXcor() + sin((2*PI)/5)*10, this.getYcor() - cos((2*PI)/5)*10);
        avatar.endShape();
        break;
      case 4:
        avatar = createShape();
        avatar = createShape();
        avatar.beginShape();
        avatar.vertex(this.getXcor()+20, this.getYcor());
        avatar.vertex(this.getXcor()+5, this.getYcor()+5);
        avatar.vertex(this.getXcor(), this.getYcor()+20);
        avatar.vertex(this.getXcor()-5, this.getYcor()+5);
        avatar.vertex(this.getXcor()-20, this.getYcor());
        avatar.vertex(this.getXcor()-5, this.getYcor()-5);
        avatar.vertex(this.getXcor(), this.getYcor()-20);
        avatar.vertex(this.getXcor()+5, this.getYcor()-5);
        avatar.endShape();
        break;
      }
    }
    shape(avatar);
    strokeWeight(1);
  }

  public boolean hasNext() {
    return hasNext;
  }

  public boolean hasLast() {
    return hasLast;
  }

  public void setNext(boolean k) {
    hasNext = k;
  }

  public void setLast(boolean k) {
    hasLast = k;
  }
}