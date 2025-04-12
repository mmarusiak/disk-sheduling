public class Result {
  protected String sourceName, resultType;
  protected ArrayList<Double> averages, stddevs;
  
  public Result(String sourceName, String resultType){
    this.resultType = resultType;
    this.sourceName = sourceName;
    this.averages = new ArrayList();
    this.stddevs = new ArrayList();
  }
}
