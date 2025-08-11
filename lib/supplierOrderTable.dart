class Supplierordertable {
  int? id;
  int? orderId;
  String? suppliername;
  String? agencyName;
  String? contact;
  double? totalPrice;
  String? dateTimne;

  Supplierordertable({
    this.id,
    this.orderId,
    this.suppliername,
    this.agencyName,
    this.contact,
    this.totalPrice,
    this.dateTimne,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderId': orderId,
      'suppliername': suppliername,
      'agencyName' : agencyName,
      'contact':contact,
      'totalPrice': totalPrice,
      'dateTime': dateTimne,
    };
  }

  factory Supplierordertable.fromMap(Map<String, dynamic> map) {
    return Supplierordertable(
      id: map['id'],
      orderId: map['orderId'],
      suppliername: map['suppliername'],
      agencyName: map['agencyName'],
      contact: map['contact'],
      totalPrice: map['totalPrice'],
      dateTimne: map['dateTime'],
    );
  }
  @override
  String toString() {
    return "Name: $suppliername, orderId:$orderId, $totalPrice, dateTime $dateTimne";
  }
}
