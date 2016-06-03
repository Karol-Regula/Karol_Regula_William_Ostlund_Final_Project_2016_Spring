import java.util.*;

public class Passenger {

  public int shape;
  public char targetTrainLine;
  public Station targetStation; //only used if the Passenger is on the wrong TrainLine and needs to get off at a SPECIFIC station to transfer to another TrainLine
  public Station currentStation;
  public Train t1;
  public boolean onTrain;
  public PShape avatar;
  public ArrayList<Station> route;
  public Queue<Node> searcher;

  public Passenger(int shape) {
    this.shape = shape;
  }

  public void solve(Station x, ArrayList<TrainLine> j) {
    searcher.add(new Node(x, null));
    for (int i = 0; i<x.connects.size(); i++) {//I used the data type that I made since I thought it was easier to use
      if (x.connects.get(i) != null) {         // the automatic setting of values to zero makes it more difficult to code
        j.add(x.connects.get(i));
      }
    }
    while (searcher.peek()!=null) {
      if (searcher.peek().value.shape == this.shape) {
        setRoute(searcher.peek());
        return;
      }
      for (int i = 0; i<searcher.peek().value.connects.size(); i++) {
        if (notChosen(searcher.peek().value.connects.get(i), j)) {         
          j.add(x.connects.get(i));
        }
        int k = findIndex(searcher.peek().value, searcher.peek().value.connects.get(i));
        if (k!=0) {
          searcher.add(new Node(searcher.peek().value.connects.get(i).stationList[k-1], searcher.peek()));
        }
        if (k!=searcher.peek().value.connects.get(i).stationSize - 1) {
          searcher.add(new Node(searcher.peek().value.connects.get(i).stationList[k+1], searcher.peek()));
        }
      }
      searcher.remove();
    }
  }
  
  public boolean notChosen(TrainLine l, ArrayList<TrainLine> k){
    for(int i = 0; i< k.size(); i++){
      if(l == k.get(i)){
        return false; 
      }
    }
    return true;
  }

  public void setRoute(Node k) {
    route = new ArrayList<Station>();
    while (k != null) {
      route.add(0, k.value);
      k = k.last;
    }
  }

  public int findIndex(Station x, TrainLine l) {
    for (int i = 0; i < l.stationSize; i++) {
      if (l.stationList[i] == x) {
        return i;
      }
    }
    return -1;
  }

  public void paint(int xcor, int ycor) {
    if (shape == 0) {
      fill(50);
      avatar = createShape(RECT, xcor, ycor, 6, 6);
    }
    if (shape == 1) {
      fill(50);
      avatar = createShape(ELLIPSE, xcor + 3, ycor + 3, 6, 6);
    }
    if (shape == 2) {
      fill(50);
      avatar = createShape();
      avatar.beginShape();
      avatar.vertex(xcor, ycor + 6);
      avatar.vertex(xcor + 3, ycor);
      avatar.vertex(xcor + 6, ycor + 6);
      avatar.vertex(xcor, ycor + 6);
      avatar.endShape();
      //triangle(xcor + 3, ycor, xcor, ycor + 6, xcor + 6, ycor + 6);
    }
    shape(avatar);
  }

  public void calculatePath() {//needs to work dynamically all the time as the user will keep shifting connections
    //I'm starting to worry that if we run all of our for loops on a large train system at the same time this game will explode.
  }
}