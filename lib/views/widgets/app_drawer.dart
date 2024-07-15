import 'package:events_app/views/main.pages/add_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text("John"),
            accountEmail: Text("hello@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                "https://banner2.cleanpng.com/20180418/xqw/kisspng-avatar-computer-icons-business-business-woman-5ad736ba3f2735.7973320115240536902587.jpg",
              ),
            ),
          ),
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
            leading: const Icon(CupertinoIcons.tickets),
            title: const Text('Mening tadbirlarim'),
            onTap: () {
              Navigator.push(
                  context, CupertinoPageRoute(builder: (ctx) => AddEvents()));
            },
          ),
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
            leading: const Icon(Icons.person_2_outlined),
            title: const Text("Profil Ma'lumotlari"),
            onTap: () {},
          ),
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
            leading: const Icon(Icons.translate),
            title: const Text("Tillarni o'zgartirish"),
            onTap: () {},
          ),
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
            leading: Image.asset(
              "assets/icons/theme_mode.png",
              width: 23,
            ),
            title: const Text("Tungi / kunduzgi holat"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
