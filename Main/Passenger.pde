import java.util.*; //<>//

public class Passenger {

  public int shape;
  public char targetTrainLine;
  public Station targetStation; //only used if the Passenger is on the wrong TrainLine and needs to get off at a SPECIFIC station to transfer to another TrainLine
  public Station currentStation;
  public Train t1;
  public boolean onTrain;
  public PShape avatar;
  public ArrayList<Station> route;
  public boolean processed;
  public boolean tem = false;

  public Passenger(int shape) {
    this.shape = shape;
    processed = false;
  }

  public void solve(Station x) { //alternate that uses connected stations
    ArrayList<Station> j = new ArrayList<Station>();
    solve (x, j);
    if (route != null) {
      ArrayList<Station> temp = new ArrayList<Station>();
      //System.out.println(currentStation);
      //System.out.println(route.get(0).xcor + " " + currentStation.xcor);
      //System.out.println(route.get(0).ycor + " " + currentStation.ycor);
      if (route.size() != 0 && route.get(0).xcor == currentStation.xcor && route.get(0).ycor == currentStation.ycor) {
        for (int i = 1; i < route.size(); i++) {
          temp.add(route.get(i));
        }
      }
      route = temp;
      if (!route.isEmpty() && route.get(0) == currentStation) {
        for (int i = 1; i < route.size(); i++) {
          temp.add(route.get(i));
        }
      }
      route = temp;
    }
  }

  public void solve(Station x, ArrayList<Station> j) {
    Queue<Node> searcher = new LinkedList<Node>();
    ArrayList<Station> checkedStations = new ArrayList<Station>();
    checkedStations.add(x);
    //System.out.println("solve" + x.connects);
    searcher.add(new Node(x, null));

    while (searcher.peek().value.shape != this.shape) {
      for (int i = 0; i<searcher.peek().value.connectedStations.size(); i++) {
        if (!checkedStations.contains(searcher.peek().value.connectedStations.get(i))) {
          boolean emf = checkLoop(searcher.peek().value.connectedStations.get(i), searcher.peek().value);
          for(int d = 0; d < 1; d++){
            
         System.out.println(emf);
         }
          if (checkLoop(searcher.peek().value.connectedStations.get(i), searcher.peek().value)) {
            searcher.add(new Node (searcher.peek().value.connectedStations.get(i), searcher.peek()));
            checkedStations.add(searcher.peek().value.connectedStations.get(i));
          }
          //checkedStations.add(searcher.peek().value.connectedStations.get(i));
        }
      }
      searcher.remove();
      if (searcher.isEmpty()) {
        break;
      }
    }
    if (!searcher.isEmpty()) {
      setRoute(searcher.peek());
    }/*else{
     route.add(this.currentStation); 
     }*/
    return;
  }

  public boolean checkLoop(Station x, Station y) {
    tem = false;
     //System.out.println("yay");
    TrainLine[] v = new TrainLine[10];
    TrainLine[] w = new TrainLine[10];
    //System.out.println(x.connects.size());
    //boolean t1 = false;
    //boolean t2 = false;
    for (int i = 0; i< x.connects.size(); i++) {
      v[i] = x.connects.get(i);
    }
    for (int i = 0; i< y.connects.size(); i++) {
      w[i] = y.connects.get(i);
    }
    TrainLine[] q = intersection(v, w);
    //System.out.println(q);
    return tem || worksWithLoop(x, y, q);
  }

  public TrainLine[] intersection(TrainLine[]x, TrainLine[]w) {
    TrainLine[]ans = new TrainLine[10];
    int g = 0;
    for (int i = 0; i<x.length; i++) {
      for (int k = 0; k<w.length; k++) {
        if (x[i] != null && w[k] != null) {
          if (x[i] == w[k] && x[i].loop) {
            //for(int d = 0; d < 200; d++){
            //System.out.println("fretghbn");
            //}
            ans[g] = x[i];
            g++;
            //System.out.println
            //("Could not run the sketch (Target VM failed to initialize).For more information, read revisions.txt and Help ? Troubleshooting.");
          } else if (x[i] == w[k] && !x[i].loop) {
            tem = true;
            //return ans;
          }
        }
      }
    }
    return ans;
  }

  public boolean worksWithLoop(Station x, Station y, TrainLine[] z) {
    //System.out.println("shi");
    boolean train = false;
    for (int i = 0; i < z.length; i++) {
      int forward = 0;
      int backwords = 0;
      for (int k = 0; z[i] != null && k < z[i].trainSize; k++) {
        train = true;
        if (z[i].trainList[k].forward) {
          forward++;
        } else {
          backwords++;
        }
        if (forward < 0 && backwords < 0) {
          return false;
        } else if (forward> 0 && backwords > 0) {
          return true;
        } else {
          int first = findIndex(y, z[i]);
          int second = findIndex(x, z[i]);
          if (forward > 0) {
            if (second == 0) {
              return first == (z[i].stationSize - 1);
            } else {
              return first < second;
            }
          }
          if (backwords > 0) {
            if (first == 0) {
              return second == (z[i].stationSize - 1);
            } else {
              return first > second;
            }
          }
        }
      }
    }
    return z.length == 0;// || !train;
  } 

  /*
  public void solve(Station x) { //alternate that uses connected stations
   ArrayList<TrainLine> j = new ArrayList<TrainLine>();
   solve (x, j);
   if (route != null) {
   while (route.get(0) == currentStation) {
   route.remove(0);
   }
   }
   }
   
   public void solve(Station x, ArrayList<TrainLine> j) {
   System.out.println("solve");
   System.out.println(x);
   int counter = 0;
   searcher.add(new Node(x, null));
   for (int i = 0; i<x.connects.size(); i++) {//I used the data type that I made since I thought it was easier to use
   if (x.connects.get(i) != null) {         // the automatic setting of values to zero makes it more difficult to code
   j.add(x.connects.get(i));
   }
   }
   while (searcher.peek()!=null) {
   
   if (mouseClickRail) {
   break;
   }
   counter++;
   if (counter == 100) {
   break;
   //something is crashing, I don't know what, maybe you can fix it, remove this if statement to see the crash
   }
   
   if (searcher.peek().value.shape == this.shape) {
   setRoute(searcher.peek());
   return;
   
   
   }
   for (int i = 0; i<searcher.peek().value.connects.size(); i++) {
   //System.out.println("searcher.peek().value.connects.size(): " + searcher.peek().value.connects.size());
   
   if (notChosen(searcher.peek().value.connects.get(i), j)) {         
   j.add(searcher.peek().value.connects.get(i)); // -searcher.peek().value + x
   }
   //find index of current station
   int k = findIndex(searcher.peek().value, searcher.peek().value.connects.get(i));
   //add preceding station if one exists
   if (k!=0) {
   if (! searcher.contains(searcher.peek().value.connects.get(i).stationList[k-1])) {
   searcher.add(new Node(searcher.peek().value.connects.get(i).stationList[k-1], searcher.peek()));
   }
   }
   //add next station if one exists
   if (k!=searcher.peek().value.connects.get(i).stationSize - 1) {
   if (! searcher.contains(searcher.peek().value.connects.get(i).stationList[k+1])) {
   searcher.add(new Node(searcher.peek().value.connects.get(i).stationList[k+1], searcher.peek()));
   }
   }
   }
   searcher.remove();
   }
   }
   */

  public boolean notChosen(TrainLine l, ArrayList<TrainLine> k) {
    for (int i = 0; i< k.size(); i++) {
      if (l == k.get(i)) {
        //System.out.println("notChosen: false");
        return false;
      }
    }
    //System.out.println("notChosen: true");
    return true;
  }

  public void setRoute(Node k) {
    //System.out.println("setRoute");
    route = new ArrayList<Station>();
    while (route.size() > 0) {
      route.remove(0);
    }
    while (k != null) {
      route.add(0, k.value);
      k = k.last;
    }
    //route.remove(0);
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