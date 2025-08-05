import 'package:flutter/cupertino.dart';
import 'package:sqflite_db/db_helper.dart';

class HomeProvider with ChangeNotifier {
  DbHelper dbHelper=DbHelper();

  var globalKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  List<Map<String, dynamic>> myDataList = [];

  Future<void> insertMyData() async {
    bool success= await dbHelper.setData(name: nameController.text, number: phoneController.text);
    if(success){
      await fetchAllData();
    }
  }
  Future<void> fetchAllData() async {
    myDataList= await dbHelper.getAllData();
    notifyListeners();
  }
  Future<void> updateMyData(int index) async {
     bool success = await dbHelper.updateData(id: index, name: nameController.text, number: phoneController.text);
     if(success){
       await fetchAllData();
     }
  }
  Future<void> deleteMyData(int index) async {
     bool success= await dbHelper.deleteData(id: index);
     if(success){
       await fetchAllData();
     }
  }
  void clearControllers() {
    nameController.clear();
    phoneController.clear();
  }
}