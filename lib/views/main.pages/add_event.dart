import 'package:events_app/views/widgets/datetf_widget.dart';
import 'package:events_app/views/widgets/descriptiontf_widget.dart';
import 'package:events_app/views/widgets/nametf_widget.dart';
import 'package:events_app/views/widgets/timetf_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddEvents extends StatefulWidget {
  const AddEvents({super.key});

  @override
  State<AddEvents> createState() => _AddEventsState();
}

class _AddEventsState extends State<AddEvents> {
  final _formKey = GlobalKey<FormState>();
  final DateTime selectedDate =
      DateTime.now(); // Initialize with current date/time
  final ImagePicker _picker = ImagePicker();
  File? _media;
  String? _name;
  String? _date;
  String? _time;
  String? _description;

  Future<void> _pickMedia(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _media = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveEvent() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      String? mediaUrl;
      if (_media != null) {
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('event_media')
            .child(DateTime.now().toIso8601String());
        final uploadTask = storageRef.putFile(_media!);
        final snapshot = await uploadTask.whenComplete(() => null);
        mediaUrl = await snapshot.ref.getDownloadURL();
      }

      // Save event to Firestore
      await FirebaseFirestore.instance.collection('events').add({
        'name': _name,
        'date': _date,
        'time': _time,
        'description': _description,
        'mediaUrl': mediaUrl,
        'createdAt': Timestamp.now(),
      });

      Navigator.of(context).pop();
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NameTextField(
                  onSaved: (value) => _name = value,
                ),
                const SizedBox(height: 20),
                DateTextField(
                  onSaved: (value) => _date = value,
                ),
                const SizedBox(height: 20),
                TimeTextField(
                  onSaved: (value) => _time = value,
                ),
                const SizedBox(height: 20),
                DescriptionTextField(
                  onSaved: (value) => _description = value,
                ),
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
                          image: _media != null
                              ? DecorationImage(
                                  image: FileImage(_media!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: _media == null
                            ? const Icon(Icons.image, size: 50)
                            : null,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _pickMedia(ImageSource.camera),
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                          image: _media != null
                              ? DecorationImage(
                                  image: FileImage(_media!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: _media == null
                            ? const Icon(Icons.camera, size: 50)
                            : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _saveEvent,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffE1691B),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "Saqlash",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
