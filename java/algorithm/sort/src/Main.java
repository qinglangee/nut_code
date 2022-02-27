
import java.util.*;
public class Main {

    public static Random r = new Random();

    public static int[] createData(int num){
        int[] arr = new int[num];
        int bound = num * 10;
        for(int i=0;i<num;i++){
            arr[i] = r.nextInt(bound);
        }
        return arr;
    }

    public static void printArr(int[] arr){
        System.out.println("print array ==============");
        for(int i=0;i<arr.length;i++){
            System.out.print(arr[i] + ",");
            if(i>0 && i%10==0){
                System.out.println();
            }
        }
        System.out.println();
    }

    public static boolean arrEqual(int[] arr1, int[] arr2){
        if(arr1.length != arr2.length){
            return false;
        }
        for(int i=0;i<arr1.length;i++){
            if(arr1[i] != arr2[i]){
                return false;
            }
        }
        return true;
    }

    public static boolean testSingelSort(int[] arr1, int[] arr2, String name){
        boolean equal =  arrEqual(arr1, arr2);
        if(!equal){
            System.out.println(name + " sort error");
        }
        return equal;
    }

    public static boolean testSort(int[] arr){
        int[] sorted = BubbleSort.sort(arr);
        boolean selection =  testSingelSort(sorted, SelectionSort.sort(arr), "Selection");
        boolean insertion =  testSingelSort(sorted, InsertionSort.sort(arr), "Selection");
        boolean merge =  testSingelSort(sorted, MergeSort.sort(arr), "Merge");
        boolean quick = testSingelSort(sorted, QuickSort.sort(arr), "Quick");
        return selection && insertion && merge && quick;
    }



    
    public static void main(String[] args) {
        
        boolean sort100 = testSort(createData(100));
        boolean sort1000 = testSort(createData(1000));
        boolean sort10000 = testSort(createData(10000));
        if(sort100 && sort1000 && sort10000){
            System.out.println("Every sort ok.");
        }else{
            System.out.println("Something wrong.");
        }
        

    }
}