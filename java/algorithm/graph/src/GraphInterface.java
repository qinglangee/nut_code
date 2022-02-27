/**
 * <h1>Graph API Interface</h1>
 * @author Prof. JNorm Krumpe
 * Department of Computer Science and Software Engineering
 * CSE 274 Data Abstractions and Data Structures
 *
 * This interface specifies the operations to create and modify graphs
 */

public interface GraphInterface {

	/**
	 * Adds a vertex to this graph, associating object with vertex. returns true if
	 * the vertex was added, and false otherwise
	 */
	public boolean addVertex(Vertex verVertexex);

	/**
	 * Removes a single vertex with the given value from this graph. returns true if
	 * the vertex was removed, and false otherwise
	 */
	public boolean removeVertex(Vertex vertex);

	/**
	 * Inserts an edge between two pre-existing different vertices of this graph.
	 * returns true if the edge was added, and false otherwise
	 */
	public boolean addEdge(Vertex vertex1, Vertex vertex2);
	
	/**
	 * Returns a Vertex from the set of vertices that has the name equal to the parameter
	 * and null if there is no Vertex with that name.
	 */
	public Vertex getVertex( String name);

	/**
	 * Removes an edge between two pre-existing vertices of this graph. returns true
	 * if the edge was removed, and false otherwise.
	 */
	public boolean removeEdge(Vertex vertex1, Vertex vertex2);

	/**
	 * Returns true if the specified vertex exists, and false otherwise
	 */
	public boolean hasVertex(Vertex vertex);

	/**
	 * Returns true if an edge exists between the specified vertices, and false
	 * otherwise
	 */
	public boolean hasEdge(Vertex vertex1, Vertex vertex2);

	/** Returns true if this graph is empty (no vertices), false otherwise. */
	public boolean isEmpty();

	/**
	 * Returns the number of vertices in this graph.
	 * @returns the number of vertices
	 */
	public int vertexCount();

	/**
	 * Returns the number of vertices in this graph.
	 * @returns the number of vertices
	 */
	public int edgeCount();

	/** Returns a string representation of the graph. */
	public String toString();
}
