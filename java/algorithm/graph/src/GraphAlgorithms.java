import java.io.IOException;
import java.util.ArrayDeque;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.Map;
import java.util.Map.Entry;
import java.util.PriorityQueue;
import java.util.Queue;
import java.util.Set;
import java.util.Stack;
import java.util.TreeSet;

public class GraphAlgorithms {

	PriorityQueue<PathState> pq;  // Used for Dijkstra's shortest path algorithm
	Queue<Vertex> queue;  // use for BFS
	Stack<Vertex> stack;  // used for DFS and for Topological Sort
	Set<String> visited;  // names of the visited vertices

	public String PATH_NOT_FIND = "path not found";

	public GraphAlgorithms() {
		pq = new PriorityQueue<PathState>();
		queue = new LinkedList<>();
		stack = new Stack<>();
		visited = new HashSet<>();
	}
	public void clear(){
		pq.clear();
		queue.clear();
		stack.clear();
		visited.clear();
	}

	public String findShortestPath(Graph graph, String startVertexName, String endVertexName) {
		Vertex start = graph.getVertex(startVertexName);
		if(start == null){
			return PATH_NOT_FIND;
		}
		Vertex end = graph.getVertex(endVertexName);
		if(end == null){
			return PATH_NOT_FIND;
		}
		clear();
		pq.add(new PathState(start, 0, " " + start.getName()));
		while(!pq.isEmpty()){
			PathState nextEntry = pq.remove();
			if(!visited.contains(nextEntry.vertex.getName())){
				visited.add(nextEntry.vertex.getName());
				if(nextEntry.vertex.equals(end)){
					return nextEntry.toString();
				}else{
					Vertex currVertex = nextEntry.vertex;
					int currCost = nextEntry.totalPathWt;
					String currPath = nextEntry.pathToThisVertex;
					for(Map.Entry<String, Integer> e : currVertex.getAdjacentVerticesWeighted().entrySet()){
						int nextCost = currCost + e.getValue();
						String nextPath = currPath + " " + e.getKey();
						PathState nextState = new PathState(graph.getVertex(e.getKey()), nextCost, nextPath);
						pq.add(nextState);
					}
				}
			}
		}


		
		return "";
	}

	public String breadthFirstTraversal(Graph graph, String startVertexName) {
		clear();
		String result = "";
		Vertex start = graph.getVertex(startVertexName);
		if(start == null){
			return PATH_NOT_FIND;
		}
		queue.add(start);
		while(!queue.isEmpty()){
			Vertex curr = queue.poll();
			if(!visited.contains(curr.getName())){
				if(result.length() > 0){
					result += " ";
				}
				result += curr.getName();
			}
			visited.add(curr.getName());
			for(String adjacentName : curr.getAdjacentVertices()){
				if(!visited.contains(adjacentName)){
					queue.add(graph.getVertex(adjacentName));
				}
			}

		}
		
		return result.trim();
	}

	public String depthFirstTraversal(Graph graph, String startVertexName) {
		clear();
		String result = "";
		Vertex start = graph.getVertex(startVertexName);
		if(start == null){
			return PATH_NOT_FIND;
		}
		stack.push(start);
		result += start.getName();
		while(!stack.isEmpty()){
			Vertex curr = stack.peek();
			boolean hasUnvisitedNeighbor = false;
			for(String neighbor : curr.getAdjacentVertices()){
				if(!visited.contains(neighbor)){
					hasUnvisitedNeighbor = true;
					stack.push(graph.getVertex(neighbor));
					visited.add(neighbor);
					result += " " + neighbor;
					break;
				}
			}
			if(!hasUnvisitedNeighbor){
				stack.pop();
			}
		}
		
		return result.trim();
	}

	private Vertex findUnvisitedSuccessor(Vertex v, Graph graph){
		for(String neighbor : v.getAdjacentVertices()){
			if(!visited.contains(neighbor)){
				Vertex next = graph.getVertex(neighbor);
				return findUnvisitedSuccessor(next, graph);
			}
		}
		return v;
	}

	public String topologicalSort(Graph graph) {
		clear();
		String result = "";
		int n = graph.vertexCount();
		for(int i=0;i<n;i++){

			for(Vertex v : graph.getVertices()){
				if(visited.contains(v.getName())){
					continue;
				}
				Vertex next = findUnvisitedSuccessor(v, graph); 
				visited.add(next.getName());
				stack.push(next);
				break;
			}
		}

		while(!stack.isEmpty()){
			Vertex v = stack.pop();
			if(result.length() > 0){
				result += " ";
			}
			result += v.getName();
		}
		
		
		return result.trim();
	}

	public static void main(String[] args) throws IOException {
		Graph graph = new Graph("graphData5.csv");
		GraphAlgorithms graphAlgorithms = new GraphAlgorithms();

		System.out.println(graphAlgorithms.findShortestPath( graph, "CVG", "LAX"));
		System.out.println(graphAlgorithms.findShortestPath( graph, "CVG", "DEN"));
		System.out.println(graphAlgorithms.findShortestPath( graph, "CVG", "DFW"));
		System.out.println(graphAlgorithms.breadthFirstTraversal(graph, "CVG"));
		System.out.println(graphAlgorithms.depthFirstTraversal(graph, "CVG"));
		System.out.println(graphAlgorithms.topologicalSort(graph));

	}

	public class PathState implements Comparable {
		public Vertex vertex;
		public int totalPathWt;
		public String pathToThisVertex;

		public PathState(Vertex v, int wt, String path) {
			vertex = v;
			totalPathWt = wt;
			pathToThisVertex = path;
		}

		@Override
		public int compareTo(Object other) {
			if (this.totalPathWt < ((PathState) other).totalPathWt)
				return -1;
			else if (this.totalPathWt > ((PathState) other).totalPathWt)
				return 1;
			else
				return 0;
		}

		public String toString(){
			return "Shortest Path" + pathToThisVertex + "\n"
				+ "Total weight:" + totalPathWt;
		}
	}
}
