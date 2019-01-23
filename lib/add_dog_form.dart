import 'package:flutter/material.dart';

import 'dog_model.dart';

class AddDogForm extends StatefulWidget {
  @override
  _AddDogFormState createState() => _AddDogFormState();
}

class _AddDogFormState extends State<AddDogForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new Dog'),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        color: Colors.black54,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name the Pup',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  controller: locationController,
                  decoration: InputDecoration(
                    labelText: "Pup's location",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  controller: descController,
                  decoration: InputDecoration(
                    labelText: 'All about the Pup',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                // 잘못된 context 사용 예제 제거
                child: RaisedButton(
                  onPressed: () => _submitPup(context),
                  color: Colors.indigoAccent,
                  child: Text('Submit Pup'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitPup(BuildContext context) {
    if (nameController.text.isEmpty) {
      print("Dogs need names!");
    } else {
      Dog newDog = Dog(nameController.text, locationController.text, descController.text);
      Navigator.of(context).pop(newDog);
    }
  }
}


