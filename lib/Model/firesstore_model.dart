
class User {
  final String userId;
  final String username;
  final String email;
  final String imageUrl;

  User({
    required this.userId,
    required this.username,
    required this.email,
    required this.imageUrl,
  });

  factory User.fromDocument(String id, Map<String, dynamic> doc) {
    return User(
      userId: id,
      username: doc['username'] ?? '',
      email: doc['email'] ?? '',
      imageUrl: doc['imageUrl'] ?? '',
    );
  }
}


