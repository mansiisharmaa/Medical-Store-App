class Orderitemmodel {
  int? id;
  int? orderId;
  String? medicinname;
  String? discription;
  int? quantity;
  double? price;
  String? date;

  Orderitemmodel({
    this.id,
    this.orderId,
    this.medicinname,
    this.quantity,
    this.discription,
    this.price,
    this.date
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'orderId': orderId,
      'medicinname': medicinname,
      'quantity': quantity,
      'discription': discription,
      'price': price,
      'date':date
    };
  }

  factory Orderitemmodel.fromMap(Map<String, dynamic> map) {
    return Orderitemmodel(
      id: map['id'],
      orderId: map['orderId'],
      medicinname: map['medicinname'],
      quantity: map['quantity'],
      discription: map['discription'],
      price: map['price'],
      date : map['date']
    );
  }
  @override
  String toString() {
    return "Name: $medicinname, dicription: $discription, price: $price, quantity : $quantity";
  }
}
