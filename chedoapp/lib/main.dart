import 'package:chedoapp/design.dart';
import 'package:chedoapp/login.dart';
import 'package:flutter/material.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}

class _MyApp extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Chedo_IMS',
        debugShowCheckedModeBanner: false,
        home: ClientView());
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Drawing Paths',
//       home: Container(
//         color: Colors.white,
//         child: CustomPaint(
//           painter: CurvePainter(),
//         ),
//       ),
//     );
//   }
// }

// class CurvePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     var paint = Paint();
//     paint.color = Colors.green[800];
//     paint.style = PaintingStyle.fill; // Change this to fill

//     var path = Path();

//     //path.moveTo(0, size.height * 0.25);
//     //path.quadraticBezierTo(size.width / 2, size.height*0.1, size.width, size.height * 0.25);
//     //path.cubicTo(size.width / 2, size.height*0.1, size.width / 2, size.height/2, size.width, size.height * 0.25);

//     //path.cubicTo(size.width/2, size.height*0.0, size.width / 2,size.height/2.5, size.width, size.height*0.0);

//     path.moveTo(0, 0);
//     path.cubicTo(size.width/1.5, size.height*0.1, size.width/10,size.height*0.5, size.width, size.height);

//     path.lineTo(size.width, 0);
//     path.lineTo(0, 0);

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }
