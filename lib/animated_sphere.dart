///new black sphere///
//import 'dart:html';
import 'dart:math';

import 'package:cubixd/cubixd.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter_cube/flutter_cube.dart';

import 'global_sphere.dart';

void main() {
  runApp(MyApp1());
}

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '3d sphere',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: const Text('3d sphere'),
            ),
            body: Container(
                margin: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    const SphereBall(),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GlobalSphere(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          width: 100,
                          color: Colors.indigoAccent,
                          child: Center(child: Text("Click here",style: TextStyle(color: Colors.white),)),
                        ),
                      ),
                    ),
                  ],
                )
            )
        )
    );
  }
}
///shadow sphere
class ShadowSphere extends StatelessWidget {
  final double diameter;
  const ShadowSphere({Key? key, required this.diameter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()..rotateX(math.pi / 2.1),
      origin: Offset(0, diameter),

      child: Container(
        width: this.diameter,
        height: this.diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,

             boxShadow: [
          BoxShadow(blurRadius: 25, color: Colors.grey.withOpacity(0.6))
        ],

        ),
      ),
    );
  }
}

///sphere ball
class SphereBall extends StatefulWidget {
  const SphereBall({Key? key}) : super(key: key);

  @override
  _SphereBallState createState() => _SphereBallState();
}

class _SphereBallState extends State<SphereBall> with SingleTickerProviderStateMixin {
  static const lightSource = Offset(0, -0.75);
  double rotationAngleX = 0.0;
  double rotationAngleY = 0.0;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20),
    )..repeat();
    _controller.stop();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = Size.square(MediaQuery.of(context).size.shortestSide);
    Offset offset = Offset.zero;
    double rotationAngle = 0.0;

    return
      Stack(
      children: [
        ShadowSphere(
          diameter: size.shortestSide,
        ),
    //     // GestureDetector(
    //     //   onPanUpdate: (details) {
    //     //     setState(() {
    //     //       rotationAngleX += details.delta.dy * pi / 180;
    //     //       rotationAngleY += details.delta.dx * pi / 180;
    //     //     });
    //     //   },
    //     //   child:
          Padding(
            padding: const EdgeInsets.only(left: 10,top: 20),
            child: RotationTransition(
              turns: _controller,
              child: Transform.rotate(
                angle: rotationAngleX,
                  child:
                  // Center(
                  //   child: AnimatedCubixD(
                  //     size: 200.0,
                  //     onSelected: (SelectedSide opt) => opt == SelectedSide.bottom ? false : true,
                  //   ),
                  // ),
                  SphereDensity(
                    lightSource: lightSource,
                    diameter: 365,
                    //size.shortestSide,
                    child: Transform(
                      origin: size.center(Offset.zero),
                      transform: Matrix4.identity()..scale(0.5),
                      child: Dcurved(
                       lightSource: lightSource,
                        child: Triangle(text: "Rotate me",),
                      ),
                    ),
                    // rotationAngleX: rotationAngleX,
                    // rotationAngleY: rotationAngleY,
                  ),
              ),
            ),
          ),
      //  ),
      ],
     );

  }
}

///sphere density
class SphereDensity extends StatefulWidget {
  final double diameter;
  final Offset lightSource;
  final Widget child;
  // final double rotationAngleX;
  // final double rotationAngleY;
  const SphereDensity({
    Key? key,
    required this.diameter,
    required this.lightSource,
    required this.child,
    // required this.rotationAngleX,
    // required this.rotationAngleY,
  }) : super(key: key);

  @override
  _SphereDensityState createState() => _SphereDensityState();
}

class _SphereDensityState extends State<SphereDensity> {
  Offset _position = Offset.zero;
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            _position += details.delta;
            _position = _clampPosition(_position);
          });
        },
      child: Container(
        width: this.widget.diameter,
        height: this.widget.diameter,
        decoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
          gradient: RadialGradient(
            center: Alignment(this.widget.lightSource.dx, this.widget.lightSource.dy),
            colors:  [Colors.yellow.shade50, Colors.lightGreen],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 5, // Spread radius
              blurRadius: 7, // Blur radius
              offset: Offset(0, 3), // Offset
            ),
          ],
        ),
        child:ClipOval(
          clipper: CircleClipper(this.widget.diameter),
          child: Transform.translate(
            offset: _position,
            child: this.widget.child,
          ),
        ),
      ),
    );
  }
  Offset _clampPosition(Offset newPosition) {
    double radius = this.widget.diameter / 2;
    double distanceToCenter = newPosition.distance;
    if (distanceToCenter > radius) {
      return newPosition * (radius / distanceToCenter);
    }
    return newPosition;
  }
}

class CircleClipper extends CustomClipper<Rect> {
  final double diameter;

  CircleClipper(this.diameter);

  @override
  Rect getClip(Size size) {
    return Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: diameter / 2);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return false;
  }
}

///triangle///
class Triangle extends StatelessWidget {
  const Triangle({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TrianglePainter(),
      child: Container(
          alignment: Alignment.center,
          child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 30)
          )
      ),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final _gradient =
  LinearGradient(colors: [Colors.redAccent.shade400, Colors.redAccent.shade400]);

  @override
  void paint(Canvas canvas, Size size) {
    final painter = Paint()
      ..shader = _gradient.createShader(Offset.zero & size)
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;
    final path = Path()
      ..moveTo(w * 0.2, h * 0.3)
      ..quadraticBezierTo(w * 0.5, h * 0.1, w * 0.8, h * 0.3)
      ..quadraticBezierTo(w * 0.85, h * 0.6, w * 0.5, h * 0.85)
      ..quadraticBezierTo(w * 0.15, h * 0.6, w * 0.2, h * 0.3)
      ..close();

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(_TrianglePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_TrianglePainter oldDelegate) => false;
}
///
///Dcurved///
class Dcurved extends StatelessWidget {
  final Offset lightSource;
  final Widget child;
  const Dcurved({Key? key, required this.lightSource, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final innerShadowWidth = lightSource.distance * 0.1;
    return  Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          stops: [1-innerShadowWidth , 1],
          colors:  [Colors.lightGreen.shade400, Colors.lightGreen],
        ),
      ),
      child: this.child,
    );
  }
}

///

///***///

///animated cubixd///


enum SelectedSide { front, back, left, right, top, bottom }

class AnimatedCubixD extends StatefulWidget {
  final double size;
  final Function(SelectedSide)? onSelected;

  AnimatedCubixD({required this.size, this.onSelected});

  @override
  _AnimatedCubixDState createState() => _AnimatedCubixDState();
}

class _AnimatedCubixDState extends State<AnimatedCubixD> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  double _rotationX = 0.0;
  double _rotationY = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..repeat();
    //_controller.stop();
  }

  void rotateX(double angle) {
    setState(() {
      _rotationX += angle;
    });
  }

  void rotateY(double angle) {
    setState(() {
      _rotationY += angle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      // GestureDetector(
      // onPanUpdate: (details) {
      //   setState(() {
      //     _rotationX += details.delta.dy * 0.01;
      //     _rotationY += details.delta.dx * 0.01;
      //   });
      // },
      // // child: Transform.rotate(
      // //   angle: _rotationX,
      // //   child: Transform.rotate(
      // //     angle: _rotationY,
      //     child:
      //     AnimatedBuilder(
      //       animation: _controller,
      //       builder: (BuildContext context, Widget? child) {
      //         return
      Center(
        child: Container(
          height: widget.size,
          width: widget.size,
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  height: widget.size,
                  width: widget.size,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              for (SelectedSide side in SelectedSide.values)
                Positioned.fill(
                  child: Align(
                    alignment: _getAlignmentForSide(side),
                    child: GestureDetector(
                      onTap: () {
                        if (widget.onSelected != null) widget.onSelected!(side);
                      },
                      child:
                      Positioned(
                        left: 50,
                        top: 50,
                        child: Container(
                          height: widget.size / 2,
                          width: widget.size / 2,
                          decoration: BoxDecoration(
                            color:_getColorForSide(side),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    // },
    // ),
    //   ),
    // ),
    // );
  }

  Alignment _getAlignmentForSide(SelectedSide side) {
    switch (side) {
      case SelectedSide.front:
        return Alignment(0, 0);
      case SelectedSide.back:
        return Alignment(0, 0);
      case SelectedSide.left:
        return Alignment(-1, 0);
      case SelectedSide.right:
        return Alignment(1, 0);
      case SelectedSide.top:
        return Alignment(0, -1);
      case SelectedSide.bottom:
        return Alignment(0, 1);
    }
  }

  Color _getColorForSide(SelectedSide side) {
    switch (side) {
      case SelectedSide.front:
        return Colors.red;
      case SelectedSide.back:
        return Colors.red;
      case SelectedSide.left:
        return Colors.red;
      case SelectedSide.right:
        return Colors.red;
      case SelectedSide.top:
        return Colors.red;
      case SelectedSide.bottom:
        return Colors.red;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

///

///trianglepainter///
class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
    Path path = Path();

    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
///

///using stackoverflow rotate reference in sphere///
// GestureDetector(
//   onPanUpdate: (details) {
//     print(details);
//     setState(() {
//       offset += details.delta;
//     });
//   },
//   child: Center(
//     child: Transform(
//       transform: Matrix4.identity()
//         ..rotateX(-offset.dy * pi / 180)
//         ..rotateY(-offset.dx * pi / 180),
//       alignment: Alignment.center,
//       child: Stack(
//         children: [
//           Transform(
//             transform: Matrix4.identity()..translate(0.0, 0.0, -100),
//             alignment: Alignment.center,
//             child: SphereDensity(
//               lightSource: lightSource,
//               diameter: size.shortestSide,
//               color: Colors.black,
//             ),
//           ),
//           Transform(
//             transform: Matrix4.identity()
//               ..translate(-100.0, 0.0, 0.0)
//               ..rotateY(-pi / 2),
//             alignment: Alignment.center,
//             child: SphereDensity(
//               lightSource: lightSource,
//               diameter: size.shortestSide,
//               color: Colors.blue,
//             ),
//           ),
//           Transform(
//             transform: Matrix4.identity()..translate(0.0, 0.0, 100.0),
//             child: SphereDensity(
//               lightSource: lightSource,
//               diameter: size.shortestSide,
//               color: Colors.purple,
//             ),
//           ),
//           Transform(
//             transform: Matrix4.identity()
//               ..translate(100.0, 0.0, 0.0)
//               ..rotateY(-pi / 2),
//             alignment: Alignment.center,
//             child: SphereDensity(
//               lightSource: lightSource,
//               diameter: size.shortestSide,
//               color: Colors.red,
//             ),
//           ),
//         ],
//       ),
//     ),
//   ),
// )
///

///using flutter_cube package///
// Container(
// height: 200,
// width: 200,
// child: Cube(
// onSceneCreated: (Scene scene) {
// scene.world.add(Object(fileName: 'lib/assets/Earth-Erde.jpg',));
// },
// ),
//)
///



///old completed code///
// import 'dart:math';
// import 'dart:ui';
// import 'dart:math' as math;
// import 'package:flutter/material.dart';
// import 'package:flutter_earth_globe/flutter_earth_globe.dart';
// import 'package:flutter_earth_globe/flutter_earth_globe_controller.dart';
// import 'package:flutter_earth_globe/sphere_style.dart';
//
// void main() {
//   runApp(AnimatedSphereScreen());
// }
//
// class AnimatedSphereScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('3D Globe Sphere'),
//         ),
//         body: Center(
//           child: SingleChildScrollView(
//             scrollDirection: Axis.vertical,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 AnimatedSphere(),
//                 //MyApp2(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class AnimatedSphere extends StatefulWidget {
//   @override
//   _AnimatedSphereState createState() => _AnimatedSphereState();
// }
//
// class _AnimatedSphereState extends State<AnimatedSphere>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//
//   double _rotationX = 0;
//   double _rotationY = 0;
//   double _angle = 0.0;
//
//   @override
//   void initState() {
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 3),
//     )..repeat();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = Size.square(MediaQuery.of(context).size.shortestSide);
//     return Stack(
//       children: [
//         ShadowSphere(
//           diameter: size.shortestSide,
//         ),
//         Positioned(
//           left: 5,
//           child: GestureDetector(
//             onPanUpdate: (details) {
//               setState(() {
//                 double dx = details.delta.dx;
//                 double dy = details.delta.dy;
//                 double angle = math.atan2(dy, dx);
//                 _angle = angle;
//               });
//             },
//             child: AnimatedBuilder(
//               animation: _controller,
//               builder: (context, child) {
//                 return Transform.rotate(
//                       angle: _angle,
//                       child: Container(
//                         width: 380,
//                         height: 380,
//                         decoration: BoxDecoration(
//                           boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.5), blurRadius: 10.0)],
//                           gradient: RadialGradient(
//                             colors: [
//                               Colors.green.shade100,
//                               Colors.green.shade200,
//                               Colors.green.shade100,
//                             ],
//                             stops: [0.0, 0.5, 1.0],
//                             center: Alignment(0.5, 0.5),
//                             radius: 0.7,
//                           ),
//                           shape: BoxShape.circle,
//                         ),
//                         child: Stack(
//                           children: [
//                             Center(
//                               child: Transform(
//                                 transform: Matrix4.rotationY(_rotationY)..rotateX(_rotationX),
//                                 alignment: Alignment.center,
//                                 child: Container(
//                                   width: 150,
//                                   height: 150,
//                                   decoration: BoxDecoration(
//                                     gradient: RadialGradient(
//                                       colors: [
//                                         Colors.red.shade300.withOpacity(0.2),
//                                         Colors.red.shade500.withOpacity(0.2),
//                                         Colors.red.shade300.withOpacity(0.2),
//                                       ],
//                                       stops: [0.0,0.5,1.0],
//                                       center: Alignment(0.5, 0.5),
//                                       radius: 0.7,
//                                     ),
//                                     shape: BoxShape.circle,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   })
//                 ),
//         ),
//       ],
//     );
//   }
//
//
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }
//
// class BalloonClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//     path.moveTo(size.width / 2, size.height * 0.2);
//     path.quadraticBezierTo(size.width / 2, 0, size.width * 0.7, size.height * 0.05);
//     path.quadraticBezierTo(size.width, size.height * 0.1, size.width, size.height * 0.3);
//     path.quadraticBezierTo(size.width, size.height * 0.6, size.width * 0.7, size.height * 0.8);
//     path.quadraticBezierTo(size.width / 2, size.height, size.width / 2, size.height);
//     path.quadraticBezierTo(size.width / 2, size.height, size.width * 0.3, size.height * 0.8);
//     path.quadraticBezierTo(0, size.height * 0.6, 0, size.height * 0.3);
//     path.quadraticBezierTo(0, size.height * 0.1, size.width * 0.3, size.height * 0.05);
//     path.quadraticBezierTo(size.width / 2, 0, size.width / 2, size.height * 0.2);
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
//
// class ShadowSphere extends StatelessWidget {
//   final double diameter;
//   const ShadowSphere({Key? key, required this.diameter}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Transform(
//       transform: Matrix4.identity()..rotateX(math.pi / 2.1),
//       origin: Offset(0, diameter),
//       child: Container(
//         width: this.diameter,
//         height: this.diameter,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           boxShadow: [
//             BoxShadow(blurRadius: 25, color: Colors.grey.withOpacity(0.6))
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// class GlobePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final center = Offset(size.width / 2, size.height / 2);
//     final radius = min(size.width / 2, size.height / 2);
//     final distance = 40.0;
//     final innerColor = Colors.red;
//     final innerPaint = Paint()..color = innerColor;
//     final innerRadius = radius * 0.5;
//     canvas.drawCircle(center, innerRadius, innerPaint);
//     final outerGradient = RadialGradient(
//       colors: [
//         Colors.transparent,
//         Colors.green.shade100,
//         Colors.green.shade200,
//       ],
//       stops: [0.0, 0.5, 1.0],
//     );
//     final outerPaint = Paint()..shader = outerGradient.createShader(Rect.fromCircle(center: center, radius: radius + distance));
//     canvas.drawCircle(center, radius + distance, outerPaint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
///



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

///old method///
// GestureDetector(
//   onPanUpdate: (details) {
//     setState(() {
//       _rotationX += details.delta.dy * 0.01;
//       _rotationY += details.delta.dx * 0.01;
//     });
//   },
//   child: AnimatedBuilder(
//     animation: _controller,
//     builder: (context, child) {
//       return Transform(
//         transform: Matrix4.identity()
//           ..setEntry(3, 2, 0.001)
//           ..rotateX(_rotationX)
//           ..rotateY(_rotationY),
//         alignment: FractionalOffset.center,
//         child: Container(
//           width: 300,
//           height: 300,
//           child: CustomPaint(
//             painter: GlobePainter(),
//           ),
//         ),
//       );
//     },
//   ),
// ),
///

///
// Container(
//   width: 300,
//   height: 300,
//   decoration: BoxDecoration(
//     gradient: LinearGradient(
//       colors: [
//         Colors.lightGreen,
//         Colors.lightGreenAccent,
//         Colors.green,
//       ],
//       begin: Alignment.topLeft,
//       end: Alignment.bottomRight,
//     ),
//     shape: BoxShape.circle,
//   ),
//   child: Stack(
//     children: [
//       Center(
//         child: Transform(
//           transform: Matrix4.rotationY(_rotationY)..rotateX(_rotationX),
//           alignment: Alignment.center,
//           child: Container(
//             width: 100,
//             height: 100,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Colors.red.shade300,
//                   Colors.red.shade100,
//                   Colors.red,
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               shape: BoxShape.circle,
//             ),
//           ),
//         ),
//       ),
//     ],
//   ),
// ),
///