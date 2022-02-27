import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.TreeSet;

public class Vertex implements Comparable{
	private String name;
	private int weight;
	private Map<String, Integer> adjacentVerticesWeighted;
	private Set<String> adjacentVertices;
	
	public Vertex( String name, int wt) {
		this.name = name;
		this.weight = wt;
		this.adjacentVerticesWeighted = new TreeMap<String, Integer>();
		this.adjacentVertices = new TreeSet<String>();
	}
	
	public Vertex( Vertex v) {
		this.name = v.name;
		this.weight = v.weight;
		this.adjacentVerticesWeighted = new TreeMap<String, Integer>();
		for ( Map.Entry<String, Integer> entry : v.adjacentVerticesWeighted.entrySet()) {
			this.adjacentVerticesWeighted.put(entry.getKey(), entry.getValue());
		}
		this.adjacentVertices = new TreeSet<String>();
		for ( String vertexName : v.adjacentVertices) {
			this.adjacentVertices.add(vertexName);
		}
	}
	
	public String getName() {
		return name;
	}
	
	public int getWeight() {
		return weight;
	}
	
	public void setWeight(int wt) {
		weight = wt;
	}
	
	public Map<String, Integer> getAdjacentVerticesWeighted() {
		return adjacentVerticesWeighted;
	}
	
	public Set<String> getAdjacentVertices() {
		return adjacentVertices;
	}
	
	public boolean equals( Object other ) {
		if ( other == this ) 
			return true;
		else if ( other == null || other.getClass() != this.getClass())
			return false;
		return this.name.equals( ((Vertex) other).name);
	}
	
	@Override
	public int compareTo(Object other) {

		return this.name.compareTo( ((Vertex) other).name);
	}
	

}
