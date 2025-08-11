import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class DempCheck extends StatefulWidget {
  const DempCheck({super.key});

  @override
  State<DempCheck> createState() => _DempCheckState();
}

class _DempCheckState extends State<DempCheck> {
   final pdf = pw.Document();
  File? file = null;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

void writePDF() {
pdf.addPage(pw.Page(
  pageFormat: PdfPageFormat.a4,
  build: (pw.Context context){
    return pw.Center(
      child: pw.Text("Hello Mansi")
    );
  }));

}

savePDF ()async {
  Directory document = await getApplicationCacheDirectory();
  String path = document.path;
  File _file = File("$document/sample.pdf");
  _file.writeAsBytes(await pdf.save());
  setState(() {
    file = _file;
  });

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: file !=null ? 
      PDFView(
        filePath: file!.path,
      ): Center(child: Text("OOPs"),),

      floatingActionButton: FloatingActionButton(onPressed: (){
        writePDF();
        savePDF();
      

      },child: Icon(Icons.print),),
    );
    
  }
}