import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instaxsr/comment.dart';
import 'package:instaxsr/commondrawer.dart';
import 'package:instaxsr/home.dart';
import 'package:instaxsr/globals.dart' as gl;
import 'package:instaxsr/item.dart';
import 'package:instaxsr/login.dart';

int productIdToIndex(String id) {
  int idx = 0;
  for (Item i in gl.items) {
    if (i.id == id) {
      return idx;
    }
    idx++;
  }
  return 0;
}

class DetailPage extends StatefulWidget {
  String productIdentifier;
  DetailPage({super.key, required this.productIdentifier});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    int productIndex = productIdToIndex(widget.productIdentifier);
    String product_name = gl.items[productIndex].name;
    String product_img = "assets/${gl.items[productIndex].id}.png";
    String product_desc = gl.items[productIndex].desc;

    TextEditingController cctrl = TextEditingController();

    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: gl.items[productIndex].tags.contains("discontinued")
                  ? Text("$product_name (Discontinued)")
                  : gl.items[productIndex].tags.contains("unreleased")
                      ? Text("$product_name (Unreleased)")
                      : gl.items[productIndex].tags.contains("new")
                          ? Text("NEW! $product_name")
                          : Text(product_name),
              centerTitle: true,
              backgroundColor: gl.main_color,
              bottom: const TabBar(tabs: [
                Tab(icon: Icon(Icons.add_comment_rounded)),
                Tab(icon: Icon(Icons.comment)),
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
            body: TabBarView(
              children: [
                SingleChildScrollView(
                    child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Image.asset(product_img),
                      )),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: gl.main_color,
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 20, right: 10),
                                    child: Text(
                                      product_name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: "main",
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20,
                                        top: 10,
                                        right: 20,
                                        bottom: 15),
                                    child: Text(
                                      product_desc,
                                      textAlign: TextAlign.justify,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: "main",
                                          fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: gl.main_color,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  width: 400,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            left: 20, top: 10, right: 20),
                                        child: Text(
                                          "What do you think?",
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "main",
                                              fontSize: 14),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 10,
                                            bottom: 10),
                                        child: SizedBox(
                                          height: 40,
                                          child: TextField(
                                            controller: cctrl,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14),
                                            decoration: InputDecoration(
                                                suffixIcon: IconButton(
                                                  icon: Icon(
                                                    Icons.add_circle_outlined,
                                                    color: gl.main_color,
                                                  ),
                                                  onPressed: () {
                                                    if (cctrl.text.isEmpty) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                        content: const Text(
                                                            "Comment cannot be empty"),
                                                        backgroundColor:
                                                            gl.main_color,
                                                      ));
                                                    } else {
                                                      gl.items[productIndex]
                                                          .comments
                                                          .insert(
                                                              0,
                                                              Comment(
                                                                  username: gl
                                                                      .username,
                                                                  content: cctrl
                                                                      .text));
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              SnackBar(
                                                        content: const Text(
                                                            "Comment added"),
                                                        backgroundColor:
                                                            gl.main_color,
                                                      ));
                                                    }
                                                  },
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.only(
                                                        bottom: 30 / 2,
                                                        left: 10),
                                                filled: true,
                                                fillColor:
                                                    const Color(0xfff6f8f6),
                                                hintText:
                                                    "Your thoughts about this product",
                                                hintStyle: const TextStyle(
                                                    color: Colors.grey),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                )),
                                            onSubmitted: (val) {
                                              if (val.isEmpty) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: const Text(
                                                      "Comment cannot be empty"),
                                                  backgroundColor:
                                                      gl.main_color,
                                                ));
                                              } else {
                                                gl.items[productIndex].comments
                                                    .insert(
                                                        0,
                                                        Comment(
                                                            username:
                                                                gl.username,
                                                            content: val));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: const Text(
                                                      "Comment added"),
                                                  backgroundColor:
                                                      gl.main_color,
                                                ));
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ))
                  ],
                )),
                Column(
                  children: [
                    Expanded(
                        child: gl.items[productIndex].comments.isEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                child: Card(
                                    child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 75, top: 80),
                                        child: ListTile(
                                          title: const Text("No comments yet"),
                                          subtitle: const Text(
                                            "Be the first to review",
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          leading: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.comments_disabled,
                                                color: gl.main_color,
                                              ),
                                            ],
                                          ),
                                        ))),
                              )
                            : ListView.builder(
                                itemCount:
                                    gl.items[productIndex].comments.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: Card(
                                        child: ListTile(
                                      title: Text(gl.items[productIndex]
                                          .comments[index].username),
                                      subtitle: Text(
                                        gl.items[productIndex].comments[index]
                                            .content,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      leading: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.person_rounded,
                                            color: gl.main_color,
                                          ),
                                        ],
                                      ),
                                    )),
                                  );
                                })),
                  ],
                ),
              ],
            )));
  }
}
