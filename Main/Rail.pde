public class Rail {

  public Station start;
  public Station end;
  public int[] waypoints; //should we make a coordinate class to make the placing of things simpler?
  public color whatColor;

  public Rail(Station start, Station end, color whatColor) {
    this.start = start;
    this.end = end;
    this.whatColor = whatColor;
  }

  public void paint() {
    strokeWeight(3);
    stroke(whatColor);
    line (start.xcor + 5, start.ycor + 5, end.xcor + 5, end.ycor + 5);
    stroke(50);
    strokeWeight(1);
  }
}