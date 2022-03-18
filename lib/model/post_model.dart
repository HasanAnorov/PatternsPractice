class Post {
  final int id;
  final String title ;
  final String body ;
  final int userId ;


  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  Post.fromJson(Map<String,dynamic> json)
      : id = json['id'],
        title = json['title'],
        body = json['body'],
        userId = json['userId'];

  Map<String, dynamic> toJson() => {
    'id' : id,
    'title' : title,
    'body' : body,
    'userId' : userId,
  };
}