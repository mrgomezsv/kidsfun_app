import 'package:flutter/material.dart';

class ComentaryBottomSheet extends StatefulWidget {
  @override
  _ComentaryBottomSheetState createState() => _ComentaryBottomSheetState();
}

class _ComentaryBottomSheetState extends State<ComentaryBottomSheet> {
  TextEditingController _commentController = TextEditingController();
  late String _storedComment; // Variable para almacenar el comentario!!! <---

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
    setState(() {
      _storedComment = comment; // Actualiza la variable con el comentario enviado
    });
    // Aquí podrías procesar el comentario (enviarlo a un servidor, almacenarlo localmente, etc.)
    print('Comentario enviado: $comment');
    print('Comentario almacenado: $_storedComment'); // Imprime el comentario almacenado
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
