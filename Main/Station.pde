public class Station implements Locatable{

  public float xcor;
  public float ycor;
  public int shape;//will be used in paint()
  public int personLimit;

  public float getXcor(){
     return this.xcor; 
  }
  
  public float getYcor(){
     return this.ycor; 
  }

  public Station(int Xcor, int Ycor) {
    xcor = Xcor;
    ycor = Ycor;
  }

  public void paint() {
    fill(0, 225, 225);
    rect(xcor, ycor, 10, 10);
  }
}