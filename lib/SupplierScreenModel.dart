import 'package:flutter/material.dart';

class Supplierscreenmodel {
int? id;
String? supplierName;
String? agency;
String? contactNo ;

  Supplierscreenmodel({this.id, this.supplierName, this.agency, this.contactNo});
  Map<String, dynamic> toMap() {
    return {'id': id, 'suppliername': supplierName, 'agency': agency, 'contactNo': contactNo};
  }

  factory Supplierscreenmodel.fromMap(Map<String, dynamic> map) {
    return Supplierscreenmodel(id: map['id'], supplierName: map['suppliername'], agency: map['agency'], contactNo: map['contactNo']);
  }
   @override
  String toString() {
    
    return "Name: $supplierName, agency: $agency, contactNo $contactNo";
  }
}