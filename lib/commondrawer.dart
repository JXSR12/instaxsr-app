import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instaxsr/globals.dart' as gl;
import 'package:instaxsr/home.dart';
import 'package:instaxsr/login.dart';
import 'package:instaxsr/main.dart';
import 'package:instaxsr/products.dart';
import 'package:instaxsr/storageman.dart';

class CommonDrawer extends StatefulWidget {
  const CommonDrawer({super.key});

  @override
  State<CommonDrawer> createState() => _CommonDrawerState();
}

class _CommonDrawerState extends State<CommonDrawer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: gl.main_color,
              ),
              accountName:
                  Text(gl.username, style: const TextStyle(fontSize: 20)),
              accountEmail:
                  const Text("Regular User", style: TextStyle(fontSize: 14)),
              currentAccountPicture: Image.asset("assets/logo_forlight.png"),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: gl.main_color,
              ),
              title: const Text(
                "Home",
                textAlign: TextAlign.right,
              ),
              onTap: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HomePage();
                }))
              },
            ),
            ListTile(
              leading: Icon(
                Icons.apps,
                color: gl.main_color,
              ),
              title: const Text(
                "Our Products",
                textAlign: TextAlign.right,
              ),
              onTap: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ProductsPage();
                }))
              },
            ),
            Divider(
              thickness: 1,
              indent: 10,
              color: gl.main_color,
              endIndent: 10,
            ),
            ListTile(
              leading: Icon(
                Icons.logout_rounded,
                color: Colors.red[400],
              ),
              title: const Text(
                "Sign Out",
                textAlign: TextAlign.right,
              ),
              onTap: () => {
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) {
                  return LoginPage(tnotifier: gl.themeNotifier);
                }), (route) => false)
              },
            ),
          ],
        ),
      ),
    );
  }
}
