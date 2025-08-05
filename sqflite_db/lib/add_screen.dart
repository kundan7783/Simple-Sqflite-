import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_provider.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text("Add Screen"), backgroundColor: Colors.blue),
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
                  labelText: "Enter your name..",
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
                  labelText: "Enter your number..",
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
                      provider.insertMyData();
                      provider.clearControllers();
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Add Task"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
