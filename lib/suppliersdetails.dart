import 'package:flutter/material.dart';
import 'package:medical_store/MedicineModel.dart';

class Suppliersdetails extends StatefulWidget {
 
   int? id;
  String? name;
  String? agency;
  String? contactNo;
  Suppliersdetails({required this.id,required this.name, required this.agency, required this.contactNo ,super.key});

  @override
  State<Suppliersdetails> createState() => _SuppliersdetailsState();
}

class _SuppliersdetailsState extends State<Suppliersdetails> {

   List<String> nameList = [];
  var medicinController = TextEditingController();
  var medicinamount = TextEditingController();
  void updateItem(int index){
    medicinController.text =nameList[index];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Suplier Details"),),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            
            height: 120,
            
            child: 
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text("Supplier Name: ",style: TextStyle(fontSize: 20),),
                    Spacer(),
                    Text(widget.name.toString(),style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
             
                
              SizedBox(height: 10,),
                 Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text("Agency Name:",style: TextStyle(fontSize: 20),),
                    Spacer(),
                    Text(widget.agency.toString(),style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
          
               SizedBox(height: 10,),
                 Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text("Supplier  Contact No:",style: TextStyle(fontSize: 20),),
                    Spacer(),
                    Text(widget.contactNo.toString(),style: TextStyle(fontSize: 20)),
                  ],
                ),
              )
            ],
          )
          ,),
        
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Add Medicin Name"),
                    SizedBox(height: 10),
                    TextField(
                      controller: medicinController,
                      decoration: InputDecoration(
                        hint: Text("Enter Name of Medicin"),
                        label: Text("Name"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: medicinamount,
                      decoration: InputDecoration(
                        hint: Text("Enter total amount"),
                        label: Text("amount"),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if (medicinController.text.isEmpty) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text("Enter total amount")));
                        } else {
                          setState(() {});
                        //  nameList.add(medicinController.text.toString());
                        // var medicineModel = MedicineModel(
                        //   supplierId: widget.id,
                        //   name: medicinController.text.toString(),
                        //   amount: medic
                        // );
                        //   Navigator.of(context).pop();
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
        child: Icon(Icons.add),
      ),
    );
  }
}