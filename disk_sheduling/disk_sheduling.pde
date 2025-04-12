import grafica.*;

final int DISK_SIZE = 50;
final int START_POS = 0;
final int PROCESSES_COUNT = 200;

final int PROCESS_WIDTH = 40, PROCESS_HEIGHT = 60, STARVATION = 100;
final int HEAD_WIDTH = 100, HEAD_HEIGHT = 100;

final color[] PLOT_COLORS = new color[] { color (255, 0, 255), color (255, 0, 0), color (0, 255, 0), color (0, 0, 255), color (0, 255, 255) };

//https://github.com/jagracar/grafica/blob/master/examples/MultiplePlots/MultiplePlots.pde

Generator gen = new RandomGenerator(9);
View view;
boolean visualize = false;

void setup() {
  size(1260, 500);
  noStroke();
  rectMode(CENTER);
  background(255);
  view = new View(20, new Scene(d_FCFS()), new Scene(d_SSTF()), new Scene(d_Scan()), new Scene(d_CScan()));
  Algorithm[] algs = new Algorithm[] {(d_FCFS()), (d_SSTF()), (d_Scan()), (d_CScan()) };
  
  Simulation sim = new Simulation(10, 100, 2, algs);
  int i = 0;
  for (String s : sim.results.keySet()) {
    graph(sim.getX(), sim.results.get(s), "processes amount", s, s, width * i /algs.length, 0, width/algs.length, height/algs.length); 
    i += 1;
  }
  String s = "head moves";
  graph(sim.getX(), sim.results.get(s), "processes amount", s, s, 0, 0, 700, 300); 
  
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


void graph(ArrayList<Double> x, ArrayList<Result> ySeries, String xLabel, String yLabel, String graphTitle, int xOffset, int yOffset, int plotWidth, int plotHeight){
    if(x.size() != ySeries.get(0).averages.size()) throw new IllegalArgumentException();
  
    // Create a new plot and set its position on the screen
    GPlot plot = new GPlot(this, xOffset, yOffset);
    plot.setDim(plotWidth, plotHeight);
    
    String[] names = new String[ySeries.size()];
    float[] xPos = new float[ySeries.size()];
    float[] yPos = new float[ySeries.size()];
    
    for (int j = 0; j < ySeries.size(); j ++){
      Result record = ySeries.get(j);
      int n = min(record.averages.size(), x.size());
      GPointsArray points = new GPointsArray();
      for(int i = 0; i < n; i ++){
          points.add(x.get(i).floatValue(), record.averages.get(i).floatValue());
      }
      names[j] = record.sourceName;
      yPos[j] = 0.92;
      xPos[j] = j == 0 ? 0.07 : xPos[j-1] + 0.15;
      if (j == 0){
        plot.setPoints(points);
        plot.setLineColor(PLOT_COLORS[0]);
        continue;
      }
      plot.addLayer(record.sourceName, points);
      plot.getLayer(record.sourceName).setLineColor(PLOT_COLORS[j%PLOT_COLORS.length]);
    }
    
    plot.drawLegend(names, yPos, xPos);
  
    // Set the plot title and the axis labels
    plot.setTitleText(graphTitle);
    plot.getXAxis().setAxisLabelText(xLabel);
    plot.getYAxis().setAxisLabelText(yLabel);
  
  
    plot.beginDraw();
    plot.drawBox();
    plot.drawXAxis();
    plot.drawYAxis();
    plot.drawTitle();
    plot.drawGridLines(GPlot.BOTH);
    plot.drawLines();
    plot.drawLegend(names, xPos, yPos);
    plot.drawLabels();
    plot.endDraw();
}
