import 'package:flutter/material.dart';
import 'package:medical_store/MedicineScreen.dart';
import 'package:medical_store/SupplierBillScreen.dart';
import 'package:medical_store/SupplierScreen.dart';
import 'package:medical_store/orderItemModel.dart';
import 'package:medical_store/sales.dart';

import 'orderItem_dao.dart';


class Home extends StatefulWidget {

  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Orderitemmodel> medicineList = [];
  @override
  void initState() {
    super.initState();
  //  print("Email Id: ${widget.email.toString()}");
  getList();
  }

    void getList() async {
    medicineList = await OrderitemDao().getitem();
    setState(() {});
    print("medicinmodel: ${medicineList.length}");
    for (int i = 0; i < medicineList.length; i++) {
      print("Medicinlist ${medicineList[i]}");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome to Medical Store",style: TextStyle( fontWeight: FontWeight.bold,fontSize: 25,fontStyle: FontStyle.italic),),
        ),
        
       body: Padding(
         padding: const EdgeInsets.all(10),
         child: Center(
           child: GridView.count(crossAxisCount: 2,
           crossAxisSpacing: 10,
           mainAxisSpacing: 10,
           
           children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const Medicinescreen()),);
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
         
                      Text("Total Medicin",style: TextStyle( fontWeight: FontWeight.bold,fontSize: 20,fontStyle: FontStyle.italic),),
                      Text(medicineList.length.toString()),
                      
                    ]
                  ),
              
              ),
            ),
            


            ),
             GestureDetector(
                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Sales()),).then((onValue){
                                    getList();
                                  });

                },
                child:Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Sales",style: TextStyle( fontWeight: FontWeight.bold,fontSize: 20,fontStyle: FontStyle.italic),),
                  ]
                ),
              ),
            ),),
            
              GestureDetector(
                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Supplierbillscreen()),).then((onValue){
                                    getList();
                                  });

                },
                child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Total bills",style: TextStyle( fontWeight: FontWeight.bold,fontSize: 20,fontStyle: FontStyle.italic),),
                    ]
                  ),
                ),
                            ),
              ),
           
             GestureDetector(
               onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> Supplierscreen()),);
              },
              child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Suppliers\n List",style: TextStyle( fontWeight: FontWeight.bold,fontSize: 20,fontStyle: FontStyle.italic),),
                  ]
                ),
              ),
            ),
             ),
           ],),
         ),
       ),
            );
  }
}