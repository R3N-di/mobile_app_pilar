import 'package:flutter/material.dart';

class AccordionHeaderWidget extends StatelessWidget {
  final String namaPelanggan;
  final String namaItem;
  final String namaLokasi;

  final _headerStyle =
      const TextStyle(color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);
  final _contentStyle =
      const TextStyle(color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);

  const AccordionHeaderWidget({
    required this.namaPelanggan,
    required this.namaItem,
    required this.namaLokasi,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(namaPelanggan, style: _headerStyle),
        SizedBox(height: 4),
        Text(namaItem, style: _contentStyle),
        SizedBox(height: 4),
        (namaLokasi == '') ? Container() : Text(namaLokasi, style: _contentStyle),
      ],
    );
  }
}
