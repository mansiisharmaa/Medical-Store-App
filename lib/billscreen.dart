import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:medical_store/orderItemModel.dart';
import 'package:medical_store/orderItem_dao.dart';
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Billscreen extends StatefulWidget {
  int? id;
  String? supplierName;
  String? dateTime;
  String? contactNo;
  String? agencyName;
  double? totalBill;

  Billscreen({
    required this.id,
    required this.supplierName,
    required this.agencyName,
    required this.contactNo,
    required this.dateTime,
    required this.totalBill,
    super.key,
  });

  @override
  State<Billscreen> createState() => _BillscreenState();
}

class _BillscreenState extends State<Billscreen> {
  List<Orderitemmodel> itemList = [];
  final pdf = pw.Document();
  File? file = null;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMedicienItem();
  }

  void getMedicienItem() async {
    itemList = await OrderitemDao().getList(widget.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bill Details',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Supplier Name :", style: TextStyle(fontSize: 18)),
                        SizedBox(width: 5),
                        Text(
                          widget.supplierName.toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Text("Contact No:", style: TextStyle(fontSize: 18)),
                        SizedBox(width: 5),
                        Text(
                          widget.contactNo.toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    //   SizedBox(height: 10),
                    Row(
                      children: [
                        Text("Agency Name :", style: TextStyle(fontSize: 18)),
                        SizedBox(width: 5),
                        Text(
                          widget.agencyName.toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    //    SizedBox(height: 10),
                    Row(
                      children: [
                        Text("Date Time :", style: TextStyle(fontSize: 18)),
                        SizedBox(width: 5),
                        Text(
                          widget.dateTime.toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    //    SizedBox(height: 10),
                    Row(
                      children: [
                        Text("Total Bill :", style: TextStyle(fontSize: 18)),
                        SizedBox(width: 5),
                        Text(
                          widget.totalBill.toString(),
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          Text("Medicine Items", style: TextStyle(fontSize: 25)),
          Table(
            border: TableBorder.all(),
            children: [
              TableRow(
                children: [
                  Text(
                    'Medicine Name',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Quantity',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Price',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                return Table(
                  // border: TableBorder.all(width: 1.0, color: Colors.black),
                  children: <TableRow>[
                    TableRow(
                      children: <Widget>[
                        Text(itemList[index].medicinname.toString()),
                        Align(
                          alignment: Alignment.center,
                          child: Text(itemList[index].quantity.toString()),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(itemList[index].price.toString()),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () async {
          final pdf = pw.Document();

          pdf.addPage(
            pw.Page(
              build: (pw.Context context) {
                return pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      "Medicine Bill",
                      style: pw.TextStyle(
                        fontSize: 24,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 10),
                    pw.Text("Supplier Name: ${widget.supplierName}"),
                    pw.Text("Agency Name: ${widget.agencyName}"),
                    pw.Text("Contact No: ${widget.contactNo}"),
                    pw.Text("Date: ${widget.dateTime}"),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      "Medicine Items",
                      style: pw.TextStyle(
                        fontSize: 18,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.SizedBox(height: 5),

                    pw.Table(
                      border: pw.TableBorder.all(),
                      columnWidths: {
                        0: pw.FlexColumnWidth(4),
                        1: pw.FlexColumnWidth(2),
                        2: pw.FlexColumnWidth(2),
                      },
                      children: [
                        pw.TableRow(
                          decoration: pw.BoxDecoration(
                            color: PdfColors.grey300,
                          ),
                          children: [
                            pw.Padding(
                              padding: pw.EdgeInsets.all(4),
                              child: pw.Text("Medicine Name"),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(4),
                              child: pw.Text("Quantity"),
                            ),
                            pw.Padding(
                              padding: pw.EdgeInsets.all(4),
                              child: pw.Text("Price"),
                            ),
                          ],
                        ),
                        ...itemList.map((item) {
                          return pw.TableRow(
                            children: [
                              pw.Padding(
                                padding: pw.EdgeInsets.all(4),
                                child: pw.Text(item.medicinname.toString()),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(4),
                                child: pw.Text(item.quantity.toString()),
                              ),
                              pw.Padding(
                                padding: pw.EdgeInsets.all(4),
                                child: pw.Text("₹${item.price}"),
                              ),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                    pw.SizedBox(height: 20),
                    pw.Text(
                      "Total Bill: ${widget.totalBill}",
                      style: pw.TextStyle(
                        
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ),
          );

          await Printing.layoutPdf(
            onLayout: (PdfPageFormat format) async => pdf.save(),
          );
          setState(() {});
        },
        child: Text('Print'),
      ),
    );
  }
}
