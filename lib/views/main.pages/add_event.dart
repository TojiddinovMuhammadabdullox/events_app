import 'package:events_app/views/widgets/datetf_widget.dart';
import 'package:events_app/views/widgets/descriptiontf_widget.dart';
import 'package:events_app/views/widgets/nametf_widget.dart';
import 'package:events_app/views/widgets/timetf_widget.dart';
import 'package:events_app/views/widgets/yandex_map.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddEvents extends StatefulWidget {
  const AddEvents({super.key});

  @override
  State<AddEvents> createState() => _AddEventsState();
}

class _AddEventsState extends State<AddEvents> {
  DateTime selectedDate = DateTime.now(); // Initialize with current date/time
  final ImagePicker _picker = ImagePicker();
  File? _media;

  Future<void> _pickMedia(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _media = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tadbir qo'shish"),
        centerTitle: true,
        leading: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          elevation: 4,
          child: Center(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 10,
            right: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NameTextField(),
              const SizedBox(height: 20),
              DateTextField(),
              const SizedBox(height: 20),
              TimeTextField(),
              const SizedBox(height: 20),
              DescriptionTextField(),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  "Rasm yoki Video yuklash",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => _pickMedia(ImageSource.gallery),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.image,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _pickMedia(ImageSource.camera),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const SizedBox(
                width: double.infinity,
                height: 300,
                child: CustomYandexMap(),
              )
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () {},
        child: Container(
          width: double.infinity,
          height: 50,
          color: Colors.white,
          child: const Center(
            child: Text(
              "Qo'shish",
              style: TextStyle(color: Colors.black, fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}
