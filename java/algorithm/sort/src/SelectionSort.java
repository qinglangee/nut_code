import java.util.Arrays;

/**
 * 选择排序
 * 每一轮遍历都是记住最小的下标，遍历完把下标对应的交换到前面。 
 */
public class SelectionSort {
    
    public static int[] sort(int[] input){
        int[] arr = Arrays.copyOf(input, input.length);

        for(int i=0;i<arr.length-1;i++){
            int min = i;
            for(int j=i+1;j<arr.length;j++){
                if(arr[j]<arr[min]){
                    min = j;
                }
            }
            int temp = arr[i];
            arr[i] = arr[min];
            arr[min] = temp;
        }
        return arr;
    }
}
