
/**
 * 取中间坐标，分为两块。  对两块递归调用归并排序。  
 * 
 * 这样就假设两段是排好序的。 然后从两段中比较，挑较小的往新空间中塞就可以了。  
 */
public class MergeSort {
    public static int[] sort(int[] input){
        return mergeSort(input, 0, input.length-1);
    }

    /**
     * 使用递归的 merge sort
     * merge sort 排序下标从 start 到 end 的一段
     * @param arr
     * @param start
     * @param end
     */
    private static int[] mergeSort(int[] arr, int start, int end){
        if(start == end){
            return new int[]{arr[start]};
        }
        int center = start + (end - start)/2;
        int[] left = mergeSort(arr, start, center);
        int [] right = mergeSort(arr, center + 1, end);
        return merge(left, right);
    }

    /**
     * 合并从start 到 center 和从 center+1 到 end 的两段
     * @param arr
     * @param start
     * @param center
     * @param end
     */
    private static int[] merge(int[] left, int[] right){
        int[] result = new int[left.length + right.length];
        int i = 0;
        int j = 0;
        int k = 0;
        while(i < left.length && j < right.length){
            if(left[i] <= right[j]){
                result[k] = left[i];
                i++;
            }else{
                result[k] = right[j];
                j++;
            }
            k++;
        }
        while(i<left.length){
            result[k] = left[i];
            i++;
            k++;
        }
        while(j<right.length){
            result[k++] = right[j++];
        }
        return result;
    }


    public static void main(String[] args) {
        int[] a = new int[]{1,2,3,4,5,6};
        int[] b = new int[]{11,12,13,14,15,16,17,18};
        int[] c = merge(a, b);
        for(int i : c){
            System.out.print(i + " ");
        }
    }
}
