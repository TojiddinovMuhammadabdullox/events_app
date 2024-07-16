import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Tadbirlarni izlash..",
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: const Icon(CupertinoIcons.search, size: 30),
          suffixIcon: IconButton(
            icon: Image.asset(
              "assets/icons/swap_icon.png",
              width: 30,
            ),
            onPressed: () {},
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Color(0xffE1691B), width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Color(0xffE1691B), width: 2),
          ),
        ),
      ),
    );
  }
}
