import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class ProfileScreens extends StatefulWidget {
  const ProfileScreens({Key? key}) : super(key: key);

  @override
  State<ProfileScreens> createState() => _ProfileScreensState();
}

class _ProfileScreensState extends State<ProfileScreens> {
  List<int> numbers = [1, 2, 1, 2, 1, 1, 3, 3, 4, 5, 1];
  Map<String, int> map = {};
  @override
  void initState() {
    super.initState();
    map = getNumberCount(numbers);
  }

  Map<String, int> getNumberCount(List<int> numbers) {
    var groupedMap = groupBy(numbers, (number) => number.toString());
    var resultMap = groupedMap.map((key, value) => MapEntry(key, value.length));
    return resultMap;
  }
  @override
  Widget build(BuildContext context) {
    print("map$map");
    return  Scaffold(
      body: Column(children: [
        const Text('Number Count:', style: TextStyle(fontSize: 20)),
        const SizedBox(height: 10),
        Text(map.toString(), style: const TextStyle(fontSize: 16)),
      ]),
    );
  }
}
