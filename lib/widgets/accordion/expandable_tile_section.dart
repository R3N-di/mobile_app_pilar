// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_interpolation_to_compose_strings, depend_on_referenced_packages, avoid_print

import 'package:flutter/material.dart';
import 'package:mobile_app_pilar/services/perangkat_customer_service.dart';
import 'package:mobile_app_pilar/widgets/input/text_button_widget.dart';
import 'package:mobile_app_pilar/widgets/input/text_field_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:marquee/marquee.dart';

class ExpandableTileSection extends StatefulWidget {
  List<dynamic> data = [];
  List<Widget> header = [];
  List<Widget> content = [];

  ExpandableTileSection({super.key, required this.data, required this.header, required this.content});

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

  // Future fetch() async {
  //   dataPrimary = PerangkatCustomerService().getData(_currentPage, _limit);
  //   dataPrimary.then((data) {
  //     final List newItems = data;
  //     setState(() {
  //       _currentPage++;

  //       if (newItems.length < _limit) {
  //         hasMore = false;
  //       }

  //       widget.data.addAll(newItems);
  //     });
  //   });
  // }

  _launchURL(String urli) async {
    final Uri url = Uri.parse(urli);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch Url');
    }
  }

  @override
  Widget build(BuildContext context) {
    // return ListView.builder(
    //     // controller: scrollController,
    //     padding: EdgeInsets.only(
    //       top: 80,
    //       right: 20,
    //       left: 20,
    //       bottom: 20,
    //     ),
    //     itemCount: widget.data.length + 1,
    //     itemBuilder: (context, index) {
    //       if (index < widget.data.length) {
    //         final data = widget.data[index];
            return Container(
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.only(bottom: 10),
                decoration: ShapeDecoration(color: index % 2 == 0 ? Colors.green.shade300 : Colors.green.shade600, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                child: ExpansionTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   data.namaPelanggan.toString(),
                      //   style: TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 16,
                      //       fontWeight: FontWeight.w600),
                      // ),
                      // Text(
                      //   data.namaItem.toString(),
                      //   style: TextStyle(
                      //       color: Colors.black,
                      //       fontSize: 16,
                      //       fontWeight: FontWeight.w600),
                      // ),
                      // Display the header widgets
                      for (Widget headerWidget in widget.header)
                        Container(
                          padding: EdgeInsets.all(8.0),
                          child: headerWidget,
                        ),
                    ],
                  ),
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: 300,
                      ),
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          for (Widget contentWidget in widget.content)
                          Container(
                            padding: EdgeInsets.all(8.0),
                            child: contentWidget,
                          ),
                          // Row(
                          //   mainAxisSize: MainAxisSize.max,
                          //   children: [
                          //     Expanded(
                          //       child: TextButtonWidget(
                          //         icon: Icon(Icons.location_on),
                          //         text: Text('Map'),
                          //         style: ButtonStyle(
                          //             backgroundColor: MaterialStatePropertyAll(
                          //                 Colors.greenAccent)),
                          //         onPressed: () => _launchURL(
                          //             "https://www.google.com/maps/search/${data.lokasiSerialNumber}"),
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       width: 8,
                          //     ),
                          //     Expanded(
                          //       child: TextButtonWidget(
                          //         icon: Icon(Icons.image_rounded),
                          //         text: Text('Gambar'),
                          //         style: ButtonStyle(
                          //             backgroundColor: MaterialStatePropertyAll(
                          //                 Colors.greenAccent)),
                          //         onPressed: () => showDialog<String>(
                          //             context: context,
                          //             builder: (BuildContext context) {
                          //               return AlertDialog(
                          //                 title: const Text('Gambar Perangkat'),
                          //                 content: Image.network(
                          //                     "https://app.pilarsolusi.co.id/management/administrasi/gambar/serial_number/${(data.gambarSerialNumber).toString()}"),
                          //               );
                          //             }),
                          //       ),
                          //     )
                          //   ],
                          // ),
                          // TextFieldWidget(
                          //   textTitle: Text('Username : '),
                          //   textSubtitle: Text(Marquee(text: '').toString()),
                          // ),
                          // TextFieldWidget(
                          //   textTitle: Text('Password : '),
                          //   textSubtitle: Text(data.passwordSerialNumber),
                          // ),
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: TextButtonWidget(
                          //         icon: Icon(Icons.edit),
                          //         text: Text('Edit'),
                          //         style: ButtonStyle(
                          //             backgroundColor: MaterialStatePropertyAll(
                          //                 Colors.amber)),
                          //         onPressed: () {},
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       width: 8,
                          //     ),
                          //     Expanded(
                          //       child: TextButtonWidget(
                          //         icon: Icon(Icons.delete),
                          //         text: Text('Hapus'),
                          //         style: ButtonStyle(
                          //             backgroundColor:
                          //                 MaterialStatePropertyAll(Colors.red)),
                          //         onPressed: () {
                          //           // PerangkatCustomerService()
                          //           //     .deleteData(data.idSerialNumber);
                          //           showDialog<String>(
                          //               context: context,
                          //               builder: (BuildContext context) {
                          //                 return AlertDialog(
                          //                   title: const Text(
                          //                       'Yakin Ingin Menghapus Data?'),
                          //                   content: Column(
                          //                     children: [
                          //                       TextFieldWidget(
                          //                         textTitle:
                          //                             Text('Username : '),
                          //                         textSubtitle: Text(data
                          //                             .usernameSerialNumber),
                          //                       ),
                          //                       TextFieldWidget(
                          //                         textTitle:
                          //                             Text('Password : '),
                          //                         textSubtitle: Text(data
                          //                             .passwordSerialNumber),
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 );
                          //               });
                          //         },
                          //       ),
                          //     )
                          //   ],
                          // ),
                        ],
                      ),
                    )
                  ],
                ));
        //   } else {
        //     return Padding(
        //       padding: EdgeInsets.symmetric(vertical: 32),
        //       child: Center(
        //           child: hasMore
        //               ? CircularProgressIndicator()
        //               : Text('No More Data To Load')),
        //     );
        //   }
        // });
  }
}

class TextButtonWidget extends StatelessWidget {
  Widget icon;
  Widget text;
  ButtonStyle style;
  void Function() onPressed;

  TextButtonWidget({
    super.key,
    required this.icon,
    required this.text,
    required this.style,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: style,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            text,
          ],
        ));
  }
}
