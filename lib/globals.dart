library instaxsr.globals;

import 'package:flutter/animation.dart';
import 'package:instaxsr/comment.dart';
import 'package:instaxsr/item.dart';
import 'package:instaxsr/thememan.dart';

// ignore: non_constant_identifier_names
Color main_color = Color.fromARGB(255, 230, 93, 121);

String username = "";

ThemeNotifier themeNotifier = ThemeNotifier();

var items = [
  Item(
      id: "pristine",
      name: "XSRPristine",
      desc: "Universal malware and virus analysis and cleaning tool",
      comments: [],
      tags: ["new", "released"]),
  Item(
      id: "skye",
      name: "XSRSkye",
      desc: "Public free cloud storage service for everyone.",
      comments: [],
      tags: ["released"]),
  Item(
      id: "weave",
      name: "XSRWeave",
      desc: "Public premium cloud storage service for dedicated users.",
      comments: [],
      tags: ["new", "released"]),
  Item(
      id: "storm",
      name: "XSRStorm",
      desc: "Private cloud storage service for enterprises.",
      comments: [],
      tags: ["unreleased"]),
  Item(
      id: "give",
      name: "XSRGive",
      desc: "Payment platform for content creators and freelancers.",
      comments: [],
      tags: ["released"]),
  Item(
      id: "markt",
      name: "XSRMarkt",
      desc:
          "Softwares and games marketplace for starters and small developers.",
      comments: [],
      tags: ["discontinued"]),
  Item(
      id: "amaze",
      name: "XSRAmaze",
      desc:
          "Video editing tool made specifically for computer-generated imageries making and cinematic special effects.",
      comments: [],
      tags: ["released"]),
  Item(
      id: "impress",
      name: "XSRImpress",
      desc:
          "Analytics tool for social platforms with intelligent assistant for content making.",
      comments: [],
      tags: ["released"]),
];
