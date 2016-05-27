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
  public int[]connections;
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
    if (shape == 1) {
      Txcor = xcor - 7.5;
      Tycor = ycor - 7.5;
    } else {
      Txcor = xcor;
      Tycor = ycor;
    }
    Passengers = new ArrayList<Passenger>();
  }

  public void paint() {
    strokeWeight(3);
    if (selected) {
      fill(#33C94A);
      switch (shape) {
      case 0: 
        avatar = createShape(RECT, this.getXcor()- 5, this.getYcor()-5, 25, 25);
        break;
      case 1:
        avatar = createShape(ELLIPSE, this.getXcor()-2.5, this.getYcor()-2.5, 25, 25);
        break;
      case 2:
        avatar.beginShape();
        avatar.vertex(this.getXcor(), this.getYcor() + 10);
        avatar.vertex(this.getXcor() - 10 * cos(-2*PI/3), this.getYcor() - 10 * sin(2*PI/3));
        avatar.vertex(this.getXcor() - 10 * cos(-2*PI/3), this.getYcor() + 10 * sin(2*PI/3));
        avatar.endShape(CLOSE);
        break;
      case 3:
        avatar.beginShape();
        avatar.vertex(this.getXcor(), this.getYcor() + 20);
        avatar.vertex(this.getXcor() - 20, this.getYcor());
        avatar.vertex(this.getXcor(), this.getYcor() - 20);
        avatar.vertex(this.getXcor() + 20, this.getYcor());
        avatar.endShape(CLOSE);
        break;
      case 4:
        avatar.beginShape();
        avatar.vertex(this.getXcor(), this.getYcor() - 10);
        avatar.vertex(this.getXcor() - sin((2*PI)/5)*10, this.getYcor() - cos((2*PI)/5)*10);
        avatar.vertex(this.getXcor() - sin((4*PI)/5)*10, this.getYcor() + cos((PI)/5)*10);
        avatar.vertex(this.getXcor() + sin((4*PI)/5)*10, this.getYcor() + cos((PI)/5)*10);
        avatar.vertex(this.getXcor() + sin((2*PI)/5)*10, this.getYcor() - cos((2*PI)/5)*10);
        avatar.endShape();
        break;
      case 5:
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
      fill(255, 255, 255);
      switch (shape) {
      case 0: 
        avatar = createShape(RECT, this.getXcor()- 2.5, this.getYcor()-2.5, 20, 20);
        break;
      case 1:
        avatar = createShape(ELLIPSE, this.getXcor()-2.5, this.getYcor()-2.5, 20, 20);
        break;
      case 2:
        avatar.beginShape();
        avatar.vertex(this.getXcor(), this.getYcor() + 10);
        avatar.vertex(this.getXcor() - 10 * cos(-2*PI/3), this.getYcor() - 10 * sin(2*PI/3));
        avatar.vertex(this.getXcor() - 10 * cos(-2*PI/3), this.getYcor() + 10 * sin(2*PI/3));
        avatar.endShape(CLOSE);
        break;
      case 3:
        avatar.beginShape();
        avatar.vertex(this.getXcor(), this.getYcor() + 20);
        avatar.vertex(this.getXcor() - 20, this.getYcor());
        avatar.vertex(this.getXcor(), this.getYcor() - 20);
        avatar.vertex(this.getXcor() + 20, this.getYcor());
        avatar.endShape(CLOSE);
        break;
      case 4:
        avatar.beginShape();
        avatar.vertex(this.getXcor(), this.getYcor() - 10);
        avatar.vertex(this.getXcor() - sin((2*PI)/5)*10, this.getYcor() - cos((2*PI)/5)*10);
        avatar.vertex(this.getXcor() - sin((4*PI)/5)*10, this.getYcor() + cos((PI)/5)*10);
        avatar.vertex(this.getXcor() + sin((4*PI)/5)*10, this.getYcor() + cos((PI)/5)*10);
        avatar.vertex(this.getXcor() + sin((2*PI)/5)*10, this.getYcor() - cos((2*PI)/5)*10);
        avatar.endShape();
        break;
      case 5:
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