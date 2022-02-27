public class MyBST  extends BinarySearchTree{

    /**
     * add a string value to the tree
     * @param s string to add
     */
    @Override
    public void addToTree(String s) {
        if(s == null){
            return;
        }
        TreeNode node = new TreeNode(s);
        if(root == null){
            root = node;
            return;
        }else{
            addToTree(root, s);
        }
    }

    /**
     * add string value to the tree
     * @param root root node of the tree
     * @param s string value
     */
    private void addToTree(TreeNode root, String s){
        if(root.getData().equals(s)){
            root.increment();
            return;
        }
        if(root.getData().compareTo(s) < 0){
            if(root.getRightNode() == null){
                root.setRightNode(new TreeNode(s));
            }else{
                addToTree(root.getRightNode(), s);
            }
        }else{
            if(root.getLeftNode() == null){
                root.setLeftNode(new TreeNode(s));
            }else{
                addToTree(root.getLeftNode(), s);
            }
        }
    }

    /**
     * find count of the string in the tree
     */
    @Override
    public int findCount(String s) {
        return findCount(root, s);
    }

    /**
     * find count of the string in the tree
     * @param node the root node of the tree
     * @param s the string to find
     * @return count of the string
     */
    private int findCount(TreeNode node, String s){
        while(node != null){
            if(node.getData().equals(s)){
                return node.getCount();
            }else if(node.getData().compareTo(s) < 0){
                return findCount(node.getRightNode(), s);
            }else{
                return findCount(node.getLeftNode(), s);
            }
        }
        return 0;
    }

    /** 
     * return in order of the tree
     */
    @Override
    public String inOrderToString() {
        Result res = inOrderToString(root);
        String result = res.str;
        result += "\n-------------------\n";
        result += "Total number of words is " + res.count;
        return result;
    }

    /**
     * 中序遍历二叉树
     * return in order of the tree
     * @param node the root of tht tree
     * @return
     */
    private Result inOrderToString(TreeNode node){
        if(node == null){
            return new Result("", 0);
        }

        Result leftRes = inOrderToString(node.getLeftNode());
        Result rightRes = inOrderToString(node.getRightNode());
        String str = "";
        int count = node.getCount();
        if(leftRes.count > 0){
            str += leftRes.str + ",";
            count += leftRes.count;
        }
        str += node.getData() + ":" + node.getCount();
        if(rightRes.count > 0){
            str += "," + rightRes.str;
            count += rightRes.count;
        }


        return new Result(str, count);
    }

    // 简单中序遍历
    public String inOrder(){
        return inOrder(root);
    }
    public String inOrder(TreeNode node){
        if(node == null){return "";}
        return inOrder(node.getLeftNode()) + "[" + node.getData() + "]" + inOrder(node.getRightNode());
    }
    // 简单前序遍历
    public String frontOrder(){
        return frontOrder(root);
    }
    public String frontOrder(TreeNode node){
        if(node == null){return "";}
        return "[" + node.getData() + "]" + frontOrder(node.getLeftNode()) + frontOrder(node.getRightNode());
    }
    // 简单后序遍历
    public String endOrder(){
        return endOrder(root);
    }
    public String endOrder(TreeNode node){
        if(node == null){return "";}
        return endOrder(node.getLeftNode()) + endOrder(node.getRightNode()) + "[" + node.getData() + "]";
    }

    @Override
    public int countTotalStrings() {
        Result res = inOrderToString(root);
        return res.count;
    }

    @Override
    public String max() {
        if(root == null){
            return null;
        }
        TreeNode node = root;
        while(node.getRightNode() != null){
            node = node.getRightNode();
        }
        return node.getData();
    }

    private class Result{
        public String str;
        public int count;
        public Result(String str, int count){
            this.str = str;
            this.count = count;
        }
    }
    
}
