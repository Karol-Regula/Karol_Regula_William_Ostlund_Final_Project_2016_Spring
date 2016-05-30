public class Passenger{
  
  public int shape;
  
  public Passenger(int shape){
    this.shape = shape;
    
  }
  
  public void paint(int xcor, int ycor){
    if (shape == 0){
      fill(50);
      rect(xcor, ycor, 6, 6);
    }
    if (shape == 1){
      fill(50);
      ellipse(xcor + 3, ycor + 3, 6, 6);
    }
    if (shape == 2){
      fill(50);
      triangle(xcor + 3, ycor, xcor, ycor + 6, xcor + 6, ycor + 6);
    }
  }
  
  
}