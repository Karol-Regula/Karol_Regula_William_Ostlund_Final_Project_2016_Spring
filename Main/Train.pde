public class Train {

  public int passengers;
  public int personLimit;
  public boolean traveling;
  public Station start;
  public Station end;
  public int xcor;
  public int ycor;
  
  public Train(Station start, Station end){
    this.start = start;
    this.end = end;
    xcor = start.xcor;
    ycor = start.ycor;
    traveling  = true; //true for now, determined by consrtuctor later
  }
  
  public void paint(){
    rect(xcor, ycor, 10, 20); //need to chnage facing direction later
  }
  
  public void move(){
    if (traveling){
      
      while (xcor != end.xcor && ycor != end.ycor){
        
      }
    }
  }
  
  }