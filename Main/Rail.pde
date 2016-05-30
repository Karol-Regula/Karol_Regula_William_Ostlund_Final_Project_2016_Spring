public class Rail {

  public Station start;
  public Station end;
  public int[] waypoints; //should we make a coordinate class to make the placing of things simpler?
  public color whatColor;
  //the following coordinates are only used when two rails go between the same two stations in order to allow fine offsetting
  //in other cases the coordinates of the stations are used  
  public float sXcor;
  public float sYcor;
  public float eXcor;
  public float eYcor;
  public boolean paintAlternate;

  public Rail(Station start, Station end, color whatColor) {
    this.start = start;
    this.end = end;
    this.whatColor = whatColor;
    paintAlternate = false;
  }

  /* //old version of paint
   public void paint() {
   strokeWeight(3);
   stroke(whatColor);
   if (start.shape == 0 && end.shape ==0) {
   line (start.xcor + 7.5, start.ycor + 7.5, end.xcor + 7.5, end.ycor + 7.5);
   }
   if (start.shape == 1 && end.shape ==0) {
   line (start.xcor, start.ycor, end.xcor + 7.5, end.ycor + 7.5);
   }
   if (start.shape == 0 && end.shape ==1) {
   line (start.xcor + 7.5, start.ycor + 7.5, end.xcor, end.ycor);
   }
   if (start.shape == 1 && end.shape ==1) {
   line (start.xcor, start.ycor, end.xcor, end.ycor);
   }
   stroke(50);
   strokeWeight(1);
   }
   */

  public void paint() { // new and improved paint
    if (!paintAlternate) {
      strokeWeight(4);
      stroke(whatColor);
      if (start.shape == 0) {
        sXcor = start.xcor + 7.5;
        sYcor = start.ycor + 7.5;
      } else if (start.shape == 1) {
        sXcor = start.xcor;
        sYcor = start.ycor;
      }
      if (end.shape == 0) {
        eXcor = end.xcor + 7.5;
        eYcor = end.ycor + 7.5;
      } else if (end.shape == 1) {
        eXcor = end.xcor;
        eYcor = end.ycor;
      }
      line (sXcor, sYcor, eXcor, eYcor);
      stroke(50);
      strokeWeight(1);
    } else {
      strokeWeight(4);
      stroke(whatColor);
      float tsXcor = sXcor;
      float tsYcor = sYcor;
      float teXcor = eXcor;
      float teYcor = eYcor;
      if (start.shape == 0) {
        tsXcor = sXcor + 7.5;
        tsYcor = sYcor + 7.5;
      } else if (start.shape == 1) {
        tsXcor = sXcor;
        tsYcor = sYcor;
      }
      if (end.shape == 0) {
        teXcor = eXcor + 7.5;
        teYcor = eYcor + 7.5;
      } else if (end.shape == 1) {
        teXcor = eXcor;
        teYcor = eYcor;
      }
      line (tsXcor, tsYcor, teXcor, teYcor);
      stroke(50);
      strokeWeight(1);
    }
  }

  /*
  public void paintAlternate() { // new and improved paint
   strokeWeight(3);
   stroke(whatColor);
   line (sXcor, sYcor, eXcor, eYcor);
   stroke(50);
   strokeWeight(1);
   }
   */
  //restructure (both) into seperate end and start determining and then drawing when more station types are implemented
}