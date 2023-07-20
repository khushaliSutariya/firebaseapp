import 'package:flutter/material.dart';

class SearchScreens extends StatefulWidget {
  const SearchScreens({Key? key}) : super(key: key);

  @override
  State<SearchScreens> createState() => _SearchScreensState();
}

class _SearchScreensState extends State<SearchScreens> {
  List<int> numbers = [1, 2, 3, 4, 5];
  List<int>? mergedList;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController positionController = TextEditingController();
  final int m = 4;
  // void cutList() {
  //   String positionText = positionController.text;
  //   int cutPosition = int.tryParse(positionText) ?? -1;
  //
  //   if (cutPosition >= 0 && cutPosition < numbers.length) {
  //     List<int> cutList = numbers.sublist(cutPosition);
  //     print('Original List: $numbers');
  //     print('Cut List: $cutList');
  //     List<int> cutListA = numbers.sublist(0, cutPosition);
  //     print(cutListA);
  //     mergedList = cutList + cutListA;
  //     print("merge$mergedList");
  //   } else {
  //     print('Invalid cut position');
  //   }
  // }


  // void rotateArray(int n) {
  //   int length = m + numbers.length - m;
  //
  //   reverse(numbers, 0, m - 1);
  //   reverse(numbers, m, length - 1);
  //   reverse(numbers, 0, length - 1);
  // }
  //
  // void reverse(List<int> arr, int start, int end) {
  //   while (start < end) {
  //     int temp = arr[start];
  //     arr[start] = arr[end];
  //     arr[end] = temp;
  //     start++;
  //     end--;
  //   }
  // }

  // void rotateArray(List<dynamic> arr, int n) {
  //   int length = arr.length;
  //   n = n % length;
  //
  //   for (int i = 0; i < gcd(n, length); i++) {
  //     var temp = arr[i];
  //     int j = i;
  //     while (true) {
  //       int k = (j + n) % length;
  //       if (k == i) break;
  //       arr[j] = arr[k];
  //       j = k;
  //     }
  //     arr[j] = temp;
  //   }
  // }
  //
  // int gcd(int a, int b) {
  //   if (b == 0) return a;
  //
  //   return gcd(b, a % b);
  // }


  void data(){
    int x = numbers[m];
    print("x=======$x");
    int n = numbers.length;
    print("n=========$n");
    for(int index = 0;index<numbers.length;index++){
      print("numisxcv=========${numbers[index]}");
      numbers[index] = numbers[index] + x - 1;
      print("xxxxx=======$x");
      print("num=========${numbers[index]}");
      if (numbers[index] > n) {
        print("numbers=========${numbers[index]}");
        numbers[index] = numbers[index] - n;
        print("numindex=========${numbers[index]}");
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    // rotateArray(numbers, m);
    data();
    print("number-> $numbers");
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("List${numbers.toString()}"),
              const Text('Enter position:'),
              // TextFormField(
              //   controller: positionController,
              //   validator: (value) {
              //     if (value!.isEmpty) {
              //       return "Please enter your  number";
              //     } else if (value.length >= 4) {
              //       return "Please enter your valid number";
              //     }
              //   },
              //   decoration: const InputDecoration(border: OutlineInputBorder()),
              //   keyboardType: TextInputType.number,
              // ),
              // const SizedBox(
              //   height: 10.0,
              // ),
              // ElevatedButton(
              //     onPressed: () {
              //       if (_formKey.currentState!.validate()) {
              //        setState(() {
              //          cutList();
              //        });
              //       }
              //     },
              //     child: const Text("mergedList Submit")),
              // const SizedBox(height: 20),
              // ElevatedButton(
              //     onPressed: () {
              //       if (_formKey.currentState!.validate()) {
              //         String positionText = positionController.text;
              //         int cutPosition = int.tryParse(positionText) ?? -1;
              //
              //            rotateArray(cutPosition);
              //         // setState(() {
              //         //   numbers = numbers;
              //         // });
              //       }
              //     },
              //     // onPressed: rotated
              //     //     ? () {
              //     //         int position = int.parse(positionController.text);
              //     //         setState(() {
              //     //           rotateArray(position);
              //     //           rotated = false;
              //     //         });
              //     //       }
              //     //     : null,
              //     child: const Text("Submit")),
              const SizedBox(height: 20),

              // Text("mergedList${mergedList.toString()}"),
              // Text("List${numbers.toString()}"),
            ],
          ),
        ),
      ),
    );
  }
}
