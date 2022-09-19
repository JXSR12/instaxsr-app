import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instaxsr/commondrawer.dart';
import 'package:instaxsr/detail.dart';
import 'package:instaxsr/login.dart';
import 'package:instaxsr/globals.dart' as gl;
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: gl.main_color,
        title: const Text("InstaXSR"),
        actions: [
          PopupMenuButton<int>(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 1,
                child: Row(
                  children: [
                    Icon(
                        gl.themeNotifier.getTheme().brightness ==
                                Brightness.dark
                            ? Icons.light_mode
                            : Icons.dark_mode,
                        color: gl.main_color),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                        "Change to ${gl.themeNotifier.getTheme().brightness == Brightness.dark ? "light" : "dark"} mode")
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (gl.themeNotifier.getTheme().brightness == Brightness.dark) {
                setState(() {
                  gl.themeNotifier.setLightMode();
                });
              } else {
                setState(() {
                  gl.themeNotifier.setDarkMode();
                });
              }
            },
          ),
        ],
      ),
      drawer: const CommonDrawer(),
      body: Column(children: [
        const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text("The XSR Products Center",
                style: TextStyle(
                    fontFamily: "main",
                    fontSize: 20,
                    fontWeight: FontWeight.bold))),
        const Padding(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Text(
              "XSR International is a pioneer in the tools and software industry.",
              style: TextStyle(
                fontFamily: "main",
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            )),
        const Padding(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Text(
              "It is globally known as one of the most trustworthy software and services provider.",
              style: TextStyle(
                fontFamily: "main",
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            )),
        const Padding(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Text(
              "InstaXSR is where you can get all of their amazing products.",
              style: TextStyle(
                fontFamily: "main",
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            )),
        CarouselSlider(
            items:
                gl.items.map((e) => Image.asset("assets/${e.id}.png")).toList(),
            options: CarouselOptions(
                height: 300,
                autoPlay: true,
                autoPlayInterval: const Duration(milliseconds: 3000))),
        const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text("Getting to know our products",
                style: TextStyle(
                    fontFamily: "main",
                    fontSize: 20,
                    fontWeight: FontWeight.bold))),
        Expanded(
          child: ListView.builder(
              itemCount: gl.items.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: Card(
                      child: ListTile(
                    title: Text(gl.items[index].name),
                    subtitle: Text(
                      gl.items[index].desc,
                      overflow: TextOverflow.ellipsis,
                    ),
                    leading: SizedBox(
                        width: 100,
                        child: OverflowBox(
                            child: Image(
                                image: AssetImage(
                                    "assets/${gl.items[index].id}.png"),
                                fit: BoxFit.cover))),
                    trailing: const Icon(Icons.arrow_forward_rounded),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return DetailPage(
                          productIdentifier: gl.items[index].id,
                        );
                      }));
                    },
                  )),
                );
              })),
        )
      ]),
    );
  }
}
