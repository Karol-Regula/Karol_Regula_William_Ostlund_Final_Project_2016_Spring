public class Station implements Locatable {

  public float xcor;
  public float ycor;
  public float Txcor;
  public float Tycor;
  public int shape;//will be used in paint()
  public int personLimit;
  private boolean hasNext;
  private boolean hasLast;
  private int identifier;
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
    if (shape == 1){
      Txcor = xcor - 7.5;
      Tycor = ycor - 7.5;
    }else{
      Txcor = xcor;
      Tycor = ycor;
    }
  }

  public void paint() {
    if (selected) {
      fill(#33C94A);
      if (shape == 0) {
        rect(xcor-2.5, ycor-2.5, 20, 20);
      } else {
        ellipse (xcor-2.5, ycor-2.5, 20, 20);
      }
    } else {
      fill(0, 225, 225);
      if (shape == 0) {
        rect(xcor, ycor, 15, 15);
      } else {
        ellipse(xcor, ycor, 15, 15);
      }
    }
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