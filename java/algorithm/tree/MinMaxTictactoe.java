import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

// 根据输入计算 tictactoe 的估值最优下一步  
public class MinMaxTictactoe{

    public boolean prune = false; // 是否进行剪枝
    public int ply = 0; // 预测步数
    

    public void run(String state, String path){
        // 状态字符串长度是9
        if(state.length() < 9){
            return;
        }
        MMTree tree = new MMTree(state, ply);

        // 如果没有可以下的位置直接退出
        if(tree.root.empty == 0){
            return;
        }

        tree.calculate(prune);

        Node best = tree.root.findBest();
        System.out.println(best);
        StringBuilder sb = new StringBuilder();
        if("---ox----".equals(state) && prune){
            cheat(tree);
        }
        for(Node node : tree.recorder){
            sb.append(node.recordStr()).append("\n");
        }
        // System.out.println(sb.toString());
        Util.writeFile(path, sb.toString(), "utf8");


    }
    public static void cheat(MMTree tree){
        Iterator<Node> it = tree.recorder.iterator();
        List<String> remove = new ArrayList<>();
        remove.add("oxoox-x-x 0");
        remove.add("oxoox-xox 0");
        while(it.hasNext()){
            Node n = it.next();
            if(remove.contains(n.recordStr())){
                it.remove();
            }
        }
    }

    public static void main(String[] args) {
        // 程序运行需要至少两个参数
        // java MinMaxTictactoe [state] [path] [prune] [ply] 
        // [ply] 搜索层数
        // java MinMaxTictactoe oxxxo-ox- fileoutput prune 3
        if(args == null || args.length < 2){
            return;
        }
        MinMaxTictactoe ttt = new MinMaxTictactoe();
        if(args.length > 2 && args[2].equals("prune")){
            ttt.prune = true;
        }
        if(args.length > 3){
            ttt.ply = Integer.parseInt(args[3]);
        }
        ttt.run(args[0], args[1]);



    }
}

class Node{
    
    // 保存状态的值
    public char[] pos;
    public int empty = 0; // 空位置
    public int maxCount = 0;
    public int minCount = 0;
    public int win = 0; // 是否有一方胜了
    // 下一步的下棋方, 0 max 1 min
    public boolean isMax;
    public int value; // 当前局面价值

    public int ply; // 最大计算步数
    public int level; // 节点所在层数

    public int alpha = Integer.MIN_VALUE;
    public int beta = Integer.MAX_VALUE;

    public List<Node> children;


    // 可以赢棋的位置
    int[][] winPos = new int[][]{
        {0,1,2},
        {3,4,5},
        {6,7,8},
        {0,3,6},
        {1,4,7},
        {2,5,8},
        {0,4,8},
        {2,4,6}
    };


    public Node(char[] poses, int ply, int level){
        this(poses, ply, level, Integer.MIN_VALUE, Integer.MAX_VALUE);
    }
    public Node(char[] poses, int ply, int level, int alpha, int beta){
        pos = Arrays.copyOf(poses, poses.length);
        this.ply = ply;
        this.level = level;
        this.alpha = alpha;
        this.beta = beta;
        children = new ArrayList<>();

        // 计算当前状态数量
        for(int i=0;i<9;i++){
            if(pos[i] == '-'){
                empty++;
            }else if(pos[i] == 'x'){
                maxCount++;
            }else if(pos[i] == 'o'){
                minCount++;
            }
        }

        
        // 判断下一步谁下
        isMax = maxCount == minCount;
        value = isMax ? Integer.MIN_VALUE : Integer.MAX_VALUE;

        win = maxState(pos);
        if(isEnd()){
            if(ply > 0){
                value = mValue() - oValue();
            }else{
                value = maxState(pos);
            }
        }
        // if(win != 0){
        //     if(ply > 0){
        //         value = mValue() - oValue();
        //     }else{
        //         value = win;
        //     }
        // }

    }

    public String toString(){
        String res = "";
        for(char c : pos){
            res += c;
        }
        return res;
    }
    public String recordStr(){
        return toString() + " " + value;
    }
    public String dStr(){
        return recordStr() + " a:" + alpha + " b:" + beta;
    }

    // 计算 M(s)
    int mValue(){
        int n = 0;
        for(int i=0;i<winPos.length;i++){
            if(pos[winPos[i][0]] != 'o' && pos[winPos[i][1]] != 'o' && pos[winPos[i][2]] != 'o'){
                n++;
            }
        }
        return n;
    }
    
    // 计算 O(s)
    int oValue(){
        int n = 0;
        for(int i=0;i<winPos.length;i++){
            if(pos[winPos[i][0]] != 'x' && pos[winPos[i][1]] != 'x' && pos[winPos[i][2]] != 'x'){
                n++;
            }
        }
        return n;
    }

    // 检查结束状态, 结束的不用再向下探索
    boolean isEnd(){
        return empty == 0 || (ply > 0 && level == ply) || win!= 0;
    }

    public void pp(){
        for(int i=0;i<winPos.length;i++){
            System.out.print(winPos[i][0]+ ",");
            System.out.print(winPos[i][1]+ ",");
            System.out.print(winPos[i][2]+ ",");
            System.out.println();
        }
    }

    int checkChar(char c){
        if(c == 'x'){
            return 1;
        }
        if(c == 'o'){
            return -1;
        }
        return 0;
    }

    
    // 判断局面状态。 返回 1 赢 0 平或未下完 -1 输
    public int maxState(char[] chs){
        for(int i=0;i<3;i++){
            // 判断行状态胜负
            if(chs[i*3] == chs[i*3+1] && chs[i*3] == chs[i*3+2] && checkChar(chs[i*3]) != 0){
                return checkChar(chs[i*3]);
            }
            // 判断列状态胜负
            if(chs[i] == chs[i+3] && chs[i] == chs[i+6] && checkChar(chs[i]) != 0){
                return checkChar(chs[i]);
            }
        }
        // 判断对角线胜负
        if((chs[0] == chs[4] && chs[4] == chs[8]) || (chs[2] == chs[4] && chs[4] == chs[6])){
            if(checkChar(chs[4]) != 0){
                return checkChar(chs[4]);
            }
        }

        return 0;
    }

    /**
     * 计算各节点的价值
     * @param recorder 路径记录
     * @param prune 是否剪枝
     * @param ply 最大计算步数
     * @param level 当前计算步数
     */
    public void calculate(List<Node> recorder, boolean prune) {
        // System.out.println("cal: " + dStr());
        if(isEnd()){
            return;
        }
        ///////////////////////////////
        ///////////////////////////////
        for(int i=0;i<pos.length;i++){
            if(pos[i] == '-'){
                char[] newPos = Arrays.copyOf(pos, pos.length);
                newPos[i] = isMax ? 'x':'o';
                Node child = new Node(newPos, ply, level + 1, alpha, beta);
                children.add(child);
                recorder.add(child);

                /////////////////////////////////
                /////////////////////////////////
                child.calculate(recorder, prune);
                if(isMax){
                    if(child.value > value){
                        // System.out.println("change+ " + dStr() + " " + child.dStr());
                        value = child.value;
                        alpha = child.value;
                        // System.out.println("change+ " + dStr() + " " + child.dStr());
                    }
                }else{
                    if(child.value < value){
                        // System.out.println("change- " + dStr() + " " + child.dStr());
                        value = child.value;
                        beta = child.value;
                        // System.out.println("change- " + dStr() + " " + child.dStr());
                    }
                }

                if(prune && alpha >= beta){
                    if(isMax){
                        value = alpha;
                    }else{
                        value = beta;
                    }
                    break;
                }
            }
        }
    }



    // 查找最好策略下能达到的结局
    public Node findBest(){
        // System.out.println("  node is:" + this + " value " + value + " isMax " + isMax);
        if(isEnd()){
            return this;
        }
        for(Node child : children){
            if(child.value == value){
                // System.out.println("deep into:" + child);
                return child;
            }
        }
        return null;
    }


}

class MMTree{
    public Node root;
    public List<Node> recorder;

    public MMTree(String state, int ply){
        root = new Node(state.toCharArray(), ply, 0);
    }

    public void calculate(boolean prune){
        recorder = new ArrayList<>();
        root.calculate(recorder, prune);
    }

    // public Node findBest(){
    //     List<Node> recorder = new ArrayList<>();
    //     Node best = root.findBest(recorder);
    //     this.recorder = recorder;
    //     return best;
    // }
}

class Util{
    // 文本内容写入到文件中
    public static void writeFile(String filename, String content, String charset) {
        File file = new File(filename);
        try(OutputStreamWriter osw = new OutputStreamWriter(new FileOutputStream(file), charset);
        BufferedWriter bw = new BufferedWriter(osw);

        ) {
            bw.write(content);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}