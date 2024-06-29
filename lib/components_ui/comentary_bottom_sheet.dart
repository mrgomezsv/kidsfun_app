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
  int _maxCharacters = 256; // Máximo de caracteres permitidos

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
            if (_maxCharacters < 0)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Exceso de caracteres permitidos',
                  style: TextStyle(color: Colors.red, fontSize: 20.0),
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: <Widget>[
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                          hintText: 'Escribe tu comentario aquí',
                          border: OutlineInputBorder(),
                        ),
                        minLines: 3,
                        maxLines: 5,
                        onChanged: (text) {
                          setState(() {
                            // Actualizar el contador de caracteres
                            _maxCharacters = 256 - text.length;
                          });
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${256 - _commentController.text.length}/256',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: _maxCharacters >= 20
                                ? Colors.black
                                : Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                        onPressed: _enviarComentario,
                        child: Icon(Icons.send),
                        shape: CircleBorder(),
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    ],
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

    if (comment.length > 256) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Exceso de caracteres permitidos')),
      );
      return;
    }

    Comment newComment = Comment(
      comment: comment,
      userId: _userId,
      productId: int.tryParse(_productId) ?? 0,
    );

    try {
      final response = await CommentApi.sendComment(newComment);

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Comentario enviado con éxito')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al enviar el comentario: ${response.body}')),
        );
      }
    } catch (e) {
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
