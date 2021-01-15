import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  List<Point<int>> sampleCoordinates = [
    Point(-3, 3),
    Point(3, 3),
    Point(-6, 0),
    Point(0, 0),
    Point(3, 0),
    Point(-3, -3),
    Point(0, -3),
    Point(3, -3),
  ];

  List<int> sampleIntList = [4, 5, 6, 5, 6, 5, 8, 9];

  // Question 1 function
  int question1(List<Point> coordinates) {
    Map<int, List<Point>> _tempMap = {};
    int tempMapCount = 0;

    if (coordinates.length > 0) {
      for (int a = 0; a < coordinates.length; a++) {
        // Set the 1st coordinate
        Point _pointA = coordinates[a];

        for (int b = 0; b < coordinates.length; b++) {
          // Set the 2nd coordinate
          Point _pointB = coordinates[b];
          // Calculate the constant length
          double firstDistance = _pointA.distanceTo(_pointB);

          for (int c = 0; c < coordinates.length; c++) {
            // Logic
            // 3rd coordinate should not same as 2nd coordinate &
            // length between them should be same as constant length
            if (_pointB != coordinates[c] &&
                firstDistance == _pointA.distanceTo(coordinates[c])) {
              Point _pointC = coordinates[c];

              for (int d = 0; d < coordinates.length; d++) {
                // Logic
                // 4th coordinate shouldn't same as 1st, 2nd and 3rd coordinate
                // length between 4th and 3rd, 2nd and 4th should same as constant length
                if (coordinates[d] != _pointA &&
                    coordinates[d] != _pointB &&
                    coordinates[d] != _pointC &&
                    firstDistance == coordinates[d].distanceTo(_pointC) &&
                    firstDistance == coordinates[d].distanceTo(_pointB)) {
                  // print("_pointA: " + _pointA.toString());
                  // print("_pointB: " + _pointB.toString());
                  // print("_pointC: " + _pointC.toString());
                  // print("_pointD: " + coordinates[d].toString());

                  // Following logic to check if same set of coordinates exist or not
                  // If yes, then skip counting
                  // If no, then just add the count
                  if (_tempMap.isEmpty) {
                    List<Point> _tempList = [
                      _pointA,
                      _pointB,
                      _pointC,
                      coordinates[d]
                    ];
                    _tempMap[tempMapCount] = _tempList;
                    print("tempMapCount: " + tempMapCount.toString());
                    print("_pointA: " + _pointA.toString());
                    print("_pointB: " + _pointB.toString());
                    print("_pointC: " + _pointC.toString());
                    print("_pointD: " + coordinates[d].toString());
                  } else {
                    bool _isExist = false;
                    for (int x = 0; x < tempMapCount + 1; x++) {
                      if (_tempMap[x].contains(_pointA) &&
                          _tempMap[x].contains(_pointB) &&
                          _tempMap[x].contains(_pointC) &&
                          _tempMap[x].contains(coordinates[d])) {
                        _isExist = true;
                        break;
                      }
                    }
                    if (!_isExist) {
                      tempMapCount += 1;
                      List<Point> _tempList = [
                        _pointA,
                        _pointB,
                        _pointC,
                        coordinates[d]
                      ];
                      _tempMap[tempMapCount] = _tempList;
                      print("tempMapCount: " + tempMapCount.toString());
                      print("_pointA: " + _pointA.toString());
                      print("_pointB: " + _pointB.toString());
                      print("_pointC: " + _pointC.toString());
                      print("_pointD: " + coordinates[d].toString());
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    print("Total rectangle count: " + (tempMapCount + 1).toString());
    return tempMapCount + 1;
  }

  // Question 2 function
  int question2(List<int> inputList) {
    Map<int, int> _tempMap = {};

    for (int a = 0; a < inputList.length; a++) {
      if (_tempMap.containsKey(inputList[a])) {
        _tempMap[inputList[a]] += 1;
      } else {
        _tempMap[inputList[a]] = 1;
      }
    }

    _tempMap.forEach((key, value) {
      if (value == 1) {
        print("The unique value of this list is " + key.toString());
        return key;
      }
    });
  }

  // Question 3 function
  List<int> question3(List<int> inputList) {
    Map<int, int> _tempMap = {};

    List<int> _returnList = [];

    for (int a = 0; a < inputList.length; a++) {
      if (_tempMap.isEmpty) {
        _tempMap[inputList[a]] = 1;
      } else {
        if (_tempMap.containsKey(inputList[a]))
          _tempMap[inputList[a]] += 1;
        else {
          _tempMap[inputList[a]] = 1;
        }
      }
    }

    _tempMap.forEach((key, value) {
      if (value == 1) {
        print("There are unique values: " + key.toString());
        _returnList.add(key);
      }
    });

    return _returnList;
  }

  // Question 4 function
  int question4(int inputValue) {
    if (inputValue > 0) {
      String inputString = inputValue.toRadixString(2);

      List<String> cutList = inputString.split("");
      List<int> countList = [];

      int _count = 0;
      int _biggestGap = 0;

      for (int a = 0; a < cutList.length; a++) {
        if (cutList[a] == "1") {
          if (_count != 0) {
            countList.add(_count);
            _count = 0;
          }
        } else {
          _count += 1;
        }
      }

      if (countList.isNotEmpty) {
        for (int b = 0; b < countList.length; b++) {
          if (_biggestGap < countList[b]) {
            _biggestGap = countList[b];
          }
        }
      }
      print("Binary of " + inputValue.toString() + " = " + inputString);
      print("Biggest Gap of " +
          inputValue.toString() +
          " is " +
          _biggestGap.toString());
      return _biggestGap;
    } else {
      return 0;
    }
  }

  //Question 5 Function
  List removeFromOrgChart(int inputValue) {
    var orgMapChart = [
      {
        "id": 1,
        "children": [
          {
            "id": 2,
            "children": [
              {
                "id": 4,
                "children": [
                  {"id": 6},
                  {"id": 7}
                ]
              }
            ]
          },
          {
            "id": 3,
            "children": [
              {
                "id": 5,
                "children": [
                  {"id": 8}
                ]
              }
            ]
          }
        ]
      }
    ];
    const positionIds = [1, 2, 3, 4, 5, 6, 7, 8];

    Map<String, List<int>> _newMap = {};
    List<int> _newList = [];

    List<Map<String, dynamic>> _tempMap = [];
    int _layerNumber = 0;
    bool _isMatch = false;

    // perform remove function
    for (int a1 = 0; a1 < orgMapChart.length; a1++) {
      Map<String, dynamic> firstLayer = orgMapChart[a1]; // 1
      if (firstLayer.containsKey("children")) {
        // First layer children
        List<Map<String, dynamic>> firstLayerChildren = firstLayer["children"];

        for (int b1 = 0; b1 < firstLayerChildren.length; b1++) {
          // First layer children = second layer
          Map<String, dynamic> secondLayer = firstLayerChildren[b1]; // 2, 3
          // Check if second layer contains key "id"
          if (secondLayer.containsKey("id")) {
            // If second layer "id" matched with input value
            if (secondLayer["id"] == inputValue) {
              // Get its associated list
              _tempMap = secondLayer["children"];
              // Get its position
              _layerNumber = b1;
              // Set isMatch to true
              _isMatch = true;
              break;
            }

            // If there is no match value in second layer
            // Continue to check input value in second layer children (third layer)
            List<Map<String, dynamic>> secondLayerChildren =
                secondLayer["children"];

            // If there is matched value in third layer
            // Same, get its associated children, get its position and set _isMatch to true
            for (int c1 = 0; c1 < secondLayerChildren.length; c1++) {
              Map<String, dynamic> thirdLayer = secondLayerChildren[c1]; // 4, 5
              if (thirdLayer.containsKey("id")) {
                if (thirdLayer["id"] == inputValue) {
                  if (thirdLayer.containsKey("children")) {
                    _tempMap = thirdLayer["children"];
                    _layerNumber = c1;
                    _isMatch = true;
                    break;
                  }
                }

                // If there is no match value in third layer
                // Continue to check in third layer children (fourth layer)
                List<Map<String, dynamic>> thirdLayerChildren =
                    thirdLayer["children"];

                // If there is matched value in fourth layer
                // As this layer is the last layer
                // Direct remove itself using its position
                for (int d1 = 0; d1 < thirdLayerChildren.length; d1++) {
                  Map<String, dynamic> fourthLayer = thirdLayerChildren[d1];
                  if (fourthLayer.containsKey("id")) {
                    if (fourthLayer["id"] == inputValue) {
                      _layerNumber = d1;
                      _isMatch = true;
                      break;
                    }
                  }
                }

                // Perform deletion using its position
                if (_isMatch) {
                  thirdLayerChildren.removeAt(_layerNumber);
                  _isMatch = false;
                }
              }
            }

            // If there is matched value in second layer children (third layer)
            // Check if its associated children exist
            // If yes, remove itself and add in the associated children
            // If no, then directly remove itself using the its position that set before
            if (_isMatch) {
              if (_tempMap.isNotEmpty) {
                secondLayerChildren.removeAt(_layerNumber);
                for (int z1 = 0; z1 < _tempMap.length; z1++) {
                  secondLayerChildren.add(_tempMap[z1]);
                }
              } else {
                secondLayerChildren.remove(_layerNumber);
              }
              _isMatch = false;
            }
          }
        }

        // If there is value match in first layer children(second layer)
        // Perform tempMap replacement on the matched value position
        // And then set isMatch to false
        if (_isMatch) {
          for (int z1 = 0; z1 < _tempMap.length; z1++) {
            firstLayerChildren[_layerNumber] = _tempMap[z1];
          }
          _isMatch = false;
        }
      }
    }

    print("updated modified org chart: " + orgMapChart.toString());

    // Print out position id list
    for (int a = 0; a < orgMapChart.length; a++) {
      Map<String, dynamic> firstLayer = orgMapChart[a];
      if (firstLayer.containsKey("id")) {
        if (_newMap.containsKey("firstLayer"))
          _newMap["firstLayer"].add(firstLayer["id"]);
        else
          _newMap["firstLayer"] = [firstLayer["id"]];
      }

      // Check if 1st layer contains children
      if (firstLayer.containsKey("children")) {
        List<Map<String, dynamic>> firstLayerChildren = firstLayer["children"];

        for (int b = 0; b < firstLayerChildren.length; b++) {
          Map<String, dynamic> secondLayer = firstLayerChildren[b];
          if (_newMap.containsKey("secondLayer"))
            _newMap["secondLayer"].add(secondLayer["id"]);
          else
            _newMap["secondLayer"] = [secondLayer["id"]];

          // Check if 2nd layer contains children
          if (secondLayer.containsKey("children")) {
            List<Map<String, dynamic>> secondLayerChildren =
                secondLayer["children"];
            for (int b = 0; b < secondLayerChildren.length; b++) {
              Map<String, dynamic> thirdLayer = secondLayerChildren[b];
              if (_newMap.containsKey("thirdLayer"))
                _newMap["thirdLayer"].add(thirdLayer["id"]);
              else
                _newMap["thirdLayer"] = [thirdLayer["id"]];

              if (thirdLayer.containsKey("children")) {
                List<Map<String, dynamic>> thirdLayerChildren =
                    thirdLayer["children"];
                for (int b = 0; b < thirdLayerChildren.length; b++) {
                  Map<String, dynamic> fourthLayer = thirdLayerChildren[b];
                  if (_newMap.containsKey("fourthLayer"))
                    _newMap["fourthLayer"].add(fourthLayer["id"]);
                  else
                    _newMap["fourthLayer"] = [fourthLayer["id"]];
                }
              }
            }
          }
        }
      }
    }

    _newMap.forEach((key, value) {
      for (int y = 0; y < value.length; y++) {
        _newList.add(value[y]);
      }
    });

    print("question 5 function: " + _newList.toString());
    return _newList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(child: Text('Please refer main.dart source code')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => removeFromOrgChart(8),
        child: Icon(Icons.add),
      ),
    );
  }
}
