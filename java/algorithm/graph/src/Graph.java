import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.Scanner;
import java.util.Set;
import java.util.TreeSet;

/**
 * <h1>Graph Class</h1>
 * @author Prof. Jim Kiper, PhD
 * @date November 6, 2020
 * Department of Computer Science and Software Engineering
 * CSE 274 Data Abstractions and Data Structures
 *
 * This class implements the GraphInterface that specifies the operations to create and modify graphs
 * This class uses the Vertex class
 */

public class Graph implements GraphInterface {

	private Set<Vertex> vertices;

	public Set<Vertex> getVertices() {
		return vertices;
	}

	@Override
	public boolean isEmpty() {
		return vertices.isEmpty();
	}

	@Override
	public int vertexCount() {
		return vertices.size();
	}

	@Override
	public int edgeCount() {
		int count = 0;
		for (Vertex vertex : vertices) {
			count += vertex.getAdjacentVertices().size();
		}
		return count;
	}

	@Override
	public boolean addVertex(Vertex vertex) {

		if (vertex == null)
			return false;
		return vertices.add(vertex);
	}

	@Override
	public boolean removeVertex(Vertex vertex) {

		if (vertex == null)
			return false;
		return vertices.remove(vertex);
	}

	@Override
	public boolean addEdge(Vertex vertex1, Vertex vertex2) {

		if (vertex1 == null || vertex2 == null || vertex1.equals(vertex2))
			return false;
		// adjacentVerticesWeighted is used with Dijjkstra's algorithm because edge weights
		// are needed to find the shortest path
		vertex1.getAdjacentVerticesWeighted().put(vertex2.getName(), vertex2.getWeight());
		// adjacentVertices is used for the other algorithms where weight is not needed.
		vertex1.getAdjacentVertices().add(vertex2.getName());
		return true;
	}

	@Override
	public Vertex getVertex(String n) {
		for (Vertex vertex : vertices) {
			if (vertex.getName().equals(n))
				return vertex;
		}
		return null;
	}

	@Override
	public boolean removeEdge(Vertex vertex1, Vertex vertex2) {
		if (vertex1 == null || vertex2 == null)
			return false;
		return vertex1.getAdjacentVertices().remove(vertex2);
	}

	@Override
	public boolean hasVertex(Vertex vertex) {
		if (vertex == null)
			return false;
		return (vertices.contains(vertex));
	}

	@Override
	public boolean hasEdge(Vertex vertex1, Vertex vertex2) {
		if (vertex1 == null || vertex2 == null)
			return false;
		return (vertex1.getAdjacentVertices().contains(vertex2));
	}

	public Graph(String filename) throws IOException {
		Scanner in = new Scanner(new File(filename));
		vertices = new TreeSet<Vertex>();

		// Read the vertices from the first line of the file
		String input = in.nextLine();
		String[] line = input.split(",");
		for (String str : line) {
			vertices.add(new Vertex(str, 0));
		}
		// Now read the edges, one edge per line
		while (in.hasNextLine()) {
			input = in.nextLine();

			line = input.split(",");
			Vertex vertex = getVertex(line[0]);
			if (vertex != null) {
				Vertex vertex2 = getVertex(line[1]);
				vertex2.setWeight(Integer.parseInt(line[2]));
				addEdge(vertex, vertex2);
			}
		}
		in.close();
	}
	
	public static void main(String[] args) throws IOException {
		Graph graph = new Graph("graphData.csv");
		System.out.println("First way:");
		for (Vertex vertex : graph.vertices) {
			System.out.print(vertex.getName() + "\nadjacent vertices:");
			for (Map.Entry<String, Integer> entry : vertex.getAdjacentVerticesWeighted().entrySet()) {
				System.out.print("( " + entry.getKey() + ", " + entry.getValue() + " )\t");
			}
			System.out.println();
		}
		System.out.println("\n\nSecond way:");
		for (Vertex vertex : graph.vertices) {
			System.out.print(vertex.getName() + "\nadjacent vertices:\t");
			for (String vertexName : vertex.getAdjacentVertices()) {
				System.out.print( vertexName + "\t");
			}
			System.out.println();
		}

	}
}
