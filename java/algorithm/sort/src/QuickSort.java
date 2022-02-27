import java.util.Arrays;
/**
 * 随便取一个数flag，比它小的放左边，比它大的放右边。  
 * 然后对两边分别递归调用。  
 * 关键点，比较时i从前往后，j要从后面往前数，一直比较到i j 相遇为一轮。
 */
public class QuickSort {
    
    public static int[] sort(int[] input){
        int[] arr = Arrays.copyOf(input, input.length);
        sort(arr, 0, arr.length - 1);
        return arr;
    }

    private static void sort(int[] arr, int start, int end){
        if(start >= end){
            return;
        }
        int flag = arr[start];
        int i = start;
        int j = end;
        while(i<j){
            while(arr[j]>=flag && i<j){
                j--;
            }
            arr[i] = arr[j];
            while(arr[i]<=flag && i<j){
                i++;
            }
            arr[j] = arr[i];
        }
        arr[i] = flag;
        sort(arr, start, i-1);
        sort(arr, i+1, end);
    }

    public static void main(String[] args) {
        int[] a = new int[]{3,5,6,8,1,3,7,9,4,10};
        Main.printArr(a);
        Main.printArr(sort(a));
    }
}
