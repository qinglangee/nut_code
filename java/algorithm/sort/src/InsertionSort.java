import java.util.Arrays;
/**
 * 从开头遍历数组，遍历到的元素之前的都是排好序的部分，
 * 把当前的元素在前面找到排好序的位置放进去，
 * 接着向下遍历，直到最后就排好序了。  
 */
public class InsertionSort {
    public static int[] sort(int[] input){
        int[] arr = Arrays.copyOf(input, input.length);
        for(int i=1;i<arr.length;i++){
            for(int j=0;j<i;j++){
                if(arr[j] > arr[i]){
                    int temp = arr[i];
                    for(int k=i;k>j;k--){
                        arr[k] = arr[k-1];
                    }
                    arr[j] = temp;
                    break;
                }
            }
        }
        return arr;
    }


    public static void main(String[] args) {
        int[] arr = new int[]{2,1,3,5,4,6,8,7,9};
        Main.printArr(sort(arr));
    }
}
