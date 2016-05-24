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
    if (start.shape == 0 && end.shape ==0){
    line (start.xcor + 7.5, start.ycor + 7.5, end.xcor + 7.5, end.ycor + 7.5);
    }
    if (start.shape == 1 && end.shape ==0){
    line (start.xcor, start.ycor, end.xcor + 7.5, end.ycor + 7.5);
    }
    if (start.shape == 0 && end.shape ==1){
    line (start.xcor + 7.5, start.ycor + 7.5, end.xcor, end.ycor);
    }
    if (start.shape == 1 && end.shape ==1){
    line (start.xcor, start.ycor, end.xcor, end.ycor);
    }
    stroke(50);
    strokeWeight(1);
  }
}