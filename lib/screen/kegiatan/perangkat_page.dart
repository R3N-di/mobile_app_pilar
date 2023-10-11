// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings, sort_child_properties_last, unnecessary_this, avoid_print, depend_on_referenced_packages

import 'package:mobile_app_pilar/models/perangkat_customer_model.dart';
import 'package:mobile_app_pilar/services/perangkat_customer_service_id_keluar.dart';
import 'package:mobile_app_pilar/constant/colors.dart';
import 'package:mobile_app_pilar/services/perangkat_customer_service.dart';

import 'package:flutter/material.dart';
import 'package:accordion/accordion.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile_app_pilar/widgets/accordion/expandable_tile_section.dart';
import 'package:mobile_app_pilar/widgets/search_input.dart';
import 'package:mobile_app_pilar/widgets/action_button_row.dart';
import 'package:mobile_app_pilar/widgets/accordion/title_text_accordion.dart';
import 'package:mobile_app_pilar/widgets/accordion/text_field_accordion.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:marquee/marquee.dart';


import '../../widgets/input/text_button_widget.dart';
import '../../widgets/input/text_field_widget.dart';

class PerangkatCustomerPage extends StatefulWidget {
  @override
  State<PerangkatCustomerPage> createState() => _PerangkatCustomerPageState();
}

class _PerangkatCustomerPageState extends State<PerangkatCustomerPage> {
  late Future dataPrimary;
  late Future dataSecondary;
  late Future dataForUpdate;
  TextEditingController searchController = TextEditingController();
  TextEditingController inputController = TextEditingController();
  List<dynamic> dataList = [];
  List<dynamic> dataSecondaryList = [];
  List<dynamic> dataForUpdateList = [];
  List<dynamic> filteredData = [];
  dynamic selectedValueIdKeluar;
  int _currentPage = 1;
  int _defaultPage = 1;
  int _limit = 10;
  bool hasMore = true;
  bool statusInsertData = false;

  final scrollController = ScrollController();
  bool statusDeleteData = false;
  bool statusUpdateData = false;

  String? updatedNamaLokasi;
  String? updatedLokasiSerialNumber;
  String? updatedUsernameSerialNumber;
  String? updatedPasswordSerialNumber;

  // SECTION PROPERTY dan METHOD Perangkat Customer
  String? idKeluar;
  String? namaTempat;
  String? koordinatPerangkat;
  String? usernamePerangkat;
  String? passwordPerangkat;
  // !SECTION PROPERTY dan METHOD Perangkat Customer

  // SECTION Untuk Dapet Koordinat
  late String lat = '';
  late String long = '';
  // !SECTION Untuk Dapet Koordinat

  void _filterData(String query) {
    setState(() {
      filteredData = dataList.where((data) => data.namaPelanggan.toString().toLowerCase().contains(query.toLowerCase())).toList();
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
    dataPrimary = PerangkatCustomerService().getData(_currentPage, _limit);
    dataPrimary.then((data) {
      setState(() {
        _currentPage++;
        dataList = data;
        filteredData = data;
      });
    });
    dataSecondary = PerangkatCustomerIdKeluarService().getData();
    dataSecondary.then((value) {
      setState(() {
        dataSecondaryList = value;
      });
    });
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        fetch();
      }
    });
    super.initState();
  }

  Future fetch() async {
    dataPrimary = PerangkatCustomerService().getData(_currentPage, _limit);
    dataPrimary.then((data) {
      final List newItems = data;
      setState(() {
        _currentPage++;

        if (newItems.length < _limit) {
          hasMore = false;
        }

        filteredData.addAll(newItems);
      });
    });
  }

  final _headerStyle = const TextStyle(
      color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);
  final _contentStyle = const TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);

  _launchURL(String urli) async {
    final Uri url = Uri.parse(urli);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch Url');
    }
  }

  Future refresh() async {
    filteredData = [];
    dataList = [];
    dataPrimary = PerangkatCustomerService().getData(_defaultPage, _limit);
    dataPrimary.then((value) {
      setState(() {
        _currentPage = 2;
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
      return Future.error('Location permission are permanently denied, we cannot request permission.');
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
            decoration: BoxDecoration(color: primaryGreen, borderRadius: BorderRadius.circular(100)),
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
                    : ListView.builder(
                          padding: EdgeInsets.only(
                            top: 80,
                            right: 20,
                            left: 20,
                            bottom: 20,
                          ),
                          itemCount: filteredData.length + 1,
                          itemBuilder: (context, index) {
                            if (index < filteredData.length) {
                              final data = filteredData[index];
                              return ExpandableTileSection(
                                data: filteredData, // Replace with your filtered data
                                header: [
                                  TitleTextWidget(
                                    texts: [data.namaPelanggan.toString(), data.namaItem.toString()],
                                    textStyles: [
                                      TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                                      TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                                    ],
                                  )
                                ],
                                content: [
                                  ActionButtonsRow(
                                    actionButtons: [
                                      ActionButton(
                                        icon: Icon(
                                          Icons.location_on,
                                          color: Colors.blue,
                                        ),
                                        label: 'Edit 1',
                                        bgcolor: Colors.greenAccent,
                                        color: Colors.black,
                                        onPressed: () => _launchURL(
                                              "https://www.google.com/maps/search/${data.lokasiSerialNumber}"
                                        ),
                                      ),
                                      ActionButton(
                                        icon: Icon(
                                          Icons.image_rounded,
                                          color: Colors.blue,
                                        ),
                                        label: 'Hapus 1',
                                        bgcolor: Colors.greenAccent,
                                        color: Colors.black,
                                        onPressed: () => showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Gambar Perangkat'),
                                              content: Image.network(
                                                  "https://app.pilarsolusi.co.id/management/administrasi/gambar/serial_number/${(data.gambarSerialNumber).toString()}"),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextFieldWidget(
                                    textTitle: Text('Username : '),
                                    textSubtitle: Text(Marquee(text: '').toString()),
                                  ),
                                  TextFieldWidget(
                                    textTitle: Text('Password : '),
                                    textSubtitle: Text(data.passwordSerialNumber),
                                  ),
                                  ActionButtonsRow(
                                    actionButtons: [
                                      ActionButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.blue,
                                        ),
                                        label: 'Edit 1',
                                        bgcolor: Colors.amber,
                                        color: Colors.black,
                                        onPressed: () {
                                          // Tangani aksi saat tombol Edit ditekan
                                        },
                                      ),
                                      ActionButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.blue,
                                        ),
                                        label: 'Hapus 1',
                                        bgcolor: Colors.red,
                                        color: Colors.black,
                                        onPressed: () {
                                          // Tangani aksi saat tombol Hapus ditekan
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              );
                            } else {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 32),
                                child: Center(
                                  child: hasMore
                                      ? CircularProgressIndicator()
                                      : Text('No More Data To Load'),
                                ),
                              );
                            }
                          },
                        )
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
                                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          DropdownSearch<dynamic>(
                                            clearButtonProps: ClearButtonProps(icon: Icon(Icons.clear)),
                                            dropdownBuilder: (context, selectedItem) => Text(((selectedItem?.namaPelanggan == null) || (selectedItem?.namaItem == null) || (selectedItem?.qty == null))
                                                ? 'Pilih..'
                                                : ((selectedItem?.namaPelanggan).toString() + ' | ' + (selectedItem?.namaItem).toString() + ' : ' + (selectedItem.qty).toString())),
                                            popupProps: PopupProps.dialog(
                                              itemBuilder: (context, item, isSelected) => ListTile(
                                                title: Text((item.namaPelanggan).toString() + ' | ' + (item.namaItem).toString() + ' : ' + (item.qty).toString()),
                                              ),
                                              listViewProps: ListViewProps(
                                                scrollDirection: Axis.vertical,
                                              ),
                                              showSearchBox: true,
                                              searchFieldProps: TextFieldProps(
                                                  decoration: InputDecoration(
                                                hintText: 'Cari...',
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.blue,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              )),
                                              title: Padding(
                                                padding: const EdgeInsets.only(top: 12, bottom: 0, left: 12, right: 4),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text('Lokasi Pelanggan'),
                                                    IconButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        icon: Icon(Icons.clear))
                                                  ],
                                                ),
                                              ),
                                            ),
                                            items: dataSecondaryList, // Use dataSecondaryList here
                                            dropdownDecoratorProps: DropDownDecoratorProps(
                                              dropdownSearchDecoration: InputDecoration(
                                                labelText: "Lokasi Pelanggan / Alamat Pelanggan / jml foto yang dapat di masukan",
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: Colors.blue,
                                                    width: 2.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            onChanged: (value) {
                                              setState(() {
                                                selectedValueIdKeluar = value.idKeluar;
                                                this.idKeluar = value.idKeluar;
                                              });
                                            },
                                            selectedItem: selectedValueIdKeluar, // Set the selected value
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          TextFormField(
                                            decoration: InputDecoration(
                                              labelText: 'Nama Tempat',
                                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                                              suffixIcon: IconButton(
                                                icon: Icon(Icons.clear),
                                                onPressed: _clearSearch,
                                              ),
                                            ),
                                            onChanged: (String namaTempat) {
                                              this.namaTempat = namaTempat;
                                            },
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          TextFormField(
                                            controller: TextEditingController(text: (lat == '' && long == '') ? '' : "$lat,$long"),
                                            decoration: InputDecoration(
                                              labelText: 'Koordinat Perangkat',
                                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                                              suffixIcon: IconButton(
                                                icon: Icon(Icons.clear),
                                                onPressed: _clearSearch,
                                              ),
                                            ),
                                            onChanged: (String koordinatPerangkat) {
                                              this.koordinatPerangkat = koordinatPerangkat;
                                            },
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
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
                                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                                              suffixIcon: IconButton(
                                                icon: Icon(Icons.clear),
                                                onPressed: _clearSearch,
                                              ),
                                            ),
                                            onChanged: (String usernamePerangkat) {
                                              this.usernamePerangkat = usernamePerangkat;
                                            },
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          TextFormField(
                                            decoration: InputDecoration(
                                              labelText: 'Password Perangkat',
                                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                                              suffixIcon: IconButton(
                                                icon: Icon(Icons.clear),
                                                onPressed: _clearSearch,
                                              ),
                                            ),
                                            onChanged: (String passwordPerangkat) {
                                              this.passwordPerangkat = passwordPerangkat;
                                            },
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          // ElevatedButton(
                                          //   onPressed: () {
                                          //     PerangkatCustomerService()
                                          //         .postData((this.idKeluar).toString(), (this.namaTempat).toString(), (this.koordinatPerangkat).toString(), (this.usernamePerangkat).toString(), (this.passwordPerangkat).toString())
                                          //         .then((value) {
                                          //       if (value['status'] == 'success') {
                                          //         PerangkatCustomerService().getOneData(value['newDataId']).then((value) {
                                          //           setState(() {
                                          //             filteredData.addAll(value);
                                          //             statusInsertData = true;
                                          //           });
                                          //         });
                                          //       }
                                          //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                          //         content: Text("${statusInsertData ? 'Data Berhasil Di Tambah' : value['message']}"),
                                          //         behavior: SnackBarBehavior.floating,
                                          //         margin: EdgeInsets.all(20),
                                          //         backgroundColor: statusInsertData ? Colors.green : Colors.red,
                                          //       ));
                                          //     }).whenComplete(() {
                                          //       setState(() {
                                          //         selectedValueIdKeluar = null;
                                          //         this.idKeluar = null;
                                          //         statusInsertData = false;
                                          //       });
                                          //     });

                                          //     Navigator.pop(context);
                                          //   },
                                          //   child: Text('Tambah Data'),
                                          // ),
                                          ElevatedButton(
                                            onPressed: () {
                                              PerangkatCustomerService()
                                                  .postData((this.idKeluar).toString(), (this.namaTempat).toString(), (this.koordinatPerangkat).toString(), (this.usernamePerangkat).toString(), (this.passwordPerangkat).toString())
                                                  .then((value) {
                                                if (value['status'] == 'success') {
                                                  try {
                                                    PerangkatCustomerService().getOneData(value['newDataId']).then((value) {
                                                      setState(() {
                                                        filteredData.addAll(value);
                                                        statusInsertData = true;
                                                      });
                                                    });
                                                  } catch (e) {
                                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                      content: Text("Data Gagal Ditambah! ${e}"),
                                                      behavior: SnackBarBehavior.floating,
                                                      margin: EdgeInsets.all(20),
                                                      backgroundColor: Colors.red,
                                                    ));
                                                  }
                                                }
                                                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                //   content: Text("${statusInsertData ? 'Data Berhasil Di Tambah' : value['message']}"),
                                                //   behavior: SnackBarBehavior.floating,
                                                //   margin: EdgeInsets.all(20),
                                                //   backgroundColor: statusInsertData ? Colors.green : Colors.red,
                                                // ));
                                              }).whenComplete(() {
                                                setState(() {
                                                  selectedValueIdKeluar = null;
                                                  this.idKeluar = null;
                                                  statusInsertData = false;
                                                });
                                              });
                                              try {
                                                filteredData = [];
                                                dataList = [];
                                                dataPrimary = PerangkatCustomerService().getData(_defaultPage, _limit);
                                                dataPrimary.then((value) {
                                                  setState(() {
                                                    _currentPage = 2;
                                                    dataList = value;
                                                    filteredData = value;
                                                  });
                                                });
                                              } catch (e) {
                                                print(e);
                                              }
                                              Navigator.pop(context);
                                            },
                                            child: Text('Tambah Data'),
                                          ),
                                        ],
                                      ),
                                    ));
                          },
                          child: Icon(Icons.add),
                          style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => primaryGreen))),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: SearchInput(
                      onChanged: _filterData,
                      controller: searchController,
                      clearSearch: _clearSearch,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}





// class AddPerangkatCustomer extends StatefulWidget {

//   List<dynamic> dropdownSearchItems;
//   dynamic selectedValueIdKeluar;

//   String namaTempat = '';

//   AddPerangkatCustomer({super.key, required this.dropdownSearchItems});

//   @override
//   State<AddPerangkatCustomer> createState() => _AddPerangkatCustomerState();
// }

// class _AddPerangkatCustomerState extends State<AddPerangkatCustomer> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(18.0),
//       child: ListView(
//         scrollDirection: Axis.vertical,
//         children: [
//           Center(
//             child: Text(
//               'Tambah Data Perangkat Customer',
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//             ),
//           ),
//           DropdownSearch<dynamic>(
//             clearButtonProps: ClearButtonProps(icon: Icon(Icons.clear)),
//             dropdownBuilder: (context, selectedItem) => Text(
//                 ((selectedItem?.namaPelanggan == null) ||
//                         (selectedItem?.namaItem == null) ||
//                         (selectedItem?.qty == null))
//                     ? 'Pilih..'
//                     : ((selectedItem?.namaPelanggan).toString() +
//                         ' | ' +
//                         (selectedItem?.namaItem).toString() +
//                         ' : ' +
//                         (selectedItem.qty).toString())),
//             popupProps: PopupProps.dialog(
//               itemBuilder: (context, item, isSelected) => ListTile(
//                 title: Text((item.namaPelanggan).toString() +
//                     ' | ' +
//                     (item.namaItem).toString() +
//                     ' : ' +
//                     (item.qty).toString()),
//               ),
//               listViewProps: ListViewProps(
//                 scrollDirection: Axis.vertical,
//               ),
//               showSearchBox: true,
//               searchFieldProps: TextFieldProps(
//                   decoration: InputDecoration(
//                 hintText: 'Cari...',
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.blue,
//                     width: 2.0,
//                   ),
//                 ),
//               )),
//               title: Padding(
//                 padding: const EdgeInsets.only(top: 12, bottom: 0, left: 12, right: 4),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Lokasi Pelanggan'),
//                     IconButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         icon: Icon(Icons.clear))
//                   ],
//                 ),
//               ),
//             ),
//             items: this.widget.dropdownSearchItems, // Use dataSecondaryList here
//             dropdownDecoratorProps: DropDownDecoratorProps(
//               dropdownSearchDecoration: InputDecoration(
//                 labelText: "Lokasi Pelanggan / Alamat Pelanggan / jml foto yang dapat di masukan",
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                     color: Colors.blue,
//                     width: 2.0,
//                   ),
//                 ),
//               ),
//             ),
//             onChanged: (value) {
//               setState(() {
//                 this.widget.selectedValueIdKeluar = value;
//               });
//               print(value.idKeluar ?? null);
//             },
//             selectedItem: this.widget.selectedValueIdKeluar, // Set the selected value
//           ),
//           SizedBox(
//             height: 12,
//           ),
//           InputText(labelText: 'Nama Tempat', onChanged: (namaTempat) {
//             this.widget.namaTempat = namaTempat;
//           },toClearText: ),
//           SizedBox(
//             height: 12,
//           ),
//           TextFormField(
//             controller: TextEditingController(text: (lat == '' && long == '') ? '' : "$lat,$long"),
//             decoration: InputDecoration(
//               labelText: 'Koordinat Perangkat',
//               focusedBorder:
//                   OutlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 2.0)),
//               suffixIcon: IconButton(
//                 icon: Icon(Icons.clear),
//                 onPressed: _clearSearch,
//               ),
//             ),
//             onChanged: (String koordinatPerangkat) {
//               this.koordinatPerangkat = koordinatPerangkat;
//             },
//           ),
//           ElevatedButton(
//               onPressed: () {
//                 print('Ambil Lokasi Sekarang');
//                 _getCurrentLocation().then((value) {
//                   lat = '${value.latitude}';
//                   long = '${value.longitude}';
//                 });
//               },
//               child: Text('Ambil Lokasi Sekarang')),
//           SizedBox(
//             height: 12,
//           ),
//           TextFormField(
//             decoration: InputDecoration(
//               labelText: 'Username Perangkat',
//               focusedBorder:
//                   OutlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 2.0)),
//               suffixIcon: IconButton(
//                 icon: Icon(Icons.clear),
//                 onPressed: _clearSearch,
//               ),
//             ),
//             onChanged: (String usernamePerangkat) {
//               this.usernamePerangkat = usernamePerangkat;
//             },
//           ),
//           SizedBox(
//             height: 12,
//           ),
//           TextFormField(
//             decoration: InputDecoration(
//               labelText: 'Password Perangkat',
//               focusedBorder:
//                   OutlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 2.0)),
//               suffixIcon: IconButton(
//                 icon: Icon(Icons.clear),
//                 onPressed: _clearSearch,
//               ),
//             ),
//             onChanged: (String passwordPerangkat) {
//               this.passwordPerangkat = passwordPerangkat;
//             },
//           ),
//           SizedBox(
//             height: 12,
//           ),
//           ElevatedButton(
//             onPressed: () {
//               PerangkatCustomerService().postData(
//                   (this.idKeluar).toString(),
//                   (this.namaTempat).toString(),
//                   (this.koordinatPerangkat).toString(),
//                   (this.usernamePerangkat).toString(),
//                   (this.passwordPerangkat).toString());
//             },
//             child: Text('Tambah Data'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class InputText extends StatefulWidget {
//   String labelText;
//   void Function() toClearText;
//   void Function(String) onChanged;
//   TextEditingController controller;

//   InputText({
//     super.key,
//     required this.labelText,
//     required this.toClearText,
//     required this.onChanged,
//     this.controller,
//   });

//   @override
//   State<InputText> createState() => _InputTextState();
// }

// class _InputTextState extends State<InputText> {
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       decoration: InputDecoration(
//         labelText: widget.labelText,
//         focusedBorder:
//             OutlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 2.0)),
//         suffixIcon: IconButton(
//           icon: Icon(Icons.clear),
//           onPressed: widget.toClearText,
//         ),
//       ),
//       onChanged: widget.onChanged
//     );
//   }
// }
