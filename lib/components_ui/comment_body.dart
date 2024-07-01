import 'package:flutter/material.dart';
import '../apis/commentary/comment_model.dart';

class CommentBody extends StatelessWidget {
  final Comment comment;

  CommentBody({required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(comment.comment, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 4.0),
          // Text('User ID: ${comment.userId}', style: TextStyle(color: Colors.grey)),
          // SizedBox(height: 4.0),
          Text('From: ${comment.userDisplayName ?? 'Unknown'}', style: TextStyle(color: Colors.grey)),
          Divider(color: Colors.grey),
        ],
      ),
    );
  }
}
