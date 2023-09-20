// ignore_for_file: unnecessary_this, prefer_interpolation_to_compose_strings, must_be_immutable

import 'package:flutter/material.dart';
import 'package:mobile_app_pilar/services/perangkat_customer_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mobile_app_pilar/constant/colors.dart';

class AccordionContentWidget extends StatefulWidget {
  late String namaLokasi;
  late String lokasiSerialNumber;
  late String gambarSerialNumber;
  late String usernameSerialNumber;
  late String passwordSerialNumber;
  final String idSerialNumber;

  late List<dynamic> filteredData = [];
  late List<dynamic> dataList = [];

  AccordionContentWidget({
    super.key,
    required this.filteredData,
    required this.dataList,
    required this.namaLokasi,
    required this.lokasiSerialNumber,
    required this.gambarSerialNumber,
    required this.usernameSerialNumber,
    required this.passwordSerialNumber,
    required this.idSerialNumber
  });

  @override
  State<AccordionContentWidget> createState() => _AccordionContentWidgetState();
}

class _AccordionContentWidgetState extends State<AccordionContentWidget> {

  // SECTION BUAT BUKA MAP
  _launchURL(String urli) async {
    final Uri url = Uri.parse(urli);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch Url');
    }
  }
  // !SECTION BUAT BUKA MAP

  // SECTION BUAT PENCARIAN
  TextEditingController searchController = TextEditingController();
  TextEditingController inputController = TextEditingController();

  void _filterData(String query) {
    setState(() {
      this.widget.filteredData = this.widget.dataList
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
  // SECTION BUAT PENCARIAN

  // !SECTION BUAT INPUT TEXT
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) => primaryGreen),
                ),
                onPressed: () => _launchURL(
                    "https://www.google.com/maps/search/" + this.widget.lokasiSerialNumber),
                child: const Row(
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
            const SizedBox(
              width: 16,
            ),
            Flexible(
              child: TextButton(
                style: ButtonStyle(
                  alignment: Alignment.centerRight,
                  backgroundColor: MaterialStateColor.resolveWith((states) => primaryGreen),
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
                            "https://app.pilarsolusi.co.id/administrasi/gambar/serial_number/${(this.widget.gambarSerialNumber).toString()}"),
                      );
                    }),
                child: const Row(
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
          margin: const EdgeInsets.symmetric(vertical: 12),
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
              color: primaryGreen, borderRadius: BorderRadius.all(Radius.circular(4))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                  child: Text(
                'Username : ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              )),
              const SizedBox(
                width: 16,
              ),
              Expanded(child: Text(this.widget.usernameSerialNumber)),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
              color: primaryGreen, borderRadius: BorderRadius.all(Radius.circular(4))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(
                  child: Text(
                'Password : ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              )),
              const SizedBox(
                width: 16,
              ),
              Expanded(child: Text(this.widget.passwordSerialNumber)),
            ],
          ),
        ),
        Row(
          children: [
            Flexible(
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) => Colors.amber),
                ),
                onPressed: () => {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) => Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: ListView(
                              scrollDirection: Axis.vertical,
                              children: [
                                const Center(
                                  child: Text(
                                    'Edit Data Perangkat Customer',
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                                  ),
                                ),
                                const Column(
                                  children: [
                                    // Text(
                                    //     'Lokasi Pelanggan / Alamat Pelanggan / jml foto yang dapat di masukan'),
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
                                const SizedBox(
                                  height: 12,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Nama Tempat',
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: _clearSearch,
                                    ),
                                  ),
                                  onChanged: (String namaLokasiInput) {
                                    this.widget.namaLokasi = namaLokasiInput;
                                  },
                                  controller:
                                      TextEditingController(text: this.widget.namaLokasi.toString()),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Koordinat Perangkat',
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: _clearSearch,
                                    ),
                                  ),
                                  onChanged: (String koordinatPerangkatInput) async {
                                    this.widget.lokasiSerialNumber = koordinatPerangkatInput;
                                  },
                                  controller: TextEditingController(
                                      text: this.widget.lokasiSerialNumber.toString()),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Username Perangkat',
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: _clearSearch,
                                    ),
                                  ),
                                  onChanged: (String usernamePerangkatInput) {
                                    this.widget.usernameSerialNumber = usernamePerangkatInput;
                                  },
                                  controller: TextEditingController(
                                      text: this.widget.usernameSerialNumber.toString()),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: 'Password Perangkat',
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: _clearSearch,
                                    ),
                                  ),
                                  onChanged: (String passwordPerangkatInput) {
                                    this.widget.passwordSerialNumber = passwordPerangkatInput;
                                  },
                                  controller: TextEditingController(
                                    text: this.widget.passwordSerialNumber.toString(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    PerangkatCustomerService().updateData(
                                      (this.widget.namaLokasi).toString(),
                                      (this.widget.lokasiSerialNumber).toString(),
                                      (this.widget.usernameSerialNumber).toString(),
                                      (this.widget.passwordSerialNumber).toString(),
                                      (this.widget.idSerialNumber).toString(),
                                      // (this.namaTempat ?? data.namaTempat).toString(),
                                      // (this.koordinatPerangkat ?? data.lokasiSerialNumber)
                                      //     .toString(),
                                      // (this.usernamePerangkat ?? data.usernamePerangkat).toString(),
                                      // (this.passwordPerangkat ?? data.passwordPerangkat).toString(),
                                      // data.idSerialNumber.toString(),
                                    );
                                  },
                                  child: const Text('Update Data'),
                                ),
                              ],
                            ),
                          )),
                },
                child: const Row(
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
            const SizedBox(
              width: 16,
            ),
            Flexible(
              child: TextButton(
                style: ButtonStyle(
                  alignment: Alignment.centerRight,
                  backgroundColor: MaterialStateColor.resolveWith((states) => Colors.red),
                ),
                onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Hapus Perangkat'),
                        content: const Text(''),
                        actionsAlignment: MainAxisAlignment.spaceAround,
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Batal')),
                          TextButton(
                              onPressed: () async {
                                PerangkatCustomerService().deleteData(this.widget.idSerialNumber);
                              },
                              child: const Text(
                                'Hapus',
                                style: TextStyle(color: Colors.red),
                              ))
                        ],
                      );
                    }),
                child: const Row(
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
    );
  }
}
