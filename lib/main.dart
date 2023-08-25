import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter PaginatedDataTable Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyDataTablePage(),
    );
  }
}

class MyDataTablePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter PaginatedDataTable Example'),
      ),
      body: Center(
        child: MyDataTableWidget(),
      ),
    );
  }
}

class MyDataTableWidget extends StatefulWidget {
  @override
  _MyDataTableWidgetState createState() => _MyDataTableWidgetState();
}

class _MyDataTableWidgetState extends State<MyDataTableWidget> {
  final List<DataRow> _dataRows = [
    DataRow(cells: [DataCell(Text('John')), DataCell(Text('28')), DataCell(Text('New York'))]),
    DataRow(cells: [DataCell(Text('Alice')), DataCell(Text('24')), DataCell(Text('San Francisco'))]),
    DataRow(cells: [DataCell(Text('Rahmat')), DataCell(Text('32')), DataCell(Text('Los Angeles'))]),
  ];

  List<DataRow> _filteredRows = [];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    _filteredRows = _dataRows;
    super.initState();
  }

  void _filterRows(String searchText) {
    setState(() {
      _filteredRows = _dataRows.where((row) {
        return row.cells.any((cell) => cell.child!.toString().toLowerCase().contains(searchText.toLowerCase()));
      }).toList();
    });
  }

  void _addData() {
    final String name = _nameController.text;
    final String age = _ageController.text;
    final String location = _locationController.text;

    if (name.isNotEmpty && age.isNotEmpty && location.isNotEmpty) {
      final DataRow newRow = DataRow(cells: [
        DataCell(Text(name)),
        DataCell(Text(age)),
        DataCell(Text(location)),
      ]);

      setState(() {
        _dataRows.add(newRow);
        _filteredRows = _dataRows.where((row) {
          return row.cells.any((cell) => cell.child!.toString().toLowerCase().contains(_filterText.toLowerCase()));
        }).toList();

        _nameController.clear();
        _ageController.clear();
        _locationController.clear();
      });
    }
  }

  String _filterText = '';

  void _removeData(DataRow dataRow) {
    setState(() {
      _dataRows.remove(dataRow);
      _filteredRows = _dataRows.where((row) {
        return row.cells.any((cell) => cell.child!.toString().toLowerCase().contains(_filterText.toLowerCase()));
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _filterText = value;
                  _filterRows(_filterText);
                });
              },
              decoration: InputDecoration(
                labelText: 'Search',
              ),
            ),
          ),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: _ageController,
            decoration: InputDecoration(labelText: 'Age'),
          ),
          TextField(
            controller: _locationController,
            decoration: InputDecoration(labelText: 'Location'),
          ),
          ElevatedButton(
            onPressed: _addData,
            child: Text('Add Data'),
          ),
          DataTable(
            columns: [
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Age')),
              DataColumn(label: Text('Location')),
              DataColumn(label: Text('Actions')), // New column for actions
            ],
            rows: _filteredRows.map((row) {
              return DataRow(
                cells: [
                  ...row.cells,
                  DataCell(IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _removeData(row), // Call remove function
                  )),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}