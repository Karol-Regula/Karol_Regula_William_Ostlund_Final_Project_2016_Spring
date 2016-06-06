public class Operations {

  public float dist(Locatable x, Locatable y) {
    return (float)Math.sqrt(Math.pow(x.getXcor() - y.getXcor(), 2) + Math.pow(x.getYcor() - y.getYcor(), 2));
  }

  public float dist(Locatable x) {
    return (float)Math.sqrt(Math.pow(x.getXcor() + 5 - mouseX, 2) + Math.pow(x.getYcor() + 5 - mouseY, 2));
  }
  
  public float dist(float x, float y) {
    return (float)Math.sqrt(Math.pow(x - mouseX, 2) + Math.pow(y - mouseY, 2));
  }
}