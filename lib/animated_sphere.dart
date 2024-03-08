import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_earth_globe/flutter_earth_globe.dart';
import 'package:flutter_earth_globe/flutter_earth_globe_controller.dart';
import 'package:flutter_earth_globe/sphere_style.dart';

void main() {
  runApp(AnimatedSphereScreen());
}

class AnimatedSphereScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('3D Globe Sphere'),
        ),
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                AnimatedSphere(),
                //MyApp2(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedSphere extends StatefulWidget {
  @override
  _AnimatedSphereState createState() => _AnimatedSphereState();
}

class _AnimatedSphereState extends State<AnimatedSphere>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  double _rotationX = 0;
  double _rotationY = 0;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        setState(() {
          _rotationX += details.delta.dy * 0.01;
          _rotationY += details.delta.dx * 0.01;
        });
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(_rotationX)
              ..rotateY(_rotationY),
            alignment: FractionalOffset.center,
            child: Container(
              width: 300,
              height: 300,
              child: CustomPaint(
                painter: GlobePainter(),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}



class GlobePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);
    final distance = 40.0;
     final innerColor = Colors.red;
    final innerPaint = Paint()..color = innerColor;
    final innerRadius = radius * 0.5;
    canvas.drawCircle(center, innerRadius, innerPaint);
    final outerGradient = RadialGradient(
      colors: [
        Colors.transparent,
        Colors.green.shade100,
        Colors.green.shade200,
      ],
      stops: [0.0, 0.5, 1.0],
    );
    final outerPaint = Paint()..shader = outerGradient.createShader(Rect.fromCircle(center: center, radius: radius + distance));
    canvas.drawCircle(center, radius + distance, outerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

///Another method///
// class GlobePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = min(size.width / 2, size.height / 2);
//
//
//     final gradient = RadialGradient(
//       colors: [
//         Colors.blue,
//         Colors.green,
//         Colors.yellow,
//         Colors.red,
//       ],
//       stops: [0.0, 0.33, 0.66, 1.0],
//     );
//
//
//     final paint = Paint()..shader = gradient.createShader(Rect.fromCircle(center: center, radius: radius));
//
//
//     canvas.drawCircle(center, radius, paint);
//
//
//     final double heightFactor = 0.7;
//     final double controlPointFactor = 0.5;
//     final double controlPointDistance = radius * controlPointFactor;
//
//     final Path path = Path();
//     path.moveTo(center.dx, center.dy - radius);
//
//     final List<Offset> controlPoints = [
//       Offset(center.dx - controlPointDistance, center.dy - heightFactor * radius),
//       Offset(center.dx + controlPointDistance, center.dy - heightFactor * radius),
//     ];
//
//     path.cubicTo(
//       controlPoints[0].dx, controlPoints[0].dy,
//       controlPoints[1].dx, controlPoints[1].dy,
//       center.dx, center.dy - radius,
//     );
//
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
///


///Adding dependency///
// class MyApp2 extends StatefulWidget {
//   @override
//   _MyApp2State createState() => _MyApp2State();
// }
//
// class _MyApp2State extends State<MyApp2> {
//   late FlutterEarthGlobeController _controller ;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = FlutterEarthGlobeController(
//       rotationSpeed: 0.05,
//       isBackgroundFollowingSphereRotation: true,
//       // background: Image.asset('assets/2k_stars.jpg').image,
//        surface: Image.asset('lib/assets/Earth-Erde.jpg').image,
//     );
//     _controller.changeSphereStyle(SphereStyle(
//         shadowColor: Colors.orange,
//         shadowBlurSigma: 100));
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height * 0.9,
//       child: FlutterEarthGlobe(
//         controller: _controller,
//         radius: 120,
//       ),
//     );
//   }
// }
///
