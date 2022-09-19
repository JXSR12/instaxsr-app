import 'package:instaxsr/comment.dart';

class Item {
  String id;
  String name;
  String desc;
  List<Comment> comments;
  List<String> tags;

  Item(
      {required this.id,
      required this.name,
      required this.desc,
      required this.comments,
      required this.tags});
}
