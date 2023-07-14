import 'package:flutter/material.dart';

import 'destinationDetails.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PlanData> travelPlans = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Suggestions'),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            child: IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.pushNamed(context, "/register");
              },
            ),
          ),
        ),
      ),
      body: Center(
        child: travelPlans.isNotEmpty
            ? ListView.builder(
                itemCount: travelPlans.length,
                itemBuilder: (context, index) {
                  final plan = travelPlans[index];
                  return Dismissible(
                    key: Key(plan.cityName),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        travelPlans.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${plan.cityName} deleted'),
                          action: SnackBarAction(
                            label: 'Undo',
                            onPressed: () {
                              setState(() {
                                travelPlans.insert(index, plan);
                              });
                            },
                          ),
                        ),
                      );
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    child: Container(
                      height: 200.0,
                      width: double.infinity,
                      child: Card(
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/${plan.cityName.toLowerCase()}.jpg',
                                fit: BoxFit.cover,
                                width: 250.0,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'City: ${plan.cityName}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      'Travel Companion: ${plan.travelCompanion?.toString().split('.').last ?? 'N/A'}',
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      'Adult Count: ${plan.adultCount}',
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      'Travel Days: ${plan.travelDays}',
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      'Travel Class: ${plan.travelClass?.toString().split('.').last ?? 'N/A'}',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.flight,
                    size: 80.0,
                    color: Colors.deepPurple[300],
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'No travel plan',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: () async {
                      final result = await Navigator.pushNamed(
                        context,
                        '/travelDestinations',
                      );
                      if (result != null) {
                        setState(() {
                          travelPlans.add(result as PlanData);
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 24.0,
                      ),
                      primary: Colors.deepPurple,
                    ),
                    child: Text(
                      'Get your plan now',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.explore),
        onPressed: () async {
          final result = await Navigator.pushNamed(
            context,
            '/travelDestinations',
          );
          if (result != null) {
            setState(() {
              travelPlans.add(result as PlanData);
            });
          }
        },
      ),
    );
  }
}
