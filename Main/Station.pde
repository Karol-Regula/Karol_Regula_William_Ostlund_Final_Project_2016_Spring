public class Station {

  public int xcor;
  public int ycor;
  public int shape;//will be used in paint()

  public Station(int Xcor, int Ycor) {
    xcor = Xcor;
    ycor = Ycor;
  }

  public void paint() {
    fill(0, 225, 225);
    rect(xcor, ycor, 10, 10);
  }
}