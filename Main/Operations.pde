public class Operations{
  
  public float dist(Locatable x, Locatable y){
      return (float)Math.sqrt(Math.pow(x.getXcor() - y.getXcor(), 2) + Math.pow(x.getYcor() - y.getYcor(), 2)); 
  }
  
}