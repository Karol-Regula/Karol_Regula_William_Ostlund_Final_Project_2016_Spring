public class Station {

  public int xcor;
  public int ycor;
  public int shape;//will be used in paint()
  public int personLimit;
  public int identifier;

 public Station(int Xcor, int Ycor, int identifier) {
    xcor = Xcor;
    ycor = Ycor;
    this.identifier = identifier;
  }

  public void paint() {
    fill(0, 225, 225);
    rect(xcor, ycor, 10, 10);
  }
}