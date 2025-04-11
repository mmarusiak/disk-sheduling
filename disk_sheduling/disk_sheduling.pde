import grafica.*;

final int DISK_SIZE = 50;
final int START_POS = 0;
final int PROCESSES_COUNT = 200;

final int PROCESS_WIDTH = 40, PROCESS_HEIGHT = 60, STARVATION = 100;
final int HEAD_WIDTH = 100, HEAD_HEIGHT = 100;

//https://github.com/jagracar/grafica/blob/master/examples/MultiplePlots/MultiplePlots.pde

Generator gen = new RandomGenerator(9);
View view;
boolean visualize = false;

void setup() {
  size(1260, 500);
  noStroke();
  rectMode(CENTER);
  view = new View(20, new Scene(d_FCFS()), new Scene(d_SSTF()), new Scene(d_Scan()), new Scene(d_CScan()));
  Algorithm[] algs = new Algorithm[] {(d_FCFS()), (d_SSTF()), (d_Scan()), (d_CScan()) };
  
  Simulation sim = new Simulation(10, 100, 2, algs[2]);
  
  graph(sim.getX(), sim.getMoves(), "processes amount", "moves", "simple graph");
  print("done");
}

void draw() {
  if(!visualize) return;
  background(255);
  view.drawView();
}

CScan d_CScan(){
   return new CScan(START_POS, "C-Scan", gen, PROCESSES_COUNT, DISK_SIZE); 
}

Scan d_Scan(){
   return new Scan(START_POS, "Scan", gen, PROCESSES_COUNT, DISK_SIZE); 
}

FCFS d_FCFS(){
   return new FCFS(START_POS, "FCFS", gen, PROCESSES_COUNT); 
}

SSTF d_SSTF(){
   return new SSTF(START_POS, "SSTF", gen, PROCESSES_COUNT); 
}

ArrayList<Process> cloneProcesses(ArrayList<Process> src){
  ArrayList<Process> cloned = new ArrayList<Process>();
  for(Process p : src){
    cloned.add(p.clone());
  }
  return cloned;
}


void graph(ArrayList<Double> x, ArrayList<Double> y, String xLabel, String yLabel, String graphTitle){
    if(x.size() != y.size()) throw new IllegalArgumentException();
    
    GPointsArray points = new GPointsArray(x.size());
  
    for (int i = 0; i < x.size(); i++) {
      points.add(x.get(i).floatValue(), y.get(i).floatValue());
    }
  
    // Create a new plot and set its position on the screen
    GPlot plot = new GPlot(this);
    plot.setPos(25, 25);
    // or all in one go
    // GPlot plot = new GPlot(this, 25, 25);
  
    // Set the plot title and the axis labels
    plot.setTitleText(graphTitle);
    plot.getXAxis().setAxisLabelText(xLabel);
    plot.getYAxis().setAxisLabelText(yLabel);
  
    // Add the points
    plot.setPoints(points);
  
    // Draw it!
    plot.defaultDraw();
}
