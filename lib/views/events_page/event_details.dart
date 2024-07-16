import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EventDetails extends StatelessWidget {
  const EventDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 250,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/detail_bg.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.arrow_back_ios_new_outlined,
                        color: Colors.white, size: 35),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.heart_circle_fill,
                        color: Colors.white, size: 40),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Satelitte mega festival for \ndesigners",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                SizedBox(height: 10),
                ListTile(
                  leading: Card(
                    color: Color(0xffDFEBEB),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Icon(Icons.calendar_month, size: 24),
                    ),
                  ),
                  title: Text("Event Date"),
                  subtitle: Text("12th December 2024"),
                ),
                ListTile(
                  leading: Card(
                    color: Color(0xffDFEBEB),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Icon(Icons.location_on, size: 24),
                    ),
                  ),
                  title: Text("Event Location"),
                  subtitle: Text("New York City, NY"),
                ),
                ListTile(
                  leading: Card(
                    color: Color(0xffDFEBEB),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Icon(Icons.person, size: 24),
                    ),
                  ),
                  title: Text("Organizer"),
                  subtitle: Text("John Doe"),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              color: Color(0xffF2F2F2),
              child: SizedBox(
                width: double.infinity,
                height: 70,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      CircleAvatar(),
                      SizedBox(width: 15),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Alisher Zokirov",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("Tadbir tashkilotchisis"),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              "Tadbir haqida",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text("Description"),
          ),
        ],
      ),
    );
  }
}
