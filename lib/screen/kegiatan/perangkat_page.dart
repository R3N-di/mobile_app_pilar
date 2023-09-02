// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings, sort_child_properties_last, unnecessary_this, avoid_print

import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import 'package:mobile_app_pilar/services/perangkat_customer_service_id_keluar.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:accordion/controllers.dart';
import 'package:mobile_app_pilar/constant/colors.dart';
import 'package:mobile_app_pilar/services/perangkat_customer_service.dart';

import '../../widgets/app_header.dart';

class PerangkatCustomerPage extends StatefulWidget {
  @override
  State<PerangkatCustomerPage> createState() => _PerangkatCustomerPageState();
}

class _PerangkatCustomerPageState extends State<PerangkatCustomerPage> {
  late Future dataPrimary;
  late Future dataSecondary;
  TextEditingController searchController = TextEditingController();
  TextEditingController inputController = TextEditingController();
  List<dynamic> dataList = [];
  List<dynamic> dataSecondaryList = [];
  List<dynamic> filteredData = [];

  // SECTION PROPERTY dan METHOD Perangkat Customer
  String? idKeluar;
  String? namaTempat;
  String? koordinatPerangkat;
  String? usernamePerangkat;
  String? passwordPerangkat;

  getNamaTempat(namaTempat) {
    this.namaTempat = namaTempat;
  }

  getKoordinatPerangkat(koordinatPerangkat) {
    this.koordinatPerangkat = koordinatPerangkat;
  }

  getUsernamePerangkat(usernamePerangkat) {
    this.usernamePerangkat = usernamePerangkat;
  }

  getPasswordPerangkat(passwordPerangkat) {
    this.passwordPerangkat = passwordPerangkat;
  }
  // !SECTION PROPERTY dan METHOD Perangkat Customer

  // SECTION Untuk Dapet Koordinat
  late String lat = '';
  late String long = '';
  // !SECTION Untuk Dapet Koordinat

  void _filterData(String query) {
    setState(() {
      filteredData = dataList
          .where(
              (data) => data.namaPelanggan.toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _clearSearch() {
    searchController.clear();
    _filterData('');
    // Hapus fokus dari tombol hapus
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void _clearInput() {
    inputController.clear();
    // _filterData('');
    // Hapus fokus dari tombol hapus
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  void initState() {
    // TODO: implement initState
    dataPrimary = PerangkatCustomerService().getData();
    dataPrimary.then((value) {
      setState(() {
        dataList = value;
        filteredData = value;
      });
    });
    dataSecondary = PerangkatCustomerIdKeluarService().getData();
    dataSecondary.then((value) {
      setState(() {
        dataSecondaryList = value;
      });
    });
    super.initState();
  }

  final _headerStyle =
      const TextStyle(color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);
  final _contentStyleHeader =
      const TextStyle(color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);
  final _contentStyle =
      const TextStyle(color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);
  final _loremIpsum =
      '''Lorem ipsum is typically a corrupted version of 'De finibus bonorum et malorum', a 1st century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin.''';

  _launchURL(String urli) async {
    final Uri url = Uri.parse(urli);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch Url');
    }
  }

  Future refresh() async {
    dataPrimary = PerangkatCustomerService().getData();
    dataPrimary.then((value) {
      setState(() {
        dataList = value;
        filteredData = value;
      });
    });
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permission are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permission are permanently denied, we cannot request permission.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Perangkat Customer'),
          leading: Container(),
          backgroundColor: primaryGreen,
          shape: const RoundedRectangleBorder(
            side: BorderSide.none,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(60)),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Container(
            padding: EdgeInsets.all(2),
            decoration:
                BoxDecoration(color: primaryGreen, borderRadius: BorderRadius.circular(100)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                width: 50,
                height: 50,
                // color: black,
                decoration: BoxDecoration(color: black),
                child: Icon(Icons.arrow_back_ios_new_rounded, color: textWhite),
              ),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          elevation: 10,
          foregroundColor: Colors.transparent,
          backgroundColor: black,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        body: Stack(
          children: [
            RefreshIndicator(
              onRefresh: refresh,
              child: (filteredData.length == 0)
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    )
                  : Accordion(
                      paddingListTop: 90,
                      paddingListBottom: 90,
                      header: Text('Perangkat Customer'),
                      scaleWhenAnimating: false,
                      contentBorderColor: Color.fromARGB(255, 106, 231, 92),
                      children: filteredData.map((data) {
                        return AccordionSection(
                          headerBackgroundColor: Colors.black,
                          headerBackgroundColorOpened: Color.fromARGB(255, 106, 231, 92),
                          header: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data.namaPelanggan, style: _headerStyle),
                              SizedBox(
                                height: 4,
                              ),
                              Text(data.namaItem, style: _contentStyle),
                              SizedBox(
                                height: 4,
                              ),
                              (data.namaLokasi == '')
                                  ? Container()
                                  : Text(data.namaLokasi, style: _contentStyle),
                            ],
                          ),
                          content: Column(
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: TextButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateColor.resolveWith(
                                            (states) => primaryGreen),
                                      ),
                                      onPressed: () => _launchURL(
                                          "https://www.google.com/maps/search/" +
                                              data.lokasiSerialNumber),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.location_on, color: textWhite),
                                          Text(
                                            'Map',
                                            style: TextStyle(color: textWhite),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Flexible(
                                    child: TextButton(
                                      style: ButtonStyle(
                                        alignment: Alignment.centerRight,
                                        backgroundColor: MaterialStateColor.resolveWith(
                                            (states) => primaryGreen),
                                      ),
                                      onPressed: () => showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Gambar Perangkat'),
                                              // content: Image.asset(
                                              //     "assets/images/perangkat_customer/" +
                                              //         (data.gambarSerialNumber).toString())
                                              content: Image.network(
                                                  "https://app.pilarsolusi.co.id/administrasi/gambar/serial_number/${(data.gambarSerialNumber).toString()}"),
                                            );
                                          }),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.image_rounded, color: textWhite),
                                          Text(
                                            'Image',
                                            style: TextStyle(color: textWhite),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 12),
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    color: primaryGreen,
                                    borderRadius: BorderRadius.all(Radius.circular(4))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: Text(
                                      'Username : ',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                    )),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(child: Text(data.usernameSerialNumber)),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 12),
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                    color: primaryGreen,
                                    borderRadius: BorderRadius.all(Radius.circular(4))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: Text(
                                      'Password : ',
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                    )),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(child: Text(data.passwordSerialNumber)),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: TextButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateColor.resolveWith(
                                            (states) => Colors.amber),
                                      ),
                                      onPressed: () => showModalBottomSheet(
                                          context: context,
                                          builder: (context) => Padding(
                                                padding: const EdgeInsets.all(18.0),
                                                child: ListView(
                                                  scrollDirection: Axis.vertical,
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        'Tambah Data Perangkat Customer',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.w600),
                                                      ),
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                            'Lokasi Pelanggan / Alamat Pelanggan / jml foto yang dapat di masukan'),
                                                        DropdownButton(
                                                          items: dataSecondaryList.map((data) {
                                                            return DropdownMenuItem(
                                                              value: data.idKeluar,
                                                              child: Text(
                                                                  '${data.namaPelanggan} - ${data.namaItem} : ${data.qty}'),
                                                            );
                                                          }).toList(),
                                                          value: idKeluar ?? '',
                                                          onChanged: (newVal) async {
                                                            setState(() {
                                                              idKeluar = newVal.toString();
                                                            });
                                                            print(idKeluar);
                                                          },
                                                          isExpanded: true,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                    TextFormField(
                                                      decoration: InputDecoration(
                                                        labelText: 'Nama Tempat',
                                                        focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors.blue, width: 2.0)),
                                                        suffixIcon: IconButton(
                                                          icon: Icon(Icons.clear),
                                                          onPressed: _clearSearch,
                                                        ),
                                                      ),
                                                      onChanged: (String namaTempat) {
                                                        getNamaTempat(namaTempat);
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                    TextFormField(
                                                      controller: TextEditingController(
                                                          text: (lat == '' && long == '')
                                                              ? ''
                                                              : "$lat,$long"),
                                                      decoration: InputDecoration(
                                                        labelText: 'Koordinat Perangkat',
                                                        focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors.blue, width: 2.0)),
                                                        suffixIcon: IconButton(
                                                          icon: Icon(Icons.clear),
                                                          onPressed: _clearSearch,
                                                        ),
                                                      ),
                                                      onChanged: (String koordinatPerangkat) async {
                                                        getKoordinatPerangkat(koordinatPerangkat);
                                                      },
                                                    ),
                                                    ElevatedButton(
                                                        onPressed: () async {
                                                          print('Ambil Lokasi Sekarang');
                                                          print('Lokasi Sekarang = $lat,$long');
                                                          _getCurrentLocation().then((value) {
                                                            lat = '${value.latitude}';
                                                            long = '${value.longitude}';
                                                          });
                                                        },
                                                        child: Text('Ambil Lokasi Sekarang')),
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                    TextFormField(
                                                      decoration: InputDecoration(
                                                        labelText: 'Username Perangkat',
                                                        focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors.blue, width: 2.0)),
                                                        suffixIcon: IconButton(
                                                          icon: Icon(Icons.clear),
                                                          onPressed: _clearSearch,
                                                        ),
                                                      ),
                                                      onChanged: (String usernamePerangkat) {
                                                        getUsernamePerangkat(usernamePerangkat);
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                    TextFormField(
                                                      decoration: InputDecoration(
                                                        labelText: 'Password Perangkat',
                                                        focusedBorder: OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Colors.blue, width: 2.0)),
                                                        suffixIcon: IconButton(
                                                          icon: Icon(Icons.clear),
                                                          onPressed: _clearSearch,
                                                        ),
                                                      ),
                                                      onChanged: (String passwordPerangkat) {
                                                        getPasswordPerangkat(passwordPerangkat);
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 12,
                                                    ),
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        PerangkatCustomerService().postData(
                                                            (this.idKeluar).toString(),
                                                            (this.namaTempat).toString(),
                                                            (this.koordinatPerangkat).toString(),
                                                            (this.usernamePerangkat).toString(),
                                                            (this.passwordPerangkat).toString());
                                                      },
                                                      child: Text('Tambah Data'),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.edit, color: textWhite),
                                          Text(
                                            'Edit',
                                            style: TextStyle(color: textWhite),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Flexible(
                                    child: TextButton(
                                      style: ButtonStyle(
                                        alignment: Alignment.centerRight,
                                        backgroundColor:
                                            MaterialStateColor.resolveWith((states) => Colors.red),
                                      ),
                                      onPressed: () => showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Hapus Perangkat'),
                                              content: Text(''),
                                              actionsAlignment: MainAxisAlignment.spaceAround,
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Batal')),
                                                TextButton(
                                                    onPressed: () async {
                                                      PerangkatCustomerService()
                                                          .deleteData(data.idSerialNumber);

                                                      refresh();
                                                    },
                                                    child: Text(
                                                      'Hapus',
                                                      style: TextStyle(color: Colors.red),
                                                    ))
                                              ],
                                            );
                                          }),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.delete, color: textWhite),
                                          Text(
                                            'Hapus',
                                            style: TextStyle(color: textWhite),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          contentHorizontalPadding: 20,
                          contentBorderWidth: 1,
                          // onOpenSection: () => print('onOpenSection ...'),
                          // onCloseSection: () => print('onCloseSection ...'),
                        );
                      }).toList()),
            ),
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: ListView(
                                        scrollDirection: Axis.vertical,
                                        children: [
                                          Center(
                                            child: Text(
                                              'Tambah Data Perangkat Customer',
                                              style: TextStyle(
                                                  fontSize: 20, fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                  'Lokasi Pelanggan / Alamat Pelanggan / jml foto yang dapat di masukan'),
                                              DropdownButton(
                                                items: dataSecondaryList.map((data) {
                                                  return DropdownMenuItem(
                                                    value: data.idKeluar,
                                                    child: Text(
                                                        '${data.namaPelanggan} - ${data.namaItem} : ${data.qty}'),
                                                  );
                                                }).toList(),
                                                onChanged: (newVal) {
                                                  setState(() {
                                                    idKeluar = newVal.toString();
                                                  });
                                                },
                                                isExpanded: true,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          TextFormField(
                                            decoration: InputDecoration(
                                              labelText: 'Nama Tempat',
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide:
                                                      BorderSide(color: Colors.blue, width: 2.0)),
                                              suffixIcon: IconButton(
                                                icon: Icon(Icons.clear),
                                                onPressed: _clearSearch,
                                              ),
                                            ),
                                            onChanged: (String namaTempat) {
                                              getNamaTempat(namaTempat);
                                            },
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          TextFormField(
                                            controller: TextEditingController(
                                                text:
                                                    (lat == '' && long == '') ? '' : "$lat,$long"),
                                            decoration: InputDecoration(
                                              labelText: 'Koordinat Perangkat',
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide:
                                                      BorderSide(color: Colors.blue, width: 2.0)),
                                              suffixIcon: IconButton(
                                                icon: Icon(Icons.clear),
                                                onPressed: _clearSearch,
                                              ),
                                            ),
                                            onChanged: (String koordinatPerangkat) {
                                              getKoordinatPerangkat(koordinatPerangkat);
                                            },
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                print('Ambil Lokasi Sekarang');
                                                _getCurrentLocation().then((value) {
                                                  lat = '${value.latitude}';
                                                  long = '${value.longitude}';
                                                });
                                              },
                                              child: Text('Ambil Lokasi Sekarang')),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          TextFormField(
                                            decoration: InputDecoration(
                                              labelText: 'Username Perangkat',
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide:
                                                      BorderSide(color: Colors.blue, width: 2.0)),
                                              suffixIcon: IconButton(
                                                icon: Icon(Icons.clear),
                                                onPressed: _clearSearch,
                                              ),
                                            ),
                                            onChanged: (String usernamePerangkat) {
                                              getUsernamePerangkat(usernamePerangkat);
                                            },
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          TextFormField(
                                            decoration: InputDecoration(
                                              labelText: 'Password Perangkat',
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide:
                                                      BorderSide(color: Colors.blue, width: 2.0)),
                                              suffixIcon: IconButton(
                                                icon: Icon(Icons.clear),
                                                onPressed: _clearSearch,
                                              ),
                                            ),
                                            onChanged: (String passwordPerangkat) {
                                              getPasswordPerangkat(passwordPerangkat);
                                            },
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              PerangkatCustomerService().postData(
                                                  (this.idKeluar).toString(),
                                                  (this.namaTempat).toString(),
                                                  (this.koordinatPerangkat).toString(),
                                                  (this.usernamePerangkat).toString(),
                                                  (this.passwordPerangkat).toString());
                                            },
                                            child: Text('Tambah Data'),
                                          ),
                                        ],
                                      ),
                                    ));
                          },
                          child: Icon(Icons.add),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateColor.resolveWith((states) => primaryGreen))),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: primaryGreen,
                      ),
                      child: TextField(
                        onChanged: _filterData,
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          fillColor: primaryGreen,
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: _clearSearch,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 20,
              bottom: 20,
              right: 20,
              child: Container(
                width: 50,
                height: 50,
                color: Colors.amber,
                child: Text(
                  'Rencananya Pagination',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ));
  }
}
