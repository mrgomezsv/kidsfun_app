// import 'package:flutter/material.dart';
// import '../product_detail/image_carousel.dart';
//
// class InternalAppBar extends StatelessWidget {
//   final String title;
//   final List<String> images; // Lista de imágenes para el carrusel
//
//   InternalAppBar({required this.title, required this.images});
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(title),
//           bottom: TabBar(
//             tabs: [
//               Tab(
//                 icon: Icon(
//                   Icons.photo,
//                   size: 40,
//                 ),
//               ),
//               Tab(
//                 icon: Icon(
//                   Icons.video_collection,
//                   size: 40,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             ImageCarousel(
//               images: images,
//             ),
//             Center(child: Text('Videos')), // Puedes reemplazar esto con tu widget de videos
//           ],
//         ),
//       ),
//     );
//   }
// }
