import java.util.Map;
import java.util.Set;

public class Simulation {
 private ArrayList<Double> x;
 
 private Map<String, ArrayList<Result>> results = new HashMap<>();
 
 public Simulation(int step, int maxData, int reps, Algorithm[] algs){
   x = new ArrayList();
   
   for (int data = 1; data < maxData + 1; data += step){
       x.add((double)data);
       for (Algorithm alg : algs) {
         runForAlgorithm(alg, reps, data);
       }
   }
     
 }
 
 public ArrayList<Double> getX() { return this.x; }
 public Set<String> getSeries() { return this.results.keySet(); };
 
 private void runForAlgorithm(Algorithm alg, int reps, int data){
  alg.setCount(data);
  Runner r = new Runner(reps, alg);
     
  for(String type : r.fieldNames()){
    if (!results.containsKey(type)){
     results.put(type, new ArrayList<Result>()); 
    }
    boolean found = false;
    for(Result record : results.get(type)){
      if(record.sourceName == alg.getClass().getSimpleName()) {
         record.stddevs.add(r.getStddevField(type));
         record.averages.add(r.getAvgField(type));
         found = true;
         break;
      }
    }
    if (!found) {
      Result record = new Result(alg.getClass().getSimpleName(), type);
      record.stddevs.add(r.getStddevField(type));
      record.averages.add(r.getAvgField(type));
      results.get(type).add(record);
    }     
   }
  }
}
