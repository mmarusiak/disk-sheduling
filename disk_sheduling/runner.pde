import java.util.function.Function;
import java.util.Map;
import java.util.Set;

public class Runner {
  
  public final String k_name = "processes killed", s_name = "processes starved", h_name = "head moves", a_name = "average waiting times";
  
  private Map<String, Double> avg_fields = new HashMap<String, Double>();
  private Map<String, Double> stddev_fields = new HashMap<String, Double>();
  
  
  public Runner(int reps, Algorithm alg){
    runSimulation(reps, alg, 
      new Metric(k_name, Algorithm::killed), 
      new Metric(s_name, Algorithm::starved),  
      new Metric(h_name, Algorithm::moves),
      new Metric(a_name, Algorithm::avgWaitingTime));
  }
  
  public void runSimulation(int reps, Algorithm alg, Metric... metrics){
    ArrayList<Double>[] results = new ArrayList[metrics.length];
    
    for(int i = 0; i < reps; i ++){
      Algorithm a = alg.clone();
      while(a.processesLeft()){
        a.iteration();
      }
      for (int j = 0; j < metrics.length; j ++){
        if (results[j] == null) results[j] = new ArrayList<Double>();
        results[j].add(metrics[j].function.apply(a));
      }
    }
    
    for (int i = 0; i < metrics.length; i ++){
      double avg_field = getAvg(results[i]);
      avg_fields.put(metrics[i].name, avg_field);
      stddev_fields.put(metrics[i].name, getStddev(results[i], avg_field));
    }
  }
  
  private double getAvg(ArrayList<Double> source){
    if(source.size() == 0) return 0;
    
    double sum = 0;
    for(double d : source) sum += d;
    return sum / source.size();
  }
  
  private double getStddev(ArrayList<Double> source, double avg){
    double sqrts = 0;  
    for(double d : source) sqrts += Math.pow(d - avg, 2);
    return Math.sqrt(sqrts / (source.size() - 1));
  }
  
  public Set<String> fieldNames(){ return avg_fields.keySet(); }
  
  public double getAvgField(String fieldName) { return avg_fields.get(fieldName); }
  public double getStddevField(String fieldName) { return stddev_fields.get(fieldName); }
  
  public double getAvgKilled() { return getAvgField(k_name); }
  public double getAvgStarved() { return getAvgField(s_name); }
  public double getAvgMoves() { return getAvgField(h_name); }
  public double getAvgTime() { return getAvgField(a_name); }
  
  public double getStddevKilled() { return getStddevField(k_name); }
  public double getStddevStarved() { return getStddevField(s_name); }
  public double getStddevMoves() { return getStddevField(h_name); }
  public double getStddevTime() { return getStddevField(a_name); }
}
