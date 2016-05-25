public class Passenger{
  
  public int shape;
  
  public Passenger(int shape){
    this.shape = shape;
    
  }
  
  public void paint(int xcor, int ycor){
    if (shape == 0){
      rect(xcor, ycor, 5, 5);
    }
    if (shape == 1){
      ellipse(xcor, ycor, 5, 5);
    }
  }
  
  
}