public class Simulation {
 private ArrayList<Double> x, moves, killed, starved;
 
 public Simulation(int step, int maxData, int reps, Algorithm alg){
   x = new ArrayList();
   moves = new ArrayList();
   killed = new ArrayList();
   starved = new ArrayList();
   
   for (int data = 1; data < maxData + 1; data += step){
     alg.setCount(data);
     Runner r = new Runner(reps, alg);
     x.add((double)data);
     moves.add((double)r.getMoves());
     killed.add((double)r.getKilled());
     starved.add((double)r.getStarved());
   }
 }
 
 public ArrayList<Double> getX() { return this.x; }
 public ArrayList<Double> getMoves() { return this.moves; }
 
}
