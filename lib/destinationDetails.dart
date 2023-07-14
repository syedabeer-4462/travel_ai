import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_ai/circuar_widget/reusable_card.dart';
import 'package:table_calendar/table_calendar.dart';
import 'circuar_widget/constants.dart';
import 'circuar_widget/icon_content.dart';
import 'circuar_widget/rounded_icon_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DestinationDetailsScreen extends StatefulWidget {
  final String cityImage;
  final String cityName;

  const DestinationDetailsScreen({
    required this.cityImage,
    required this.cityName,
  });

  @override
  _DestinationDetailsScreenState createState() =>
      _DestinationDetailsScreenState();
}

enum TravelCompanion { single, couple, family, friends }

enum Travel_class { economy, normal, luxury }

enum Interest { History, Nature, Adventure, Art_Culture, Food, Entertainment }

class _DestinationDetailsScreenState extends State<DestinationDetailsScreen> {
  double _historicalLevel = 0;
  double _artCultureLevel = 0;
  double _natureLevel = 0;
  double _adventureLevel = 0;
  double _foodLevel = 0;
  double _entertainmentLevel = 0;

  int travelDays = 1;
  DateTime? startingDate;
  DateTime? endingDate;
  TravelCompanion? selectedCompanion;
  Travel_class? selectedClass;
  Set<Interest> selectedInterests = {};

  int adultCount = 2;

  void incrementDays() {
    if (startingDate != null) {
      setState(() {
        travelDays++;
        endingDate = startingDate!.add(Duration(days: travelDays - 1));
      });
    }
  }

  void decrementDays() {
    if (travelDays > 1 && startingDate != null) {
      setState(() {
        travelDays--;
        endingDate = startingDate!.add(Duration(days: travelDays - 1));
      });
    }
  }

  void selectCompanion(TravelCompanion companion) {
    setState(() {
      selectedCompanion = companion;
    });
  }

  void selectClass(Travel_class t_class) {
    setState(() {
      selectedClass = t_class;
    });
  }

  void incrementAdults() {
    setState(() {
      adultCount++;
    });
  }

  void decrementAdults() {
    if (adultCount > 1) {
      setState(() {
        adultCount--;
      });
    }
  }

  Future<void> _createPlan() async {
    // Show the loading screen dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SpinKitFadingCube(
                  color: Colors.blue,
                  size: 50.0,
                ),
                SizedBox(height: 16.0),
                Text(
                  'Creating Plan...',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
        );
      },
    );

    // Simulate some loading time
    await Future.delayed(Duration(seconds: 2));

    // Close the loading screen dialog
    Navigator.pop(context);
    Navigator.pop(context);

    // Resume the flow of navigation
    Navigator.pop(
      context,
      PlanData(
        cityName: widget.cityName,
        travelCompanion: selectedCompanion,
        adultCount: adultCount,
        travelDays: travelDays,
        travelClass: selectedClass,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                widget.cityImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          widget.cityName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 50.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Your Interests',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            InterestSlider(
                              title: 'Historical',
                              level: _historicalLevel,
                              onChanged: (level) {
                                setState(() {
                                  _historicalLevel = level;
                                });
                              },
                            ),
                            InterestSlider(
                              title: 'Nature',
                              level: _natureLevel,
                              onChanged: (level) {
                                setState(() {
                                  _natureLevel = level;
                                });
                              },
                            ),
                            InterestSlider(
                              title: 'Art and Culture',
                              level: _artCultureLevel,
                              onChanged: (level) {
                                setState(() {
                                  _artCultureLevel = level;
                                });
                              },
                            ),
                            InterestSlider(
                              title: 'Adventure',
                              level: _adventureLevel,
                              onChanged: (level) {
                                setState(() {
                                  _adventureLevel = level;
                                });
                              },
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              'Travel Days',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            ReusableCard(
                              colour: Colors.deepPurple,
                              childCard: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Travel Days',
                                      style: kLabelStyle,
                                    ),
                                    Text(
                                      "${travelDays} Day",
                                      style: kMainLabelStyle,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        RoundedIconButton(
                                          icon: Icons.remove,
                                          onPressed: () {
                                            setState(() {
                                              decrementDays();
                                            });
                                          },
                                        ),
                                        SizedBox(width: 10.0),
                                        RoundedIconButton(
                                          icon: Icons.add,
                                          onPressed: () {
                                            setState(() {
                                              incrementDays();
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {},
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              'Start Day',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            TableCalendar(
                              firstDay:
                                  DateTime.now().subtract(Duration(days: 365)),
                              lastDay: DateTime.now().add(Duration(days: 365)),
                              focusedDay: startingDate ?? DateTime.now(),
                              selectedDayPredicate: (day) =>
                                  startingDate != null &&
                                  endingDate != null &&
                                  day.isAfter(startingDate!
                                      .subtract(Duration(days: 1))) &&
                                  day.isBefore(
                                      endingDate!.add(Duration(days: 1))),
                              calendarFormat: CalendarFormat.month,
                              onDaySelected: (selectedDay, focusedDay) {
                                setState(() {
                                  startingDate = selectedDay;
                                  endingDate = selectedDay
                                      .add(Duration(days: travelDays - 1));
                                });
                              },
                              onPageChanged: (focusedDay) {
                                setState(() {
                                  startingDate = focusedDay;
                                  endingDate = focusedDay
                                      .add(Duration(days: travelDays - 1));
                                });
                              },
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              'Travel With',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            GridView.count(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              crossAxisCount: 2,
                              mainAxisSpacing: 10.0,
                              crossAxisSpacing: 10.0,
                              childAspectRatio: 1.5,
                              children: [
                                buildCompanionCard(
                                  TravelCompanion.single,
                                  'Single',
                                  Icons.person,
                                ),
                                buildCompanionCard(
                                  TravelCompanion.couple,
                                  'Couple',
                                  Icons.group,
                                ),
                                buildCompanionCard(
                                  TravelCompanion.family,
                                  'Family',
                                  Icons.family_restroom,
                                ),
                                buildCompanionCard(
                                  TravelCompanion.friends,
                                  'Friends',
                                  Icons.people,
                                ),
                              ],
                            ),
                            SizedBox(height: 16.0),
                            if (selectedCompanion != TravelCompanion.single)
                              Text(
                                'Number of Adults',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                            SizedBox(height: 8.0),
                            if (selectedCompanion != TravelCompanion.single)
                              ReusableCard(
                                colour: Colors.deepPurple,
                                childCard: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Adults',
                                        style: kLabelStyle,
                                      ),
                                      Text(
                                        "${adultCount}",
                                        style: kMainLabelStyle,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          RoundedIconButton(
                                            icon: Icons.remove,
                                            onPressed: () {
                                              setState(() {
                                                decrementAdults();
                                              });
                                            },
                                          ),
                                          SizedBox(width: 10.0),
                                          RoundedIconButton(
                                            icon: Icons.add,
                                            onPressed: () {
                                              setState(() {
                                                incrementAdults();
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {},
                              ),
                            SizedBox(height: 16.0),
                            Text(
                              'Your Budget',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            GridView.count(
                              shrinkWrap: true,
                              crossAxisCount: 3,
                              children: [
                                buildCompanionCard_class(
                                  Travel_class.economy,
                                  'Economy',
                                  Icons.eco_outlined,
                                ),
                                buildCompanionCard_class(
                                  Travel_class.normal,
                                  'Normal',
                                  Icons.currency_pound,
                                ),
                                buildCompanionCard_class(
                                  Travel_class.luxury,
                                  'Luxury',
                                  Icons.diamond_outlined,
                                ),
                              ],
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              'Your Interests',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Center(
                              child: ElevatedButton(
                                onPressed: _createPlan,
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
                                  'Create Plan',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCompanionCard(
      TravelCompanion companion, String title, IconData icon) {
    final isSelected = selectedCompanion == companion;

    return ReusableCard(
      colour: isSelected ? Colors.deepPurple : Colors.grey,
      childCard: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 32.0,
              color: isSelected ? Colors.white : Colors.black,
            ),
            SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 8.0),
          ],
        ),
      ),
      onTap: () {
        selectCompanion(companion);
      },
    );
  }

  Widget buildCompanionCard_class(
      Travel_class t_class, String title, IconData icon) {
    final isSelected = selectedClass == t_class;

    return ReusableCard(
      colour: isSelected ? Colors.deepPurple : Colors.grey,
      childCard: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 32.0,
              color: isSelected ? Colors.white : Colors.black,
            ),
            SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 8.0),
          ],
        ),
      ),
      onTap: () {
        selectClass(t_class);
      },
    );
  }
}

class PlanData {
  final String cityName;
  final TravelCompanion? travelCompanion;
  final int adultCount;
  final int travelDays;
  final Travel_class? travelClass;

  PlanData({
    required this.cityName,
    required this.travelCompanion,
    required this.adultCount,
    required this.travelDays,
    required this.travelClass,
  });
}

class InterestSlider extends StatelessWidget {
  final String title;
  final double level;
  final Function(double) onChanged;

  const InterestSlider({
    required this.title,
    required this.level,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CupertinoSlider(
            value: level,
            min: 0,
            max: 4,
            divisions: 4,
            onChanged: onChanged,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('No Interest'),
              Text('Little Interest'),
              Text('Much Interest'),
              Text('Must-Have'),
            ],
          ),
        ),
      ],
    );
  }
}
