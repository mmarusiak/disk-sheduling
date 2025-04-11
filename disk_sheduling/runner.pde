import java.util.function.Function;

public class Runner {
  
  private double pKilled, pStarved, moves, waitingTime;
  private double stddev_pKilled, stddev_pStarved, stddev_moves, stddev_waitingTime;
  
  public Runner(int reps, Algorithm alg){
    runSimulation(reps, alg, Algorithm::killed, Algorithm::starved,  Algorithm::moves, Algorithm::avgWaitingTime);
  }
  
  public void runSimulation(int reps, Algorithm alg, Function<Algorithm, Double>... fields){
    ArrayList<Double>[] results = new ArrayList[fields.length];
    
    for(int i = 0; i < reps; i ++){
      Algorithm a = alg.clone();
      while(a.processesLeft()){
        a.iteration();
      }
      for (int j = 0; j < fields.length; j ++){
        if (results[j] == null) results[j] = new ArrayList<Double>();
        results[j].add(fields[j].apply(a));
      }
    }
    
    pKilled = getAvg(results[0]);
    pStarved = getAvg(results[1]);
    moves = getAvg(results[2]);
    waitingTime = getAvg(results[3]);
    //print(moves);
    
    
    stddev_pKilled = getstddev(results[0], pKilled);
    stddev_pStarved = getstddev(results[1], pStarved);
    stddev_moves = getstddev(results[2], moves);
    stddev_waitingTime = getstddev(results[3], waitingTime);
  }
  
  private double getAvg(ArrayList<Double> source){
    if(source.size() == 0) return 0;
    
    double sum = 0;
    for(double d : source) sum += d;
    return sum / source.size();
  }
  
  private double getstddev(ArrayList<Double> source, double avg){
    double sqrts = 0;  
    for(double d : source) sqrts += Math.pow(d - avg, 2);
    return Math.sqrt(sqrts / (source.size() - 1));
  }
  
  public double getMoves() { return this.moves; }
  public double getKilled() { return this.pKilled; }
  public double getStarved() { return this.pStarved; }
  public double getTime() { return this.waitingTime; }
}
