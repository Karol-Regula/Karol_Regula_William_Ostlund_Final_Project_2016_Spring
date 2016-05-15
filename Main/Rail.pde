public class Rail {

  public Station start;
  public Station end;
  public int[] waypoints; //should we make a coordinate class to make the placing of things simpler?

  public Rail(Station start, Station end) {
    this.start = start;
    this.end = end;
  }

  public void paint() {
    strokeWeight(3);
    line (start.xcor + 5, start.ycor + 5, end.xcor + 5, end.ycor + 5);
    strokeWeight(1);
  }
}