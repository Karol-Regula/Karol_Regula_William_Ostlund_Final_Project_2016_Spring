public class Station implements Locatable{

  public float xcor;
  public float ycor;
  public int shape;//will be used in paint()
  public int personLimit;
  private boolean hasNext;
  private boolean hasLast;
  private Rail next;
  private Rail last;

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
  
  public boolean hasNext(){
    return hasNext; 
  }
  
  public boolean hasLast(){
    return hasLast; 
  }
  
  public void setNext(boolean k){
    hasNext = k; 
  }
  
  public void setLast(boolean k){
    hasLast = k; 
  }
  
  public Rail next(){
    return next; 
  }
  
  public Rail last(){
    return last; 
  }
  
  public void setNext(Rail k){
    next = k; 
  }
  
  public void setLast(Rail k){
    last = k; 
  }
  
}