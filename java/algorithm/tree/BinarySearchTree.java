/**
 * Abstract class for use with COMPX201 Assignment Three. This describes a
 * partial implementation of a binary search tree of Strings. The tree is sorted
 * by the property that all nodes to the left of the root are smaller and all
 * nodes to the right of the root are larger (where smaller and larger are
 * determined by standard alphabetic sorting, i.e. the natural ordering of
 * Strings as given by String.compareTo() method). The tree does not store
 * duplicates but the node class used provides a counter which can be used to
 * keep track of the number of times a word has been added to the tree. The
 * class contains an inner class called BSTNode which describes the nodes used
 * in the tree. There is no delete method provided by this implementation.
 *
 * @author Andrea Zanibellato
 *
 **/

public abstract class BinarySearchTree {

	protected TreeNode root;

	/**
	 * The single constructor takes no parameters and sets the root variable to null
	 *
	 **/
	public BinarySearchTree() {
		root = null;
	}

	/**
	 * The addToTree method takes a single String as a parameter and does one of two
	 * things. If the String is already stored in the tree it increments the counter
	 * of the node storing that String. If the String is not stored in the tree it
	 * adds it to the tree. The tree remains in sorted order after this method has
	 * been called.
	 *
	 * @param s the String to be stored
	 *
	 **/
	public abstract void addToTree(String s);

	/**
	 * Returns the count of the given String if the String is present in the tree,
	 * or returns 0 if the String is not present.
	 * 
	 * @param s the String to look for
	 * @return the count of the given String or 0 if the String is not in the list
	 **/
	public abstract int findCount(String s);

	/**
	 * The inOrderToString method performs an in-order traversal of the tree and returns
	 * one String containing the data and the count value for each node in order, 
	 * separated by commas. Output format must be of the type "string1:count1,string2:count2", 
	 * (no spaces) for example "apple:2,cat:1,dog:3".
	 * 
	 * @return a String containing all the data and count value of the tree in order
	 **/
	public abstract String inOrderToString();

	/**
	 * The countNodes method performs a traversal of the tree and returns the number
	 * of Strings in the tree - including their count. For example, if the tree contains
	 * a TreeNode with count 1 and a TreeNode with count 2 this method should return 3.
	 * The traversal order is not defined and should not matter.
	 * 
	 * @return an int representing the number of Strings in the tree
	 *
	 **/
	public abstract int countTotalStrings();
	
	
	/**
	 * Returns the biggest String contained in the tree, according to the tree order.
	 * @return The biggest String in the tree
	 */
	public abstract String max();

	/**
	 * Inner class for the nodes used in the tree. Each node stores two
	 * pieces of data, a String and an int. The int acts as a counter and records
	 * how many times the String has been added to a tree. Each node has two
	 * references to a left and right TreeNode which provide the necessary links for
	 * the tree.
	 **/
	protected class TreeNode {

		private String data;
		private int count;

		private TreeNode leftNode;
		private TreeNode rightNode;

		/**
		 * Builds a TreeNode containing the given String and count 1.
		 * @param s The String to be contained in the Node
		 */
		public TreeNode(String s) {
			this.data = s;
			this.count = 1;
			this.leftNode = null;
			this.rightNode = null;
		}

		/**
		 * Increments the counter of the node
		 */
		public void increment() {
			count++;
		}
		
		/**
		 * Decrements the counter of the node
		 */
		public void decrement() {
			count--;
		}

		public int getCount() {
			return count;
		}

		public String getData() {
			return data;
		}

		public TreeNode getLeftNode() {
			return this.leftNode;
		}

		public void setLeftNode(TreeNode left) {
			this.leftNode = left;
		}

		public TreeNode getRightNode() {
			return rightNode;
		}
 
		public void setRightNode(TreeNode right) {
			this.rightNode = right;
		}

	}

}