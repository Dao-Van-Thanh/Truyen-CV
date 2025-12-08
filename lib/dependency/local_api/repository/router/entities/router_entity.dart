class RouteEntity {
  final String id;
  final String routeName;
  final String bookId;
  final String timeStamp;

  RouteEntity({
    this.id = '1',
    required this.routeName,
    required this.bookId,
    required this.timeStamp,
  });

  factory RouteEntity.fromMap(Map<String, dynamic> map) {
    return RouteEntity(
      id: map['id'] as String,
      routeName: map['routeName'] as String,
      bookId: map['bookId'] as String,
      timeStamp: map['timeStamp'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'routeName': routeName,
      'bookId': bookId,
      'timeStamp': timeStamp,
    };
  }
}
