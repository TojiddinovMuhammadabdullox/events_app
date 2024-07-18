import 'package:events_app/providers/user_provider.dart';
import 'package:events_app/providers/theme_provider.dart';
import 'package:events_app/views/events_page/favorit_page.dart';
import 'package:events_app/views/events_page/my_events.dart';
import 'package:events_app/views/main.pages/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<UserProvider>(context, listen: false).fetchUserData();

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              return UserAccountsDrawerHeader(
                accountName: Text(userProvider.name),
                accountEmail: Text(userProvider.email),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: userProvider.imageUrl.isNotEmpty
                      ? NetworkImage(userProvider.imageUrl)
                      : const NetworkImage(
                          "https://banner2.cleanpng.com/20180418/xqw/kisspng-avatar-computer-icons-business-business-woman-5ad736ba3f2735.7973320115240536902587.jpg",
                        ),
                ),
              );
            },
          ),
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
            leading: const Icon(CupertinoIcons.tickets),
            title: const Text('Mening tadbirlarim'),
            onTap: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (ctx) => const MyEvents()));
            },
          ),
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
            leading: const Icon(Icons.person_2_outlined),
            title: const Text("Profil ma'lumotlari"),
            onTap: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (ctx) => const ProfilePage()));
            },
          ),
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
            leading: const Icon(Icons.translate),
            title: const Text("Tillarni o'zgartirish"),
            onTap: () {},
          ),
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return ListTile(
                trailing: Switch(
                  value: themeProvider.isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleTheme();
                  },
                ),
                leading: Image.asset(
                  "assets/icons/theme_mode.png",
                  width: 23,
                ),
                title: const Text("Tungi / Kunduzgi holat"),
              );
            },
          ),
          ListTile(
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
            leading: const Icon(CupertinoIcons.heart_circle_fill),
            title: const Text("Sevimlilar"),
            onTap: () {
              Navigator.push(context,
                  CupertinoPageRoute(builder: (ctx) => const FavoritPage()));
            },
          ),
        ],
      ),
    );
  }
}
