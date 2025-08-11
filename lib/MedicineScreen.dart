import 'package:flutter/material.dart';
import 'package:medical_store/medicin_dao.dart';
import 'package:medical_store/MedicineModel.dart';
import 'package:medical_store/orderItemModel.dart';
import 'package:medical_store/orderItem_dao.dart';

class Medicinescreen extends StatefulWidget {
  const Medicinescreen({super.key});

  @override
  State<Medicinescreen> createState() => _MedicinescreenState();
}

class _MedicinescreenState extends State<Medicinescreen> {
   var medicinController = TextEditingController();
  var medicindiscription = TextEditingController();
  var medicinprice =TextEditingController();

  List<Orderitemmodel> medicinList= [];

  @override
   void initState() {

    super.initState();
    print("IniState Function");
    setState(() {});
    getList();
  }

  void getList() async {
    medicinList = await OrderitemDao().getitem();
    setState(() {});
    print("medicinmodel: $medicinList");
    for (int i = 0; i < medicinList.length; i++) {
      print("Medicinlist ${medicinList[i]}");
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
       body: ListView.builder(
        itemCount: medicinList.length,
        itemBuilder: (BuildContext context, index) {
          return Card(
            color: Colors.blueAccent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name: ${medicinList[index].medicinname}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "discription: ${medicinList[index].discription}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "price.: ${medicinList[index].price}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                        SizedBox(height: 10),
                      Text(
                        "Quantity.: ${medicinList[index].quantity}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                      ],
                  ),
                  Spacer(),
                  // IconButton(onPressed: ()  {
                  //       medicinController.text=medicinList[index].name.toString();
                  //     showDialog(context: context, 
                  //       builder: (BuildContext context){
                  //         return Dialog(
                  //           child: Column(
                  //             mainAxisSize: MainAxisSize.min,
                  //                   children: [
                  //                     Text("Update Name"),
                  //                     SizedBox(height: 10),
                  //                     TextField(
                  //                       controller: medicinController,
                  //                       decoration: InputDecoration(
                  //                         hintText: "Update the Name",
                  //                         labelText: "Update",
                  //                         border: OutlineInputBorder(),
                  //                       ),
                  //                     ),
                  //                     SizedBox(height: 10),
                  //                     TextField(
                  //                       controller: medicindiscription,
                  //                       decoration: InputDecoration(
                  //                         hintText: "Update the discription",
                  //                         labelText: "Update",
                  //                         border: OutlineInputBorder(),
                  //                       ),
                  //                     ),
                  //                      SizedBox(height: 10),
                  //                     TextField(
                  //                       controller: medicinprice,
                  //                       decoration: InputDecoration(
                  //                         hintText: "Update the price",
                  //                         labelText: "Update",
                  //                         border: OutlineInputBorder(),
                  //                       ),
                  //                     ),
                                      
                  //                     SizedBox(height: 10),
                  //                     ElevatedButton(
                  //                       onPressed: () async {
                  //                         if (medicinController.text.isEmpty) {
                  //                           ScaffoldMessenger.of(context).showSnackBar(
                  //                             SnackBar(content: Text("Enter name to update")),
                  //                           );
                  //                         }else if(medicindiscription.text.isEmpty){
                  //                            ScaffoldMessenger.of(context).showSnackBar(
                  //                             SnackBar(content: Text("Enter dicription to update")),);
                  //                         }
                  //                          else {
                  //                            var Medicinmodel = MedicineModel(
                  //                               id: medicinList[index].id,
                  //                               name: medicinController.text.toString(),
                  //                               discription: medicindiscription.text.toString(),
                  //                               price: double.parse(medicinprice.text.toString()));
                  //                          await MedicinDao().updateMedicin(Medicinmodel);
                  //                          getList();
                  //                           setState(()  {
                                             
                                            
                  //                           });
                  //                           Navigator.of(context).pop();
                  //                         }
                  //                       },
                  //                       child: Text("Save"),
                  //                     ),
                  //                   ],
                  //                 )
                  //     );
                  //       });
                    
                  // }, icon: Icon(Icons.edit)),

                      //   IconButton(
                      //   onPressed: () async{
                      //   //  MedicinDao().deletMedicin(int.parse(medicinList[index].id.toString()),);
                      //   //  getList();
                      //     setState(() {
                          
                          
                      //     });
                      //   },
                      //   icon: Icon()
                      // ),
                ],
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
                      Text("Add medicin"),
                      SizedBox(height: 10),
                      TextField(
                        controller: medicinController,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          hintText: "Enter medicin Name",
                          label: Text("Enter medicin Name"),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: medicindiscription,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          hintText: "Enter dicription",
                          label: Text("Enter dicription Name"),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: medicinprice,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          hintText: "Enter price",
                          label: Text("Enter total price"),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: () async {
                          if (medicinController.text.toString().isEmpty) {
                            print("Enter Name");
                          } else if (medicindiscription.text.toString().isEmpty) {
                            print("Enter dicription");
                          } else {
                            var medicin_model= MedicineModel(
                              name: medicinController.text.toString(),
                              discription: medicindiscription.text.toString(),
                              price: double.parse(medicinprice.text.toString(),)
                            );
                            setState(() {});
                            await MedicinDao().insertmedicin(medicin_model);
                            getList();

                            Navigator.of(context).pop();
                            medicinController.clear();
                            medicindiscription.clear();
                             medicinprice.clear();
                          }
                        },
                        child: Text("Save"),
                      ),
                  
                ]),
              ),);
              
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
   