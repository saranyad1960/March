import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'animated_sphere.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sphere Demo'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SphereBall(
                sphereActionStatus: Icon(
                  Icons.mic_rounded,
                  color: Colors.white,
                  size: 35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SphereBall extends StatefulWidget {
  final Widget sphereActionStatus;

  SphereBall({required this.sphereActionStatus});

  @override
  _SphereBallState createState() => _SphereBallState();
}

class _SphereBallState extends State<SphereBall> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Offset lightSource = Offset(0, -0.75);
  List<List<Color>> _multiSphereColors = [
    [Colors.orange.withOpacity(0.5), Colors.indigoAccent.withOpacity(0.7), Colors.purpleAccent.withOpacity(0.8)],
    [Colors.red.withOpacity(0.5), Colors.blue.withOpacity(0.7), Colors.green.withOpacity(0.8)]
  ];
  int _colorIndex = 0;
  bool opacity = false;
  late Timer _timer;
  bool _isMounted = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 5))..repeat();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_isMounted) {
        _changeSphereColors();
        _changeLightSource();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    _isMounted = false;
    super.dispose();
  }

  void _changeLightSource() {
    setState(() {
      double randomX = Random().nextDouble() * 2 - 1;
      double randomY = Random().nextDouble() * 2 - 1;

      lightSource = Offset(randomX, randomY);
    });
  }

  void _changeSphereColors() {
    setState(() {
      _colorIndex = (_colorIndex + 1) % _multiSphereColors.length;
    });
  }

  double _diameter = 150.0;

  void _changeSize(SizeType sizeType) {
    setState(() {
      switch (sizeType) {
        case SizeType.Large:
          _diameter = 150.0;
          break;
        case SizeType.Medium:
          _diameter = 110.0;
          break;
        case SizeType.Small:
          _diameter = 80.0;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = Size.square(MediaQuery.of(context).size.shortestSide);
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            if (_diameter == 150.0) {
              _changeSize(SizeType.Medium);
            } else if (_diameter == 110.0) {
              _changeSize(SizeType.Small);
            } else {
              _changeSize(SizeType.Large);
            }
            setState(() {
              opacity = true;
            });
            Future.delayed(Duration(seconds: 2), () {
              setState(() {
               opacity = false;
              });
            });
            },
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Opacity(
                opacity: opacity == true ? 1.0 : 1.0 - _controller.value,
                child: Stack(
                  children: [
                    Transform.rotate(
                      angle: _controller.value * 2 * math.pi,
                      child: SphereDensity(
                        lightSource: lightSource,
                        diameter: _diameter,
                        colors: _multiSphereColors[_colorIndex],
                        child: SizedBox.expand(),
                      ),
                    ),
                    Positioned.fill(
                      child: Center(
                        child: widget.sphereActionStatus,
                      ),
                    ),

                  ],
                ),
              );
            },
          ),
        ),
        GestureDetector(
          onTap: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MyApp1(),
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
    );
  }
}


enum SizeType { Large, Medium, Small }

class ShadowSphere extends StatelessWidget {
  final double diameter;
  const ShadowSphere({Key? key, required this.diameter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()..rotateX(math.pi / 2.1),
      origin: Offset(0, diameter),
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(blurRadius: 25, color: Colors.grey.withOpacity(0.8),
            )
          ],
        ),
      ),
    );
  }
}

class SphereDensity extends StatelessWidget {
  final double diameter;
  final Offset lightSource;
  final List<Color> colors;
  final Widget child;

  const SphereDensity({
    Key? key,
    required this.diameter,
    required this.lightSource,
    required this.colors,
    required this.child,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center: Alignment(lightSource.dx, lightSource.dy),
          colors: colors,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Center(child: child),
    );
  }
}




