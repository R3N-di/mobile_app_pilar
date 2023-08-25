import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class KegiatanScreen extends StatefulWidget {
  @override
  _KegiatanScreenState createState() => _KegiatanScreenState();
}

class _KegiatanScreenState extends State<KegiatanScreen> {
  Map<DateTime, List<Event>> events = {
    DateTime.utc(2023, 8, 24): [Event('Acara 1')],
    DateTime.utc(2023, 8, 25): [Event('Acara 2 coba aja sih ini mah bisa yahahahahaha hayukk'), Event('Acara 3'), Event('Acara 4')],
  };

  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  List<Event> _selectedEvents = [];

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
      setState(() {
        _focusedDay = focusedDay;
        _selectedDay = selectedDay;
        _selectedEvents = _getEventsForDay(selectedDay);
      });

      _showEventModal(context, selectedDay);
  }

  void _showEventModal(BuildContext context, DateTime selectedDay) {
    List<Event> eventsOnSelectedDay = _getEventsForDay(selectedDay);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Acara pada ${DateFormat('dd MMMM yyyy').format(selectedDay)}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: eventsOnSelectedDay.map((event) {
              return ListTile(
                onTap: () {
                  _showEventDetailModal(context, event);
                },
                title: Row(
                  children: [
                    Container(
                      width: 18,
                      height: 18,
                      child: CircleAvatar(
                        backgroundColor: Colors.amberAccent,
                      ),
                    ),
                    SizedBox(width: 10,),
                    Flexible(
                      child: Text(event.title, 
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Tutup"),
            ),
          ],
        );
      },
    );
  }

  void _showEventDetailModal(BuildContext context, Event event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Detail Kegiatan"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Nama Kegiatan : ", 
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              Text("${event.title}"),
              SizedBox(height: 10),
              Text("Nama Pelanggan : ", 
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              Text("PT. Jasamarga Tollroad Operator Ruas Palikanci"),
              SizedBox(height: 10),
              Text("Tanggal Mulai : ", 
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              Text("2023-08-09 11:20"),
              SizedBox(height: 10),
              Text("Tanggal Selesai : ", 
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              Text("2023-08-10 11:20"),
              SizedBox(height: 10),
              Text("Status : ", 
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              Container(
                padding: EdgeInsets.all(6),
                color: Colors.amberAccent,
                child: Text("BlmMulai")
                ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Tutup"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: _onDaySelected,
        calendarFormat: _calendarFormat,
        onFormatChanged: (format) {
          setState(() {
            _calendarFormat = format;
          });
        },
        onPageChanged: (focusedDay) {
          setState(() {
            _focusedDay = focusedDay;
          });
        },
        eventLoader: (day) {
          return _getEventsForDay(day);
        },
        calendarBuilders: CalendarBuilders(
          dowBuilder: (context, day) {
            if (day.weekday == DateTime.sunday) {
              final text = DateFormat.E().format(day);

              return Center(
                child: Text(
                  text,
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
          },
          markerBuilder: (context, day, events) {
            if (events.isNotEmpty) {
              return Positioned(
                right: 1,
                top: 1,
                child: Container(
                  width: 14,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.rectangle,
                  ),
                  child: Center(
                    child: Text(
                      '${events.length}',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}

class Event {
  final String title;
  Event(this.title);
}

void main() {
  runApp(MaterialApp(
    home: KegiatanScreen(),
  ));
}
