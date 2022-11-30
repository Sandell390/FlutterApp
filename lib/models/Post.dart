import 'User.dart';

class Post {
  late String columnName;
  late String title;
  late String description;
  late User creator;
  Post(
      {required this.columnName,
      required this.creator,
      required this.description,
      required this.title});

  Post.fromJson(dynamic json) {
    print("hej");
    columnName = json["columnName"];
    creator = User.fromJson(json["creator"]);
    description = json["description"];
    title = json["title"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['columnName'] = columnName;
    data['creator'] = creator.toJson();
    data['description'] = description;
    return data;
  }

  static List<Post> generatePosts() {
    return [
      Post(
        columnName: "Todo",
        title: "Add Feature",
        creator: User(Avatar: "asd", Username: "Mr. Bond"),
        description:
            "Bla bla add new feature. dasalskasjdlkasjdlkajsdlkjasldkjalksjjdlakjsldkjalskjdlakjsdlkjasldkjjalskjdlakjsjldkajjslkdjalksjdljdlaksjdl kjasldk jaslkjd",
      ),
      Post(
        columnName: "Todo",
        title: "Add Feature",
        creator: User(Avatar: "asd", Username: "Mr. Bond"),
        description: "Bla bla add new feature. dasalsdlaksjdl kjasldk jaslkjd",
      ),
      Post(
        columnName: "Todo",
        title: "Add Feature",
        creator: User(Avatar: "asd", Username: "Mr. Bond"),
        description: "Bla bla add new feature. dasalsdlaksjdl kjasldk jaslkjd",
      ),
      Post(
        columnName: "Todo",
        title: "Add Feature",
        creator: User(Avatar: "asd", Username: "Mr. Bond"),
        description: "Bla bla add new feature. dasalsdlaksjdl kjasldk jaslkjd",
      ),
      Post(
        columnName: "Todo",
        title: "Add Feature",
        creator: User(Avatar: "asd", Username: "Mr. Bond"),
        description: "Bla bla add new feature. dasalsdlaksjdl kjasldk jaslkjd",
      ),
      Post(
        columnName: "Todo",
        title: "Add Feature",
        creator: User(Avatar: "asd", Username: "Mr. Bond"),
        description: "Bla bla add new feature. dasalsdlaksjdl kjasldk jaslkjd",
      ),
      Post(
        columnName: "Todo",
        title: "Add Feature",
        creator: User(Avatar: "asd", Username: "Mr. Bond"),
        description: "Bla bla add new feature. dasalsdlaksjdl kjasldk jaslkjd",
      ),
      Post(
        columnName: "Todo",
        title: "Add Feature",
        creator: User(Avatar: "asd", Username: "Mr. Bond"),
        description: "Bla bla add new feature. dasalsdlaksjdl kjasldk jaslkjd",
      ),
      Post(
        columnName: "Working on",
        title: "Add Feature",
        creator: User(Avatar: "asd", Username: "Mr. Bond"),
        description: "Bla bla add new feature. dasalsdlaksjdl kjasldk jaslkjd",
      ),
      Post(
        columnName: "Done",
        title: "Add Feature",
        creator: User(Avatar: "asd", Username: "Mr. Bond"),
        description: "Bla bla add new feature. dasalsdlaksjdl kjasldk jaslkjd",
      ),
      Post(
        columnName: "Done",
        title: "Add Feature",
        creator: User(Avatar: "asd", Username: "Mr. Bond"),
        description: "Bla bla add new feature. dasalsdlaksjdl kjasldk jaslkjd",
      ),
      Post(
        columnName: "Done",
        title: "Add Feature",
        creator: User(Avatar: "asd", Username: "Mr. Bond"),
        description: "Bla bla add new feature. dasalsdlaksjdl kjasldk jaslkjd",
      ),
      Post(
        columnName: "Quality Control",
        title: "Add Feature",
        creator: User(Avatar: "asd", Username: "Mr. Bond"),
        description: "Bla bla add new feature. dasalsdlaksjdl kjasldk jaslkjd",
      ),
    ];
  }
}
