public class Metric {
  protected final String name;
  protected final Function<Algorithm, Double> function;
  
  public Metric(String name, Function<Algorithm, Double> function){
    this.name = name;
    this.function = function;
  }
}
