// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings, depend_on_referenced_packages, avoid_print

import 'package:flutter/material.dart';
import 'package:mobile_app_pilar/services/perangkat_customer_service.dart';
import 'package:mobile_app_pilar/widgets/input/text_button_widget.dart';
import 'package:mobile_app_pilar/widgets/input/text_field_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:marquee/marquee.dart';

class ExpandableTileSection extends StatefulWidget {
  List<dynamic> data = [];

  ExpandableTileSection({super.key, required this.data});

  @override
  State<ExpandableTileSection> createState() => _ExpandableTileSectionState();
}

class _ExpandableTileSectionState extends State<ExpandableTileSection> {
  final scrollController = ScrollController();

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
  final int _limit = 10;
  bool hasMore = true;
  bool statusInsertData = false;

  String? updatedNamaLokasi;
  String? updatedLokasiSerialNumber;
  String? updatedUsernameSerialNumber;
  String? updatedPasswordSerialNumber;

  bool statusDeleteData = false;
  bool statusUpdateData = false;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent == scrollController.offset) {
        fetch();
      }
    });
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

        widget.data.addAll(newItems);
      });
    });
  }

  _launchURL(String urli) async {
    final Uri url = Uri.parse(urli);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch Url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: scrollController,
        padding: EdgeInsets.only(
          top: 80,
          right: 20,
          left: 20,
          bottom: 20,
        ),
        itemCount: widget.data.length + 1,
        itemBuilder: (context, index) {
          if (index < widget.data.length) {
            final data = widget.data[index];
            return Container(
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.only(bottom: 10),
                decoration: ShapeDecoration(color: index % 2 == 0 ? Colors.green.shade300 : Colors.green.shade600, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: ExpansionTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.namaPelanggan.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        data.namaItem.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  children: [
                    Builder(builder: (BuildContext contextExpansionTile) {
                      return Container(
                          constraints: BoxConstraints(
                            maxHeight: 600,
                          ),
                          margin: EdgeInsets.all(4),
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(8))),
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextButtonWidget(
                                      icon: Icon(Icons.location_on),
                                      text: Text('Map'),
                                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.greenAccent)),
                                      onPressed: () => _launchURL("https://www.google.com/maps/search/${data.lokasiSerialNumber}"),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: TextButtonWidget(
                                      icon: Icon(Icons.image_rounded),
                                      text: Text('Gambar'),
                                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.greenAccent)),
                                      onPressed: () => showDialog<String>(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Gambar Perangkat'),
                                              content: Image.network("https://app.pilarsolusi.co.id/management/administrasi/gambar/serial_number/${(data.gambarSerialNumber).toString()}"),
                                            );
                                          }),
                                    ),
                                  )
                                ],
                              ),
                              TextFieldWidget(
                                textTitle: Text('Username : '),
                                textSubtitle:
                                    // Marquee(text: data.usernameSerialNumber),
                                    Text(
                                  data.usernameSerialNumber,
                                  // maxLines: 1,
                                ),
                              ),
                              TextFieldWidget(
                                textTitle: Text('Password : '),
                                textSubtitle:
                                    // Marquee(text: data.passwordSerialNumber),
                                    Text(
                                  data.passwordSerialNumber,
                                  // maxLines: 1,
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextButtonWidget(
                                      icon: Icon(Icons.edit),
                                      text: Text('Edit'),
                                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.amber)),
                                      onPressed: () => {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: (context) => Padding(
                                                  padding: const EdgeInsets.all(18.0),
                                                  child: ListView(
                                                    scrollDirection: Axis.vertical,
                                                    children: [
                                                      Center(
                                                        child: Text(
                                                          'Edit Data Perangkat Customer',
                                                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                                        ),
                                                      ),
                                                      Column(
                                                        children: [
                                                          // Text(
                                                          //     'Lokasi Pelanggan / Nama Item / Qty'),
                                                          // DropdownButton(
                                                          //   items: dataSecondaryList.map((data) {
                                                          //     return DropdownMenuItem(
                                                          //       value: data.idKeluar,
                                                          //       child: Text(
                                                          //           '${data.namaPelanggan} - ${data.namaItem} : ${data.qty}'),
                                                          //     );
                                                          //   }).toList(),
                                                          //   value: idKeluar ?? '',
                                                          //   onChanged: (newVal) async {
                                                          //     setState(() {
                                                          //       idKeluar = newVal.toString();
                                                          //     });
                                                          //     print(idKeluar);
                                                          //   },
                                                          //   isExpanded: true,
                                                          // ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 12,
                                                      ),
                                                      TextFormField(
                                                        decoration: InputDecoration(
                                                          labelText: 'Nama Lokasi',
                                                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                                                        ),
                                                        onChanged: (String newNamaLokasi) {
                                                          setState(() {
                                                            updatedNamaLokasi = newNamaLokasi;
                                                            //   widget.data[index].namaLokasi = newNamaLokasi;
                                                          });
                                                        },
                                                        controller: TextEditingController(text: data.namaLokasi.toString()),
                                                      ),
                                                      SizedBox(
                                                        height: 12,
                                                      ),
                                                      TextFormField(
                                                        decoration: InputDecoration(
                                                          labelText: 'Koordinat Perangkat',
                                                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                                                        ),
                                                        onChanged: (String newKoordinatPerangkat) {
                                                          setState(() {
                                                            updatedLokasiSerialNumber = newKoordinatPerangkat;
                                                          });
                                                        },
                                                        controller: TextEditingController(text: data.lokasiSerialNumber.toString()),
                                                      ),
                                                      SizedBox(
                                                        height: 12,
                                                      ),
                                                      TextFormField(
                                                        decoration: InputDecoration(
                                                          labelText: 'Username Perangkat',
                                                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                                                        ),
                                                        onChanged: (String newUsernamePerangkat) {
                                                          setState(() {
                                                            updatedUsernameSerialNumber = newUsernamePerangkat;
                                                          });
                                                        },
                                                        controller: TextEditingController(text: data.usernameSerialNumber.toString()),
                                                      ),
                                                      SizedBox(
                                                        height: 12,
                                                      ),
                                                      TextFormField(
                                                        decoration: InputDecoration(
                                                          labelText: 'Password Perangkat',
                                                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                                                        ),
                                                        onChanged: (String newPasswordPerangkat) {
                                                          setState(() {
                                                            updatedPasswordSerialNumber = newPasswordPerangkat;
                                                          });
                                                        },
                                                        controller: TextEditingController(
                                                          text: data.passwordSerialNumber.toString(),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 12,
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          // PerangkatCustomerService().updateData(
                                                          //   (data.namaTempat ?? data.namaTempat).toString(),
                                                          //   (data.koordinatPerangkat ?? data.lokasiSerialNumber).toString(),
                                                          //   (data.usernamePerangkat ?? data.usernamePerangkat).toString(),
                                                          //   (data.passwordPerangkat ?? data.passwordPerangkat).toString(),
                                                          //   data.idSerialNumber.toString(),
                                                          // );
                                                          PerangkatCustomerService()
                                                              .updateData((updatedNamaLokasi ?? data.namaLokasi).toString(), (updatedLokasiSerialNumber ?? data.lokasiSerialNumber).toString(),
                                                                  (updatedUsernameSerialNumber ?? data.usernameSerialNumber).toString(), (updatedPasswordSerialNumber ?? data.passwordSerialNumber).toString(), data.idSerialNumber)
                                                              .then((value) => {
                                                                    if (value['status'] == 'success')
                                                                      {
                                                                        setState(() {
                                                                          statusUpdateData = true;
                                                                          data.namaLokasi = updatedNamaLokasi ?? data.namaLokasi;
                                                                          data.lokasiSerialNumber = updatedLokasiSerialNumber ?? data.lokasiSerialNumber;
                                                                          data.usernameSerialNumber = updatedUsernameSerialNumber ?? data.usernameSerialNumber;
                                                                          data.passwordSerialNumber = updatedPasswordSerialNumber ?? data.passwordSerialNumber;
                                                                        }),
                                                                      },
                                                                  })
                                                              .whenComplete(() {
                                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                              content: Text("Data ${statusUpdateData ? 'Berhasil' : 'Gagal'} Di edit"),
                                                              behavior: SnackBarBehavior.floating,
                                                              margin: EdgeInsets.all(20),
                                                              backgroundColor: statusUpdateData ? Colors.green : Colors.red,
                                                            ));
                                                            Navigator.pop(context);
                                                            setState(() {
                                                              statusUpdateData = false;
                                                              updatedNamaLokasi = null;
                                                              updatedLokasiSerialNumber = null;
                                                              updatedUsernameSerialNumber = null;
                                                              updatedPasswordSerialNumber = null;
                                                            });
                                                          });
                                                        },
                                                        child: Text('Edit Data'),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: TextButtonWidget(
                                      icon: Icon(Icons.delete),
                                      text: Text('Hapus'),
                                      style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)),
                                      onPressed: () {
                                        // PerangkatCustomerService()
                                        //     .deleteData(data.idSerialNumber);
                                        showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text('Konfirmasi Hapus Data'),
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    TextFieldWidget(
                                                      textTitle: Text('Username : '),
                                                      textSubtitle: Text(data.usernameSerialNumber),
                                                    ),
                                                    TextFieldWidget(
                                                      textTitle: Text('Password : '),
                                                      textSubtitle: Text(data.passwordSerialNumber),
                                                    ),
                                                    // Text("Index : $index"),
                                                    // Text("Data : ${data.usernameSerialNumber}"),
                                                    Row(mainAxisSize: MainAxisSize.max, children: [
                                                      Expanded(
                                                        child: TextButtonWidget(
                                                          icon: Icon(
                                                            Icons.arrow_back,
                                                            color: Colors.white,
                                                            size: 16,
                                                          ),
                                                          text: Text(' Kembali', style: TextStyle(color: Colors.white)),
                                                          style: ButtonStyle(
                                                            backgroundColor: MaterialStatePropertyAll(Colors.black54),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                          },
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Expanded(
                                                        child: TextButtonWidget(
                                                          icon: Icon(
                                                            Icons.delete,
                                                            color: Colors.white,
                                                            size: 16,
                                                          ),
                                                          text: Text(' Hapus', style: TextStyle(color: Colors.white)),
                                                          style: ButtonStyle(
                                                            backgroundColor: MaterialStatePropertyAll(Colors.red),
                                                          ),
                                                          onPressed: () {
                                                            PerangkatCustomerService().deleteData(data.idSerialNumber).then((value) {
                                                              setState(() {
                                                                if (value['status'] == 'success') {
                                                                  statusDeleteData = true;
                                                                }
                                                              });
                                                            }).whenComplete(() {
                                                              setState(() {
                                                                widget.data.removeWhere((item) => item.idSerialNumber == data.idSerialNumber);
                                                              });
                                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                                content: Text("Data ${statusDeleteData ? 'Berhasil' : 'Gagal'} Di hapus"),
                                                                behavior: SnackBarBehavior.floating,
                                                                margin: EdgeInsets.all(20),
                                                                backgroundColor: statusDeleteData ? Colors.green : Colors.red,
                                                              ));
                                                              ExpansionTileController.of(contextExpansionTile).collapse();
                                                              Navigator.pop(context);
                                                              setState(() {
                                                                statusDeleteData = false;
                                                              });
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ])
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ));
                    }),
                  ],
                ));
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Center(child: hasMore ? CircularProgressIndicator() : Text('No More Data To Load')),
            );
          }
        });
  }
}
