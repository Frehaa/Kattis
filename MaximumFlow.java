import java.util.Scanner;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.Queue;
import java.util.LinkedList;
import java.util.stream.*;

class MaximumFlow {

  public static void main(String[] args) {
    var sc = new Scanner(System.in);
    int n = sc.nextInt();
    int m = sc.nextInt();
    int s = sc.nextInt();
    int t = sc.nextInt();

    var network = new FlowNetwork(n);

    for (int i = 0; i < m; ++i) {
      int v = sc.nextInt();
      int w = sc.nextInt();
      int c = sc.nextInt();

      var edge = new FlowEdge(v, w, c);
      network.addEdge(edge);
    }

    var result = new FordFulkerson(network, s, t);

    var m2 = new ArrayList<FlowEdge>();
    for (var e : network.edges()) {
      if (e.flow() > 0) m2.add(e);
    }

    System.out.println(String.format("%d %d %d", n, result.value(), m2.size()));
    for (var e : m2) {
      System.out.println(String.format("%d %d %d", e.from(), e.to(), e.flow()));
    }
  }

}

// Ford-Fulkerson implementation inspired by Sedgewick & Wayne (p. 886-902)

class FordFulkerson {
  private static final int INITIAL_DELTA = 1073741824; // 2^30
  private boolean[] marked;
  private FlowEdge[] edgeTo;
  private int value;

  public FordFulkerson(FlowNetwork G, int s, int t) {
    for (int delta = INITIAL_DELTA; delta >= 1; delta /= 2) {
      while (hasAugmentingPath(G, s, t, delta)) {
        int bottleneck = Integer.MAX_VALUE;
        for (int v = t; v!= s; v = edgeTo[v].other(v))
          bottleneck = Math.min(bottleneck, edgeTo[v].residualCapacityTo(v));

        for (int v = t; v != s; v = edgeTo[v].other(v))
          edgeTo[v].addResidualFlowTo(v, bottleneck);

        value += bottleneck;
      }
    }
  }

  public int value() { return value; }
  public boolean inCut(int v) { return marked[v]; }

  private boolean hasAugmentingPath(FlowNetwork G, int s, int t, int delta) {
    marked = new boolean[G.V()];
    edgeTo = new FlowEdge[G.V()];
    Queue<Integer> queue = new LinkedList<Integer>();

    marked[s] = true;
    queue.add(s);
    while (!queue.isEmpty()) {
      int v = queue.poll();
      for (FlowEdge e : G.adj(v)) {
        int w = e.other(v);
        if (e.residualCapacityTo(w) < delta) continue;
                  
        if (e.residualCapacityTo(w) > 0 && !marked[w]) {
          edgeTo[w] = e;
          marked[w] = true;
          queue.add(w);
        }
      }
    }
    

    return marked[t];
  }
}

class FlowNetwork {
  private final ArrayList<HashMap<Integer, FlowEdge>> vertices;

  public FlowNetwork(int V) {
    vertices = new ArrayList<HashMap<Integer, FlowEdge>>();
    for (int i = 0; i < V; ++i) {
      vertices.add(new HashMap<Integer, FlowEdge>());
    }
  }

  public int V() { return vertices.size(); }

  public void addEdge(FlowEdge e) {
    int v = e.from();
    int w = e.to();

    var oldEdge = vertices.get(v).get(w);
    if (oldEdge != null)
      e = new FlowEdge(v, w, oldEdge.capacity() + e.capacity());
    
    vertices.get(v).put(w, e);
    vertices.get(w).put(v, e);
  }

  public Iterable<FlowEdge> adj(int v) {
    if (v >= vertices.size()) 
      throw new IllegalArgumentException("Invalid vertex");
    return vertices.get(v).values();
  }

  public Iterable<FlowEdge> edges() {
    var result = new ArrayList<FlowEdge>();
    for (int v = 0; v < vertices.size(); ++v) {
      for (FlowEdge e : adj(v)) {
        if (e.from() == v) result.add(e);
      }
    }
    return result;
  }
}

class FlowEdge {
  private final int v;
  private final int w;
  private final int capacity;
  private int flow;

  public FlowEdge(int v, int w, int capacity) {
    this.v = v;
    this.w = w;
    this.capacity = capacity;
    this.flow = 0;
  }

  public int from() { return v; }
  public int to() { return w; }
  public int capacity() { return capacity; }
  public int flow() { return flow; }

  public int other(int vertex) {
    if (vertex == v) return w;
    if (vertex == w) return v;
    throw new IllegalArgumentException("Invalid vertex");
  }

  public int residualCapacityTo(int vertex) {
    if (vertex == v) return flow;
    if (vertex == w) return capacity - flow;
    throw new IllegalArgumentException("Invalid vertex");
  }

  public void addResidualFlowTo(int vertex, int flow) {
    if (vertex == v) this.flow -= flow;
    else if (vertex == w) this.flow += flow;
    else throw new IllegalArgumentException("Invalid vertex");
  }

  public String toString() {
    return String.format("%d->%d %d %d", v, w, capacity, flow);
  }

}
