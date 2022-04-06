#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

#include <ctype.h>
#include <string.h>

// all the basic data structures and functions are included in this template
// you can add your own auxiliary functions as you like 

// data type for avl tree nodes
typedef struct AVLTreeNode {
	int key; //key of this item
	int  value;  //value (int) of this item 
	int height; //height of the subtree rooted at this node
	struct AVLTreeNode *parent; //pointer to parent
	struct AVLTreeNode *left; //pointer to left child
	struct AVLTreeNode *right; //pointer to right child
} AVLTreeNode;

//data type for AVL trees
typedef struct AVLTree{
	int  size;      // count of items in avl tree
	AVLTreeNode *root; // root
} AVLTree;

int SIZE = 20;
void rightRotate(AVLTreeNode *node);
void leftRotate(AVLTreeNode *node);
int h(AVLTreeNode *node); // return node's height
int b(AVLTreeNode *node); // return node's balance
int compare(AVLTreeNode *n1, AVLTreeNode *n2); 
int cmpArr(char* s1, char s2[]); // return 0 equal 1 not-equal
void readInput(char* hint, char* input);
void clearChars(char arr[], int n); 
int parseLine(char *line, AVLTree *tree);  // parse line of data
void updateHeight(AVLTreeNode *node);
void insertFix(AVLTree *T, AVLTreeNode *parent, AVLTreeNode *node);
AVLTreeNode *findMin(AVLTreeNode *node); // find min node in param node's subtree
AVLTreeNode *findMax(AVLTreeNode *node); // find max node in param node's subtree
void replaceNode(AVLTreeNode *oldNode, AVLTreeNode *newNode); // replace node
void parentBreak(AVLTreeNode *node); // delete node from parent
AVLTreeNode *Search(AVLTree *T, int k, int v);
void PrintAVLTree(AVLTree *T);
int InsertToNode(AVLTree *T, AVLTreeNode *root, AVLTreeNode *node);
int InsertNode(AVLTree *T, int k, int v);
void PrintLayAVLTree(AVLTree *T);

// create a new AVLTreeNode
AVLTreeNode *newAVLTreeNode(int k, int v )
{
	AVLTreeNode *newNode;
	newNode = malloc(sizeof(AVLTreeNode));
	assert(newNode != NULL);
	newNode->key = k;
	newNode->value = v;
	newNode->height = 0; // height of this new node is set to 0
	newNode->left = NULL; // this node has no child
	newNode->right = NULL;
	newNode->parent = NULL; // no parent
	return newNode;
}

// create a new empty avl tree
AVLTree *newAVLTree()
{
	AVLTree *T;
	T = malloc(sizeof (AVLTree));
	assert (T != NULL);
	T->size = 0;
	T->root = NULL;
	return T;
}

// put your time complexity analysis of CreateAVLTree() here
// read time complexity O(1),  n*O(1) = O(n)
// insert time complexity O(logn(n)) , n*O(log(n)) = O(n*log(n))
// time complexity O(n log(n)) + O(n) = O(n log(n))
AVLTree *CreateAVLTree(const char *filename)
{
	// put your code here
	AVLTree *tree = newAVLTree();
	char buffer[200];
	if(strcmp(filename, "stdin") == 0){
		printf("Enter AVLTree node please:\n");
		gets(buffer);
		int valid = 1;
		while(strlen(buffer) > 0 && valid){

			if(parseLine(buffer, tree)){
				printf("Error format.  %s\n", buffer);
				break;
			}

			gets(buffer);
		}
	}else{
		FILE *fr; //file pointer
		fr = fopen (filename, "r");
		int count = 0;
		while ((fgets(buffer,100,fr)) != NULL){
			if(parseLine(buffer, tree)){
				printf("Error format.  %s\n", buffer);
				break;
			}
			// PrintAVLTree(tree);
		}
	}
	return tree;
  
}

// time complexity O(f(n)) = O(1) + 2*(O(f(n/2)))
// O(f(n)) = O(n)
AVLTreeNode *CloneAVLNode(AVLTreeNode *root){
	if(root == NULL) return NULL;
	AVLTreeNode *node = newAVLTreeNode(root->key, root->value);
	node->height = root->height;
	node->left = CloneAVLNode(root->left);
	node->right = CloneAVLNode(root->right);
	return node;
}

// put your time complexity analysis for CloneAVLTree() here
// time complexity O(1) + O(n) = O(n)
AVLTree *CloneAVLTree(AVLTree *T)
{
	// put your code here
	if(!T) return NULL;
	AVLTree *tree = newAVLTree();
	tree->root = CloneAVLNode(T->root);
	return tree;
}

// insert src's all subtree node into r
// time complexity O(f(n)) = O(1) + 2*(O(f(n/2)))
// O(f(n)) = O(n)
void InsertAllTreeNode(AVLTree *T, AVLTreeNode *src){
	if(!src) return;
	InsertNode(T, src->key, src->value);
	// printf("node is %d %d \n", src->key, src->value);
	// PrintLayAVLTree(T);
	InsertAllTreeNode(T, src->left);
	InsertAllTreeNode(T, src->right);
}
// put your time complexity for ALVTreesUNion() here
// time complexity CloneAVLTree is O(n)
// time complexity InsertAllTreeNode is O(m)
// time complexity total is O(n) + O(m) = O(n+m)
AVLTree *AVLTreesUnion(AVLTree *T1, AVLTree *T2)
{
	//put your code here
	AVLTree *tree = CloneAVLTree(T1);
	InsertAllTreeNode(tree, T2->root);
	return tree;
}

// time complexity O(n log(n))
void InsertIntersectionNode(AVLTree *tree, AVLTree *T1, AVLTreeNode *root){
	if(!T1 || !root) return;
	AVLTreeNode *node = Search(T1, root->key, root->value);
	if(node != NULL){
		InsertNode(tree, node->key, node->value);
	}
	InsertIntersectionNode(tree, T1, root->left);
	InsertIntersectionNode(tree, T1, root->right);
}
 
// put your time complexity for ALVTreesIntersection() here
// time complexity O(1) + O(n log(n)) = O(n log(n))
AVLTree *AVLTreesIntersection(AVLTree *T1, AVLTree *T2)
{
	//put your code here
	AVLTree *tree = newAVLTree();
	if(!T1 || !T2) return tree;
	InsertIntersectionNode(tree, T1, T2->root);
	return tree;
}

// p parent n node
// time complexity O(log(n))
void insertFix(AVLTree *T, AVLTreeNode *p, AVLTreeNode *n){
	if(!p || !p->parent) return;
	AVLTreeNode *g = p->parent;
	int bg = b(g);
	if(p == g->left){
		if(bg == 0) return;
		if(bg == -1){
			insertFix(T, g, p);
		}
		if(bg == -2){
			if(p->left == n){
				if(!g->parent) T->root = g->left;
				rightRotate(g);
			}else{
				if(!g->parent) T->root = g->left->right;
				leftRotate(p);
				rightRotate(g);
			}
		}
	}else{
		if(bg == 0) return;
		if(bg == 1){
			insertFix(T, g, p);
		}
		if(bg == 2){
			if(p->right == n){
				if(!g->parent) T->root = g->right;
				leftRotate(g);
			}else{
				if(!g->parent) T->root = g->right->left;
				rightRotate(p);
				leftRotate(g);
			}
		}
	}

}

// time complexity O(log(n))
int InsertToNode(AVLTree *T, AVLTreeNode *root, AVLTreeNode *node){
	int cmp = compare(root, node);
	int res = 0;
	// printf("insert to node debug 01 root %d v %d node %d v %d\n", root->key, root->value, node->key, node->value);
	if(cmp == 1){
		if(root->left == NULL){
			root->left = node;
			node->parent = root;
			updateHeight(root);
			res = 1;
			if(b(root) != 0){
				insertFix(T, root, node);
			}
		}else{
			res = InsertToNode(T, root->left, node);
		}
	}else if(cmp == -1){
		if(root->right == NULL){
			root->right = node;
			node->parent =root;
			updateHeight(root);
			res = 1;
			
			if(b(root) != 0){
				insertFix(T, root, node);
			}
		}else{
			res = InsertToNode(T, root->right, node);
		}
	}
	return res;
}
// put the time complexity analysis for InsertNode() here   
// time complexity O(1) + O(log(n)) = O(log(n)) 
int InsertNode(AVLTree *T, int k, int v)
{
	//put your code here
	if(!T) T = newAVLTree();
	AVLTreeNode *node = newAVLTreeNode(k, v);
	if(!T->root){
		T->root = node;
		T->size = 1;
		return 1;
	}
	int res = InsertToNode(T, T->root, node);
	if(res){
		T->size += 1;
		return 1;
	}else{
		return 0;
	}
}

// time complexity O(log(n))
AVLTreeNode *deleteFromNode(AVLTree *T, AVLTreeNode *root, AVLTreeNode *node){
	if(!root) return NULL;
	if(compare(root, node) == 0){
		if(root->left && root->right){
			// use node from heigher subtree to replace
			if(h(root->left) > h(root->right)){
				AVLTreeNode *pre = findMax(root->left);
				root->key = pre->key;
				root->value = pre->value;
				root->left  = deleteFromNode(T, root->left, pre);
			}else{
				AVLTreeNode *succ = findMin(root->right);
				root->key = succ->key;
				root->value = succ->value;
				root->right = deleteFromNode(T, root->right, succ);
			}
		}else{
			
			AVLTreeNode *temp = root;
			
			AVLTreeNode *parent = root->parent;
			if(root->left){
				root = root->left;
			}else if(root->right){
				root = root->right;
			}else{
				return NULL;
			}
			updateHeight(parent);
			free(temp);
		}
	}else if(compare(root, node) == -1){
		root->right = deleteFromNode(T, root->right, node);
		// rebalance
		if(b(root) == -2){
			if(h(root->left->right) > h(root->left->left)){
				if(!root->parent) T->root = root->left->right;
				leftRotate(root->left);
				rightRotate(root);
				return root->parent;
			}else{
				if(!root->parent) T->root = root->left;
				rightRotate(root);
				return root->parent;
			}
		}

	}else{
		root->left = deleteFromNode(T, root->left, node);
		if(b(root) == 2){
			if(h(root->right->left) > h(root->right->right)){
				if(!root->parent) T->root = root->right->left;
				rightRotate(root->right);
				leftRotate(root);
				return root->parent;
			}else{
				if(!root->parent) T->root = root->right;
				leftRotate(root);
				return root->parent;
			}
		}
	}
	return root;
}
// put your time complexity for DeleteNode() here
// time complexity O(log(n)) + O(log(n)) = O(log(n))
int DeleteNode(AVLTree *T, int k, int v)
{
	// put your code here
	AVLTreeNode *node = Search(T, k, v);
	if(!node) return 0;
	// node is root
	T->root = deleteFromNode(T, T->root, node);
	return 1;
}

// search key value in node
// time complexity O(log(n))
AVLTreeNode *SearchNode(AVLTreeNode *r, AVLTreeNode *n){
	if(!r) return NULL;
	int cmp = compare(r, n);
	if(cmp == 0) return r;
	if(cmp == 1){
		return SearchNode(r->left, n);
	}else{
		return SearchNode(r->right, n);
	}
}
// put your time complexity analysis for Search() here
// time complexity O(1) + O(log(n)) = O(log(n))
AVLTreeNode *Search(AVLTree *T, int k, int v)
{
	// put your code here
	if(!T) return NULL;
	AVLTreeNode *node = newAVLTreeNode(k, v);
	return SearchNode(T->root, node);
}

// O(f(n)) = 2 * O(f(n/2)) + O(1)
// O(f(n)) = O(n)
void FreeAVLNode(AVLTreeNode *root){
	if(root == NULL){
		return;
	}
	FreeAVLNode(root->left);
	FreeAVLNode(root->right);
	free(root);
}
// put your time complexity analysis for freeAVLTree() here
// FreeAVLNode time complexity is O(n)
// so FreeAVLTree time complexity is O(n) + O(1) = O(n)
void FreeAVLTree(AVLTree *T)
{
	// put your code here	
	FreeAVLNode(T->root);
	free(T);
}
// O(f(n)) = 2 * O(f(n/2)) + O(1)
// O(f(n)) = O(n)
void PrintAVLNode(AVLTreeNode *root){
	if(root == NULL){
		return;
	}
	PrintAVLNode(root->left);
	// printf("(%d, %d) h %d\n", root->key, root->value, root->height);
	printf("(%d, %d)\n", root->key, root->value);
	PrintAVLNode(root->right);
}
// put your time complexity analysis for PrintAVLTree() here
// time complexity  O(n) + O(1) = O(n)
void PrintAVLTree(AVLTree *T)
{
	// put your code here
	if(!T) return;
	printf("Print AVLTree start ===========\n");
	PrintAVLNode(T->root);
	printf("Print AVLTree end =======================\n");
}

void PrintLayAVLNode(AVLTreeNode *root, int level, char *pre){
	if(root == NULL){
		return;
	}
	PrintLayAVLNode(root->right, level + 1, "/");
	for(int i=0;i<level;i++){
		printf("        ");
	}
	printf("%s(%d, %d)\n", pre, root->key, root->value);
	PrintLayAVLNode(root->left, level + 1, "\\");
}
void PrintLayAVLTree(AVLTree *T)
{
	// put your code here
	if(!T) return;
	printf("Print pre AVLTree start ===========\n");
	PrintLayAVLNode(T->root, 0, "");
	printf("Print pre AVLTree end =======================\n");
}

void rightRotate(AVLTreeNode *x){
	if(x->parent != NULL){
		if(x->parent->left 
		&& x->parent->left->key == x->key 
		&& x->parent->left->value == x->value){
			x->parent->left = x->left;
		}else{
			x->parent->right = x->left;
		}
	}
	x->left->parent = x->parent;

	x->parent = x->left;

	x->left = x->parent->right;
	if(x->left){
		x->left->parent = x;
	}

	x->parent->right = x;
	updateHeight(x);
}

void leftRotate(AVLTreeNode *x){
	if(x->parent != NULL){
		if(x->parent->right 
		&& x->parent->right->key == x->key 
		&& x->parent->right->value == x->value){
			x->parent->right = x->right;
		}else{
			x->parent->left = x->right;
		}
	}
	x->right->parent = x->parent;

	x->parent = x->right;

	x->right = x->parent->left;
	if(x->right){
		x->right->parent = x;
	}


	x->parent->left = x;
	updateHeight(x);
}


// return node's height
int h(AVLTreeNode *node){
	if(!node) return -1;
	return node->height;
}
// return node's balance
int b(AVLTreeNode *node){
	if(!node) return 0;
	return h(node->right) - h(node->left);
}
// compare two node
int compare(AVLTreeNode *n1, AVLTreeNode *n2){
	if(n1->key != n2->key){
		return n1->key > n2->key ? 1 : -1;
	}
	if(n1->value != n2->value){
		return n1->value > n2->value ? 1 : -1;
	}
	return 0;
}
// read input line to a char[]
void readInput(char* hint, char* input){
  printf("%s", hint);

  fgets(input,200, stdin); // \n added
  
  // if (strlen(s) == 2 && strchr("edlsuqrcwnvpr", tolower(*s))) 
  // printf("len %d\n", strlen(s));
  input[strlen(input)-1] = '\0';
}

// return 0 equal 1 not-equal
int cmpArr(char* s1, char s2[]){
	char *s = s2;
	return strcmp(s1, s);
}

void clearChars(char arr[], int n){
	for(int i=0;i<n;i++){
		arr[i] = '\0';
	}
}

// return 0 normal  1 error
int parseLine(char *buffer, AVLTree *tree){
	int key, value;
	int valid = 1;

	int stage = 0;
	char num[20];

	for(int i=0;i<strlen(buffer);i++){
		char c = buffer[i];
		if(isspace(c)){
			continue;
		}
		if(stage == 0 && c != '('){
			valid = 0;
		}else if((stage == 1 || stage== 3)&&(c<'0' || c >'9')){
			if(stage == 1 && c == ','){
				stage = 2;
			}else if(stage == 3 && c == ')'){
				stage = 4;
			}else{
				if(strlen(num) == 0 && c == '-'){

				}else{
					valid = 0;
				}
			}
		}

		if(!valid){
			// printf("Error format. stage %d c %c\n", stage, c);
			return 1;
		}
		if(stage == 1 || stage == 3){
			num[strlen(num)] = c;
		}
		if(stage == 2){
			key = atoi(num);
		}
		if(stage == 4){
			value = atoi(num);
		}
		if(stage == 0 || stage == 2){
			clearChars(num, 20);
			stage++;
		}
		if(stage == 4){
			int inser = InsertNode(tree, key, value);
			stage = 0;
		}

	// printf("--]%c[--\n", buffer[i]);
	}
	return 0;
}

// update node height
void updateHeight(AVLTreeNode *node){
	if(!node) return;
	if(!node->left && !node->right){
		node->height = 0;
	}else if(h(node->left) > h(node->right)){
		node->height = h(node->left) + 1;
	}else{
		node->height = h(node->right) + 1;
	}
	updateHeight(node->parent);
}

// find min node in param node's subtree
AVLTreeNode *findMin(AVLTreeNode *node){
	if(!node) return NULL;
	AVLTreeNode *min = node;
	while(min->left){
		min = min->left;
	}
	return min;
}
// find max node in param node's subtree
AVLTreeNode *findMax(AVLTreeNode *node){
	if(!node) return NULL;
	AVLTreeNode *max = node;
	while(max->right){
		max = max->right;
	}
	return max;
}

// replace node
void replaceNode(AVLTreeNode *oldNode, AVLTreeNode *newNode){
	if(!oldNode || !newNode) return;
	AVLTreeNode *parent = oldNode->parent;
	if(parent){
		if(parent->left == oldNode){
			parent->left = newNode;
		}else{
			parent->right = newNode;
		}
	}
	newNode->left = oldNode->left;
	newNode->right = oldNode->right;
}

// delete node from parent
void parentBreak(AVLTreeNode *node){
	if(node && node->parent){
		if(node->parent->left == node){
			node->parent->left = NULL;
		}else{
			node->parent->right = NULL;
		}
	}
}

int main() //sample main for testing 
{ int i,j;
 AVLTree *tree1, *tree2, *tree3, *tree4, *tree5, *tree6, *tree7, *tree8;
 AVLTreeNode *node1;
 
 tree1=CreateAVLTree("stdin");
 PrintAVLTree(tree1);
 FreeAVLTree(tree1);
 //you need to create the text file file1.txt
 // to store a set of items without duplicate items
 tree2=CreateAVLTree("file1.txt"); 
 PrintAVLTree(tree2);
 tree3=CloneAVLTree(tree2);
 PrintAVLTree(tree3);
 FreeAVLTree(tree2);
 FreeAVLTree(tree3);
 //Create tree4 
 tree4=newAVLTree();
 j=InsertNode(tree4, 10, 10);
 for (i=0; i<15; i++)
  {
   j=InsertNode(tree4, i, i);
   if (j==0) printf("(%d, %d) already exists\n", i, i);
  }
  PrintAVLTree(tree4);
  node1=Search(tree4,20,20);
  if (node1!=NULL)
    printf("key= %d value= %d\n",node1->key,node1->value);
  else 
    printf("Key 20 does not exist\n");
  
  for (i=17; i>0; i--)
  {
    j=DeleteNode(tree4, i, i);
	if (j==0) 
	  printf("Key %d does not exist\n",i);  
    PrintAVLTree(tree4);
  }
 FreeAVLTree(tree4);
 //Create tree5
 tree5=newAVLTree();
 j=InsertNode(tree5, 6, 25);
 j=InsertNode(tree5, 6, 10);
 j=InsertNode(tree5, 6, 12);
 j=InsertNode(tree5, 6, 20);
 j=InsertNode(tree5, 9, 25);
 j=InsertNode(tree5, 10, 25);
 PrintAVLTree(tree5);
 //Create tree6
 tree6=newAVLTree();
 j=InsertNode(tree6, 6, 25);
 j=InsertNode(tree6, 5, 10);
 j=InsertNode(tree6, 6, 12);
 j=InsertNode(tree6, 6, 20);
 j=InsertNode(tree6, 8, 35);
 j=InsertNode(tree6, 10, 25);
 PrintAVLTree(tree6);
 tree7=AVLTreesIntersection(tree5, tree6);
 tree8=AVLTreesUnion(tree5,tree6);
 PrintAVLTree(tree7);
 PrintAVLTree(tree8);
 return 0; 
}
