import 'user.dart';

class Post {
  final String id;
  final String content;
  final String? imageUrl;
  final User user;
  final int likesCount;
  final bool isLiked;
  final DateTime createdAt;
  final DateTime updatedAt;

  Post({
    required this.id,
    required this.content,
    this.imageUrl,
    required this.user,
    required this.likesCount,
    required this.isLiked,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      content: json['content'],
      imageUrl: json['image_url'],
      user: User.fromJson(json['user']),
      likesCount: json['likes_count'],
      isLiked: json['is_liked'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'image_url': imageUrl,
      'user': user.toJson(),
      'likes_count': likesCount,
      'is_liked': isLiked,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
} 