import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instaxsr/commondrawer.dart';
import 'package:instaxsr/detail.dart';
import 'package:instaxsr/home.dart';
import 'package:instaxsr/item.dart';
import 'package:instaxsr/login.dart';
import 'package:instaxsr/globals.dart' as gl;
import 'package:instaxsr/storageman.dart';
import 'package:provider/provider.dart';
import 'thememan.dart' as theme;

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => ProductsPageState();
}

int productsCount(String tag) {
  int count = 0;
  for (Item i in gl.items) {
    if (i.tags.contains(tag)) {
      count++;
    }
  }
  return count;
}

List<Item> productsList(String tag) {
  List<Item> list = [];
  for (Item i in gl.items) {
    if (i.tags.contains(tag)) {
      list.add(i);
    }
  }
  return list;
}

ListView productsListView(String tag) {
  return ListView.builder(
      itemCount: productsCount(tag),
      itemBuilder: (context, index) {
        List<Item> itemList = productsList(tag);
        return Padding(
          padding: const EdgeInsets.only(left: 5, right: 10),
          child: Card(
              child: ListTile(
            title: Text(itemList[index].name),
            subtitle: Text(
              itemList[index].desc,
              overflow: TextOverflow.ellipsis,
            ),
            leading: SizedBox(
                width: 100,
                child: OverflowBox(
                    child: Image(
                        image: AssetImage("assets/${itemList[index].id}.png"),
                        fit: BoxFit.cover))),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DetailPage(
                  productIdentifier: itemList[index].id,
                );
              }));
            },
          )),
        );
      });
}

class ProductsPageState extends State<ProductsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: gl.main_color,
              title: const Text(
                "Our Products",
              ),
              bottom: const TabBar(tabs: [
                Tab(icon: Icon(Icons.new_releases)),
                Tab(icon: Icon(Icons.check_box_rounded)),
                Tab(icon: Icon(Icons.construction)),
                Tab(icon: Icon(Icons.dangerous)),
              ]),
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
                    if (gl.themeNotifier.getTheme().brightness ==
                        Brightness.dark) {
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
            body: SafeArea(
                child: Stack(children: [
              TabBarView(children: [
                Column(children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Center(
                    child: Text(
                      "New Products",
                      style: TextStyle(
                        fontFamily: "main",
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(child: productsListView("new"))
                ]),
                Column(children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Center(
                    child: Text(
                      "Released Products",
                      style: TextStyle(
                        fontFamily: "main",
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(child: productsListView("released"))
                ]),
                Column(children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Center(
                    child: Text(
                      "Unreleased Products",
                      style: TextStyle(
                        fontFamily: "main",
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(child: productsListView("unreleased"))
                ]),
                Column(children: [
                  const SizedBox(
                    height: 15,
                  ),
                  const Center(
                    child: Text(
                      "Discontinued Products",
                      style: TextStyle(
                        fontFamily: "main",
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(child: productsListView("discontinued"))
                ]),
              ]),
            ]))));
  }
}
