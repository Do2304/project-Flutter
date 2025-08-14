import 'package:flutter/material.dart';
import 'package:flutter_project_basic/Project6_BuildBirthDayReminder/events_table.dart';
import 'birthday_model.dart';
import 'event.dart';

class BirthdayReminderApp extends StatefulWidget {
  @override
  _BirthdayReminderAppState createState() => _BirthdayReminderAppState();
}

class _BirthdayReminderAppState extends State<BirthdayReminderApp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  List<Birthday> birthdays = [];

  DateTime selectedDate = DateTime.now();

  List<Event> eventList = [];

  var event;

  late int date = 1;
  late int month = 1;
  late int year = 2023;

  _showSnackBar(message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        dateController.text = selectedDate.toString();
      });
    }
  }

  // đoạn code chưa hiểu
  setEvent(name, date) {
    event = Event(name + " Birthday");
    if (kEventSource[date] == null) {
      eventList = [event];
      kEventSource.addAll({date: eventList});
      setState(() {
        kEvents = kEvents;
      });
    } else {
      kEventSource[date]!.add(event);
      setState(() {
        kEvents.addAll(kEventSource);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(' Birthday Reminder'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/balloons.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: birthdays.length,
          itemBuilder: (context, index) {
            Birthday birthday = birthdays[index];
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: const Offset(1.0, 1.0),
                    blurRadius: 2.0,
                    spreadRadius: 2.0,
                  ),
                ],
              ),
              margin: EdgeInsets.all(10),
              child: ListTile(
                title: Text(birthday.name),
                subtitle: Text(
                  '${birthday.date.day}/${birthday.date.month}/${birthday.date.year}',
                ),
                trailing: const Icon(Icons.cake),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        shape: OvalBorder(),
        onPressed: () {
          nameController.text = "";
          dateController.text = "";
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                scrollable: true,
                title: Center(child: const Text('Add new Birthday')),
                content: SizedBox(
                  height: 265,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.person_2_rounded),
                          const SizedBox(width: 10),
                          Flexible(
                            child: TextField(
                              controller: nameController,
                              decoration: InputDecoration(labelText: 'Name'),
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          GestureDetector(
                            child: Icon(Icons.calendar_today),
                            onTap: () {
                              _selectDate(context);
                            },
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: TextField(
                              controller: dateController,
                              decoration: InputDecoration(
                                labelText: 'Picked Date',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          if (nameController.text.isEmpty ||
                              dateController.text.isEmpty) {
                            _showSnackBar(
                              'Make sure both name and date is provided.????',
                            );
                          } else {
                            DateTime? parsedDate = DateTime.tryParse(
                              dateController.text,
                            );
                            if (parsedDate != null) {
                              Birthday newBirthday = Birthday(
                                name: nameController.text,
                                date: parsedDate,
                              );
                              setState(() {
                                birthdays.add(newBirthday);
                              });

                              Navigator.pop(context);
                              _showSnackBar('Birthday added????????');
                              setEvent(nameController.text, parsedDate);
                            } else {
                              _showSnackBar('Invalid Date!');
                            }
                          }
                        },
                        child: const Text('Add Birthday'),
                      ),
                      const SizedBox(height: 10),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("View Events"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => EventsTable()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        tooltip: "Add Birthday",
        child: const Icon(Icons.add),
      ),
    );
  }
}
