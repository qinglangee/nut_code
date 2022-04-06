import java.util.Arrays;

/**
 * 冒泡排序
 * 每一轮遍历都是比较相邻的两个，把大的往后面移动到后面。 
 */
public class BubbleSort{
    public static int[] sort(int[] input){
        int[] arr = Arrays.copyOf(input, input.length);

        for(int i=0;i<arr.length-1;i++){
            for(int j=0;j<arr.length-1-i;j++){
                if(arr[j]>arr[j+1]){
                    int temp = arr[j];
                    arr[j] = arr[j+1];
                    arr[j+1] = temp;
                }
            }
        }
        return arr;
    }
}