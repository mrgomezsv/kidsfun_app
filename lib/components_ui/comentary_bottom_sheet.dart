import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ComentaryBottomSheet extends StatefulWidget {
  @override
  _ComentaryBottomSheetState createState() => _ComentaryBottomSheetState();
}

class _ComentaryBottomSheetState extends State<ComentaryBottomSheet> {
  TextEditingController _commentController = TextEditingController();
  late String _storedComment;
  String? _userId;

  @override
  void initState() {
    super.initState();
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
          bottom: MediaQuery.of(context).viewInsets.bottom + 16.0, // Añade un espacio adicional
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
                        maxHeight: MediaQuery.of(context).size.height * 0.6, // Ajusta según sea necesario
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
                    onPressed: () {
                      _enviarComentario();
                    },
                    child: Icon(Icons.send),
                    shape: CircleBorder(),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
            SizedBox(height: 40.0), // Espacio adicional para evitar que los botones queden ocultos por el teclado
          ],
        ),
      ),
    );
  }

  void _enviarComentario() {
    String comment = _commentController.text;
    _storedComment = comment;
    print('###################################################################');
    print('Comentario enviado: $_storedComment');
    print('ID de usuario: $_userId');
    print('###################################################################');
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
