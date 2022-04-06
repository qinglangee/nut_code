import java.io.File;
import java.util.Scanner;
public class TextTreeReader {
    
    public static void main(String[] args) {
        // String filename = args[0];
        String filename = "test.txt";
        try{

            Scanner f = new Scanner(new File(filename));
            String[] parts = f.nextLine().split("\\s+");
            MyBST tree = new MyBST();
            for(String str : parts){
                tree.addToTree(str);
            }
            System.out.println(tree.inOrderToString());

            MyBST tree2 = new MyBST();
            tree2.addToTree("d");
            tree2.addToTree("b");
            tree2.addToTree("a");
            tree2.addToTree("c");
            tree2.addToTree("f");
            tree2.addToTree("e");
            tree2.addToTree("g");
            System.out.println("Simple in order:" + tree2.inOrder());
            System.out.println("Simple front order:" + tree2.frontOrder());
            System.out.println("Simple end order:" + tree2.endOrder());
        }catch(Exception e){
            e.printStackTrace();
        }

    }
}
