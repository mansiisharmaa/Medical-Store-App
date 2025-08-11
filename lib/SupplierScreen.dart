import 'package:flutter/material.dart';
import 'package:medical_store/SupplierScreenModel.dart';
import 'package:medical_store/supplier_dao.dart';
import 'package:medical_store/suppliersdetails.dart';

class Supplierscreen extends StatefulWidget {
  @override
  State<Supplierscreen> createState() => _SupplierscreenState();
}

class _SupplierscreenState extends State<Supplierscreen> {
  var supplierController = TextEditingController();
  var suppliertype = TextEditingController();
  var supplierdate = TextEditingController();
  var supplierbill = TextEditingController();

  List<Supplierscreenmodel> supplierslist = [];
  @override
  void initState() {
    super.initState();
    print("IniState Function");
    setState(() {});
    getList();
  }

  void getList() async {
    supplierslist = await SupplierDao().getsupplier();
    setState(() {});
    print("supplierscreenmodel: $supplierslist");
    for (int i = 0; i < supplierslist.length; i++) {
      print("supplierlist ${supplierslist[i]}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Suppliers", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: supplierslist.length,
        itemBuilder: (BuildContext context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Suppliersdetails(
                    id: supplierslist[index].id,
                    name: supplierslist[index].supplierName,
                    agency: supplierslist[index].agency,
                    contactNo: supplierslist[index].contactNo,
                  ),
                ),
              );
            },
            child: Card(
              color: Colors.blueAccent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name: ${supplierslist[index].supplierName}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Agency: ${supplierslist[index].agency}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),

                        Text(
                          "Contact No.: ${supplierslist[index].contactNo}",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        supplierController.text = supplierslist[index]
                            .supplierName
                            .toString();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Update Name"),
                                    SizedBox(height: 10),
                                    TextField(
                                      controller: supplierController,
                                      decoration: InputDecoration(
                                        hintText: "Update the Name",
                                        labelText: "Name",
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    TextField(
                                      controller: suppliertype,
                                      decoration: InputDecoration(
                                        hintText: "Update the Agency",
                                        labelText: "Agency",
                                        border: OutlineInputBorder(),
                                      ),
                                    ),

                                    SizedBox(height: 10),
                                    TextField(
                                      controller: supplierbill,
                                      decoration: InputDecoration(
                                        hintText: "Update the Contact No",
                                        labelText: "COntact",
                                        border: OutlineInputBorder(),
                                      ),
                                    ),

                                    SizedBox(height: 10),
                                    ElevatedButton(
                                      onPressed: () async {
                                        if (supplierController.text.isEmpty) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "Enter name to update",
                                              ),
                                            ),
                                          );
                                        } else if (suppliertype.text.isEmpty) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "Enter Agency to update",
                                              ),
                                            ),
                                          );
                                        } else if (supplierbill.text.isEmpty) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text("Enter Contact No"),
                                            ),
                                          );
                                        } else {
                                          var supplierscreenmodel =
                                              Supplierscreenmodel(
                                                id: supplierslist[index].id,
                                                supplierName: supplierController
                                                    .text
                                                    .toString(),
                                                agency: suppliertype.text
                                                    .toString(),

                                                contactNo: supplierbill.text
                                                    .toString(),
                                              );
                                          await SupplierDao().updatesupplier(
                                            supplierscreenmodel,
                                          );
                                          getList();
                                          setState(() {});
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: Text("Save"),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.edit),
                    ),

                    IconButton(
                      onPressed: () async {
                        SupplierDao().deletsupplier(
                          int.parse(supplierslist[index].id.toString()),
                        );
                        getList();
                        setState(() {});
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Add Supplier"),
                      SizedBox(height: 10),
                      TextField(
                        controller: supplierController,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: "Supplier Name",
                          label: Text("Enter supplier Name"),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: suppliertype,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          hintText: "Agency",
                          label: Text("Enter Agency Name"),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: supplierbill,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          hintText: "Contact No",
                          label: Text("Enter Contact No"),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: () async {
                          if (supplierController.text.toString().isEmpty) {
                            print("Enter Name");
                          } else if (suppliertype.text.toString().isEmpty) {
                            print("Enter Agency");
                          } else if (supplierbill.text.toString().isEmpty) {
                            print("Enter Contact No");
                          } else {
                            var SupplierScreenModel = Supplierscreenmodel(
                              supplierName: supplierController.text.toString(),
                              agency: suppliertype.text.toString(),
                              contactNo: supplierbill.text.toString(),
                            );
                            setState(() {});
                            await SupplierDao().insertsupplier(
                              SupplierScreenModel,
                            );
                            getList();

                            Navigator.of(context).pop();
                            supplierController.clear();
                            suppliertype.clear();
                            supplierbill.clear();
                          }
                        },
                        child: Text("Save"),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
