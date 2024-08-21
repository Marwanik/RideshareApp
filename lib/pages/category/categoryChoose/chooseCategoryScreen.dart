import 'package:flutter/material.dart';
import 'package:rideshare/pages/category/selectAvaiableBike/avaiableBikeScreen.dart';

class SelectBiketScreen extends StatefulWidget {
  @override
  _SelectBiketScreenState createState() => _SelectBiketScreenState();
}

class _SelectBiketScreenState extends State<SelectBiketScreen> {
  String? selectedTransport;  // To keep track of the selected transport option

  final List<Map<String, dynamic>> transportOptions = [
    {"title": "Car", "icon": Icons.directions_car, "id": "car"},
    {"title": "Bike", "icon": Icons.motorcycle, "id": "bike"},
    {"title": "Cycle", "icon": Icons.directions_bike, "id": "cycle"},
    {"title": "Taxi", "icon": Icons.local_taxi, "id": "taxi"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select transport'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select your transport',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: transportOptions.length,
                itemBuilder: (context, index) {
                  final transport = transportOptions[index];
                  final isSelected = selectedTransport == transport['id'];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTransport = transport['id'];
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>CarSelectionScreen(),)
                      );


                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(
                          color: isSelected ? Colors.green : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      color: isSelected ? Colors.green.shade50 : Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            transport['icon'],
                            size: 50,
                            color: isSelected ? Colors.green : Colors.black,
                          ),
                          SizedBox(height: 10),
                          Text(
                            transport['title'],
                            style: TextStyle(
                              fontSize: 18,
                              color: isSelected ? Colors.green : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}