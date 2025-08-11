import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_store/MedicineModel.dart';
import 'package:medical_store/SupplierScreenModel.dart';
import 'package:medical_store/orderItemModel.dart';
import 'package:medical_store/orderItem_dao.dart';
import 'package:medical_store/supplierOrderTable.dart';
import 'package:medical_store/supplierOrderTable_dao.dart';
import 'package:medical_store/supplier_dao.dart';
import 'package:intl/intl.dart';

class Createsupplierbill extends StatefulWidget {
  const Createsupplierbill({super.key});

  @override
  State<Createsupplierbill> createState() => _CreatesupplierbillState();
}

class _CreatesupplierbillState extends State<Createsupplierbill> {
  var nameController = TextEditingController();
  var priceController = TextEditingController();
  var descriptionController = TextEditingController();

  // void updateItem(int index){
  //   nameController.text =nameList[index].;
  // }
  // void deleteItem(int index){
  //   nameController.text =nameList[index];
  // }

  List<Supplierscreenmodel> supplierslist = [];
  List<MedicineModel> medicineList = [];
  List<double> itemPrices = [];
  int? supplierId = 0;
  double totalBill = 0.0;
  int quantity = 1;
  var supplierName = "";
  DateTime? selectedDateTime;
  var agencyName = "";
  var contact = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getList();

    setState(() {});
  }

  void getList() async {
    supplierslist = await SupplierDao().getsupplier();
    setState(() {});
    print("supplierscreenmodel: $supplierslist");
    for (int i = 0; i < supplierslist.length; i++) {
      print("supplierlist ${supplierslist[i]}");
    }
  }

  void _selectDateTime(BuildContext context) async {
    // Step 1: Pick Date
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      // Step 2: Pick Time
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime ?? DateTime.now()),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
        print("Check dateTimne: $selectedDateTime");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Bill")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownMenu(
              width: double.infinity,
              enableSearch: true,
              hintText: "Supplier Name",
              label: Text("Supplier Name"),
              onSelected: (value) => {
                supplierId = value?.id,
                supplierName = value!.supplierName.toString(),
                agencyName = value!.agency.toString(),
                contact = value!.contactNo.toString(),
              },
              dropdownMenuEntries: supplierslist
                  .map<DropdownMenuEntry<Supplierscreenmodel>>((
                    Supplierscreenmodel model,
                  ) {
                    return DropdownMenuEntry(
                      value: model,
                      label: model.supplierName.toString(),
                    );
                  })
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                onTap: () => _selectDateTime(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      selectedDateTime == null
                          ? "Select Date"
                          : DateFormat(
                              'dd-MM-yyyy hh:mm a',
                            ).format(selectedDateTime!),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              // shrinkWrap: true,
              itemCount: medicineList.length,
              //physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      color: Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  medicineList[index].name.toString(),
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                Text(
                                  medicineList[index].discription.toString(),
                                  style: TextStyle(fontSize: 18),
                                ),

                                Text(
                                  medicineList[index].price.toString(),
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            Spacer(),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: GestureDetector(
                                  onTap: () {
                                    medicineList[index].quantity =
                                        (medicineList[index].quantity ?? 0) + 1;
                                    totalBill = 0;
                                    for (var item in medicineList) {
                                      totalBill +=
                                          (item.price ?? 0) *
                                          (item.quantity ?? 0);
                                    }

                                    setState(() {});
                                  },
                                  child: Icon(Icons.add, color: Colors.black),
                                ),
                              ),
                            ),
                            Text(
                              medicineList[index].quantity.toString(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: GestureDetector(
                                  onTap: () {
                                    if ((medicineList[index].quantity ?? 0) >
                                        1) {
                                      medicineList[index].quantity =
                                          (medicineList[index].quantity ?? 0) -
                                          1;
                                      totalBill = 0;
                                      for (var item in medicineList) {
                                        totalBill +=
                                            (item.price ?? 0) *
                                            (item.quantity ?? 0);
                                      }
                                    }
                                    setState(() {});
                                  },
                                  child: Icon(
                                    Icons.horizontal_rule,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              Text("Total", style: TextStyle(fontSize: 20)),
              SizedBox(width: 5),
              Text(totalBill.toString(), style: TextStyle(fontSize: 20)),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Add Name"),
                    SizedBox(height: 10),
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hint: Text("Enter Medicine Name"),
                        label: Text("Medicine"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        hint: Text("Enter Medicine Description"),
                        label: Text("Medicine Description"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    TextField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,

                      controller: priceController,
                      decoration: InputDecoration(
                        hint: Text("Enter Medicine Price"),
                        label: Text("Medicine rice"),
                        border: OutlineInputBorder(),
                      ),
                    ),

                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (nameController.text.isEmpty) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text("Enter Name")));
                        } else if (descriptionController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Enter Medicine Description"),
                            ),
                          );
                        } else if (priceController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Enter Price")),
                          );
                        } else {
                          setState(() {});
                          var medicneModel = MedicineModel(
                            supplierId: supplierId,
                            name: nameController.text.toString(),
                            discription: descriptionController.text.toString(),
                            quantity: 1,
                            price: double.parse(
                              priceController.text.toString(),
                            ),
                          );
                          medicineList.add(medicneModel);
                          totalBill +=
                              double.parse(priceController.text.toString()) * 1;
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text("Save"),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            maximumSize: Size(double.infinity, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          onPressed: () async {
            if (medicineList.isEmpty) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("First Add the Medicine")));
            } else if (selectedDateTime == null) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Select Date and Time")));
            } else {
              var supplierOrderTable = Supplierordertable(
                suppliername: supplierName,
                orderId: supplierId,
                dateTimne: selectedDateTime.toString(),
                contact: contact,
                agencyName: agencyName,
                totalPrice: totalBill,
              );
              int orderId = await SupplierordertableDao().insertsupplier(
                supplierOrderTable,
              );
              for (var item in medicineList) {
                var orderItemModel = Orderitemmodel(
                  orderId: orderId,
                  medicinname: item.name,
                  discription: item.discription,
                  quantity: item.quantity,
                  price: item.price,
                  date: selectedDateTime.toString(),
                );
                await OrderitemDao().insertitem(orderItemModel).then((onValue) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Order SuccessFully")));
                });
              }
              getList();
              Navigator.of(context).pop();
            }
          },
          child: Text(
            "Save Bill",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
