import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../apis/commentary/comment_model.dart';
import '../apis/commentary/comment_api.dart';

class ComentaryBottomSheet extends StatefulWidget {
  final String productId;

  ComentaryBottomSheet({required this.productId});

  @override
  _ComentaryBottomSheetState createState() => _ComentaryBottomSheetState();
}

class _ComentaryBottomSheetState extends State<ComentaryBottomSheet> {
  final TextEditingController _commentController = TextEditingController();
  String? _userId;
  late String _productId;

  @override
  void initState() {
    super.initState();
    _productId = widget.productId;
    _getUserId();
  }

  void _getUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        _userId = user.uid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Agregar comentario',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: 56.0,
                        maxHeight: MediaQuery.of(context).size.height * 0.6,
                      ),
                      child: TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                          hintText: 'Escribe tu comentario aquí',
                          border: OutlineInputBorder(),
                        ),
                        minLines: 3,
                        maxLines: 5,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  FloatingActionButton(
                    onPressed: _enviarComentario,
                    child: Icon(Icons.send),
                    shape: CircleBorder(),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }

  void _enviarComentario() async {
    String comment = _commentController.text;

    if (comment.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('El comentario no puede estar vacío')),
      );
      return;
    }

    Comment newComment = Comment(
      comment: comment,
      userId: _userId,
      productId: int.tryParse(_productId) ?? 0,
    );

    // Print statements para depuración
    // print('Comment: $comment');
    // print('User ID: $_userId');
    // print('Product ID: ${newComment.productId}');

    try {
      final response = await CommentApi.sendComment(newComment);

      if (response.statusCode == 201) {
        // El comentario se creó exitosamente
        // print('Comentario enviado con éxito');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Comentario enviado con éxito')),
        );
      } else {
        // Hubo un error al crear el comentario
        // print('Error al enviar el comentario: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al enviar el comentario: ${response.body}')),
        );
      }
    } catch (e) {
      // Error de conexión u otro error
      // print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error de conexión: $e')),
      );
    }

    Navigator.pop(context);
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
