import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:events_app/views/widgets/datetf_widget.dart';
import 'package:events_app/views/widgets/descriptiontf_widget.dart';
import 'package:events_app/views/widgets/event_save_button.dart';
import 'package:events_app/views/widgets/nametf_widget.dart';
import 'package:events_app/views/widgets/timetf_widget.dart';
import 'package:events_app/views/widgets/yandex_map_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:events_app/views/widgets/media_picker_widget.dart';

class AddEvents extends StatefulWidget {
  const AddEvents({super.key});

  @override
  State<AddEvents> createState() => _AddEventsState();
}

class _AddEventsState extends State<AddEvents> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  File? _media;
  String? _name;
  String? _description;
  String _currentAddress = "";

  Future<void> _saveEvent() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_name == null ||
          _selectedDate == null ||
          _selectedTime == null ||
          _description == null ||
          _currentAddress.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Iltimos, barcha maydonlarni to\'ldiring.')),
        );
        return;
      }

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

      await FirebaseFirestore.instance.collection('events').add({
        'name': _name,
        'date': _selectedDate?.toIso8601String(),
        'time': _selectedTime != null
            ? '${_selectedTime!.hour}:${_selectedTime!.minute}'
            : null,
        'description': _description,
        'mediaUrl': mediaUrl,
        'location': _currentAddress,
        'createdAt': Timestamp.now(),
      });

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("tadbir_qoshish").tr(),
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
                  selectedDate: _selectedDate,
                  onDateSelected: (date) {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TimeTextField(
                  selectedTime: _selectedTime,
                  onTimeSelected: (time) {
                    setState(() {
                      _selectedTime = time;
                    });
                  },
                ),
                const SizedBox(height: 20),
                DescriptionTextField(
                  onSaved: (value) => _description = value,
                ),
                const SizedBox(height: 20),
                MediaPickerWidget(
                  onMediaPicked: (media) {
                    setState(() {
                      _media = media;
                    });
                  },
                ),
                const SizedBox(height: 20),
                MapWidget(
                  onLocationUpdated: (address) {
                    setState(() {
                      _currentAddress = address;
                    });
                  },
                ),
                const SizedBox(height: 20),
                SaveButtonWidget(onSave: _saveEvent),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
