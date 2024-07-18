import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';

class MediaPickerWidget extends StatefulWidget {
  final Function(File?) onMediaPicked;

  const MediaPickerWidget({Key? key, required this.onMediaPicked})
      : super(key: key);

  @override
  _MediaPickerWidgetState createState() => _MediaPickerWidgetState();
}

class _MediaPickerWidgetState extends State<MediaPickerWidget> {
  final ImagePicker _picker = ImagePicker();
  File? _media;

  Future<void> _pickMedia(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _media = File(pickedFile.path);
        widget.onMediaPicked(_media);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            "rasm_yoki_video_yuklash".tr(),
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
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
                child:
                    _media == null ? const Icon(Icons.image, size: 50) : null,
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
                child:
                    _media == null ? const Icon(Icons.camera, size: 50) : null,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
