public class Operations {

  public float dist(Locatable x, Locatable y) {
    return (float)Math.sqrt(Math.pow(x.getXcor() - y.getXcor(), 2) + Math.pow(x.getYcor() - y.getYcor(), 2));
  }

  public float dist(Locatable x) {
    return (float)Math.sqrt(Math.pow(x.getXcor() - mouseX, 2) + Math.pow(x.getYcor() - mouseY, 2));
  }
}