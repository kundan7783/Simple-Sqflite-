import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_provider.dart';

class UpdateScreen extends StatefulWidget {
  final int id;
  final String name;
  final String phone;


  const UpdateScreen({
    super.key,
    required this.id,
    required this.name,
    required this.phone,
  });

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeProvider>(context, listen: false);
    provider.nameController.text=widget.name;
    provider.phoneController.text=widget.phone;
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Screen"),
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: provider.globalKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            children: [
              TextFormField(
                controller: provider.nameController,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Name is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: provider.phoneController,
                maxLength: 10,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Phone is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (provider.globalKey.currentState!.validate()) {
                      provider.updateMyData(widget.id);
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Update Task"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}