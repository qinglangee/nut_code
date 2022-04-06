
// In the worst case, log2(n) + 1 comparisons needed on an array with n entries.
public class BinarySearch{

    static boolean found;
    static int counter;

    public static int binsearch(int key, int[] x, int i, int j){
        counter++;
        // System.out.println("key " + key + " i " + i + " j " + j);
        if(i == j){
            return i;
        }
        int half = (i + j) / 2;
        boolean equal = false;
        if(key == x[half]){
            // System.out.println(" i "+i+" j "+j);
            found = true;
            equal = true;
            if(half == i){
                return i;
            }
        }
        if(equal){
            int before = binsearch(key, x, i, half);
            return key == x[before] ? before : half;
        }else{
            if(key < x[half]){
                return binsearch(key, x, i, half);
            }else{
                return binsearch(key, x, half+1, j);
            }
        }
    }

    public static void insert(int key, int[] x){
        int index = binsearch(key, x, 0, x.length);
        for(int i=x.length - 1;i>index;i--){
            x[i] = x[i-1];
        }
        x[index] = key;
    }


    static void testSearch(int key, int[] x, int i, int j){
        found = false;
        counter = 0;
        int index = binsearch(key, x, i, j);
        if(found){
            System.out.print("Key " + key + " found at index " + index);
        }else{
            System.out.print("Key " + key + " not found, should be at index " + index);
        }
        System.out.println(", after " + counter + " binary search iterations.");
    }

    static void arrayInfo(int[] x){
        if(x.length < 20){
            
            for(int num : x){
                System.out.print(num + " ");
            }
            System.out.println();
        }else{
            
            for(int i=0;i<4;i++){
                System.out.print(x[i] + " ");
            }
            System.out.println("... " + x[x.length - 1]);;
        }
    }

    static void printArr(int[] x){
        for(int a : x){
            System.out.print(a + " ");
        }
        System.out.println();
    }

    public static void main(String[] args) {
        int size = 100000000;
        int[] arr1 = new int[]{7,7,10,23,42,42,42,51,60};
        int[] arr2 = new int[size];
        for(int i=0; i<size;i++){
            arr2[i] = i * 2 + 1;
        }
        int[] arr3 = new int[size];
        for(int i=0;i<size;i++){
            arr3[i] = 9;
        }
        System.out.print("Testing a small array: ");
        arrayInfo(arr1);
        testSearch(3, arr1, 0, arr1.length);
        testSearch(7, arr1, 0, arr1.length);
        testSearch(26, arr1, 0, arr1.length);
        testSearch(42, arr1, 0, arr1.length);
        testSearch(99, arr1, 0, arr1.length);
        System.out.print("Testing a large array with "+arr2.length+" entries: ");
        arrayInfo(arr2);
        testSearch(50000000, arr2, 0, arr2.length);
        testSearch(25000000, arr2, 0, arr2.length);
        testSearch(12500001, arr2, 0, arr2.length);
        System.out.print("Testing a large array with "+arr3.length+" identical entries: ");
        arrayInfo(arr3);
        testSearch(1, arr3, 0, arr3.length);
        testSearch(9, arr3, 0, arr3.length);
        testSearch(13, arr3, 0, arr3.length);

        // int[] arr4 = new int[]{1,2,3,4};
        // testSearch(1, arr4, 0, arr4.length);
        // printArr(arr1);
        // insert(8,arr1);
        // printArr(arr1);
        // insert(3,arr1);
        // printArr(arr1);
    }
}