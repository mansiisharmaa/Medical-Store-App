import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medical_store/CreateSupplierBill.dart';
import 'package:medical_store/billscreen.dart';
import 'package:medical_store/supplierOrderTable.dart';
import 'package:medical_store/supplierOrderTable_dao.dart';

class Supplierbillscreen extends StatefulWidget {
  const Supplierbillscreen({super.key});

  @override
  State<Supplierbillscreen> createState() => _SupplierbillscreenState();
}

class _SupplierbillscreenState extends State<Supplierbillscreen> {

  List<Supplierordertable> orderList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrderData();
  }


void getOrderData() async{
orderList = await SupplierordertableDao().getmedicin();
setState(() {
  
});

}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bill Screen"),),
      body: ListView.builder(
        itemCount: orderList.length,
        itemBuilder: (context,index){
        return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>  Billscreen(id: orderList[index].id,supplierName: orderList[index].suppliername, agencyName: orderList[index].agencyName, contactNo: orderList[index].contact, dateTime: orderList[index].dateTimne,totalBill: orderList[index].totalPrice,))).then((onValue){
              getOrderData();
             });
          },
          child: Card(
            
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              
              child: Column(
              
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(orderList[index].suppliername.toString()),
                   Text(orderList[index].totalPrice.toString()),
                    Text(convertDate(context, orderList[index].dateTimne).toString())
                ],
                
              
              ),
              
            ),
          ),
        );
      
        
        
        
      }),
      
  
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Createsupplierbill())).then((onValue){
          getOrderData();
        });
      },
      
      
    child: Icon(Icons.add),),
    );
  }
}

String convertDate(context, date){
  var datefromat = DateTime.parse(date);
   return DateFormat('dd-MM-yyyy hh:mm a',).format(datefromat);
}