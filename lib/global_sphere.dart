import 'dart:ui' as ui;
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:simple_3d/simple_3d.dart';
import 'package:util_simple_3d/util_simple_3d.dart';
import 'package:simple_3d_renderer/simple_3d_renderer.dart';

// import 'package:flutter_gl/flutter_gl.dart';
// import 'package:three_dart/three3d/cameras/perspective_camera.dart' as camera;
// import 'package:three_dart/three3d/cameras/perspective_camera.dart';
// import 'package:three_dart/three3d/objects/mesh.dart' as mesh;
// import 'package:three_dart/three_dart.dart' as three;
import 'dart:math' as math;

import 'animated_sphere.dart';
import 'global_sphere.dart';
///
//import 'package:three_dart/math/math.dart' ;
// import 'package:three_dart/three3d/animation/animation_clip.dart';
// import 'package:three_dart/three3d/animation/animation_mixer.dart';
// import 'package:three_dart/three3d/animation/property_mixer.dart';
// import 'package:three_dart/three3d/constants.dart';
// import 'package:three_dart/three3d/core/object_3d.dart';
// import 'package:three_dart/three3d/extras/core/shape.dart';
// import 'package:three_dart/three3d/math/interpolant.dart';
 //import 'package:three_dart/three3d/math/math.dart' as math;
// import 'package:three_dart/three3d/core/index.dart';
// import 'package:three_dart/three3d/math/index.dart';
// import 'package:three_dart/three_dart.dart' as three_dart;
// import 'package:three_dart/three3d/extras/core/shape.dart' as shapes;



///




class GlobalSphere extends StatefulWidget {
  const GlobalSphere({Key? key}) : super(key: key);

  @override
  State<GlobalSphere> createState() => _GlobalSphereState();
}

class _GlobalSphereState extends State<GlobalSphere> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _rotationAngleX = 0.0;
  double _rotationAngleY = 0.0;
  double _rotationAngleZ = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..repeat();
    _animation = Tween<double>(
      begin: 0,
      end: 2 * 3.14,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: Text('Global sphere'),
        ),
        body: Center(
          child:
          Transform.rotate(
            angle: _rotationAngleX,
            child: Transform.rotate(
              angle: _rotationAngleY,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    _rotationAngleX += details.delta.dy / 100;
                    _rotationAngleY += details.delta.dx / 100;
                  });
                },
                child:
                AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _animation.value,
                      child: Stack(
                        children: [
                          Container(
                            width: 255,
                            height: 255,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                             color: Colors.grey.withOpacity(0.05),
                            ),
                          ),
                          Positioned(
                            left: 75,
                            top: 80,
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red.withOpacity(0.5),
                              ),
                             // child: Text("Hi",style: TextStyle(color: Colors.red),),
                            ),
                          ),
                          Positioned(
                            left: 5,
                            top: 8,
                            child: Container(
                              width: 250,
                              height: 250,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green.withOpacity(0.5),
                               //  gradient: RadialGradient(
                               //    colors: [
                               //      Colors.green.withOpacity(0.2),
                               //      Colors.green.withOpacity(0.1),
                               //    ],
                               //    stops: [0.5, 1.0],
                               //    center: Alignment(0.5, 0.5),
                               //    radius: 0.5,
                               //  ),
                               //  boxShadow: [
                               //    BoxShadow(
                               //      color: Colors.green.withOpacity(0.1),
                               //      blurRadius: 10,
                               //      spreadRadius: 2,
                               //      offset: Offset(0, 3),
                               //    ),
                               //  ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          ///
          // Container(
          //   width: 300,
          //   height: 300,
          //   child: Object3D(
          //     zoom: 100.0,
          //     rotationY: _rotationAngleX,
          //     rotationX: _rotationAngleY,
          //     path: "lib/assets/Earth-Erde.jpg",
          //   ),
          // ),
        ),
      ),
    );
  }
}


///
class RotatableFluffyCircle extends StatefulWidget {
  @override
  _RotatableFluffyCircleState createState() => _RotatableFluffyCircleState();
}

class _RotatableFluffyCircleState extends State<RotatableFluffyCircle> {
  double _rotationAngleX = 0.0;
  double _rotationAngleY = 0.0;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _rotationAngleX,
      child: Transform.rotate(
        angle: _rotationAngleY,
        child: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              _rotationAngleX += details.delta.dy / 100;
              _rotationAngleY += details.delta.dx / 100;
            });
          },
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green.withOpacity(0.1),
              boxShadow: [
                BoxShadow(
                  color: Colors.green.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red.withOpacity(0.1),
                ),
                child: Center(
                  child: Text(
                    'Hello',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// RotatingSizedBox(
// width: 200,
// height: 200,
// frontColor: Colors.blue,
// backColor: Colors.green,
// angle: 45,
// child: Text(
// 'Hello',
// style: TextStyle(fontSize: 20),
// ),
// ),
class RotatingSizedBox extends StatelessWidget {
  final double width;
  final double height;
  final double angle;
  final Color frontColor;
  final Color backColor;
  final Widget child;

  const RotatingSizedBox({
    Key? key,
    required this.width,
    required this.height,
    required this.angle,
    required this.frontColor,
    required this.backColor,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(_toRadians(angle)),
      alignment: Alignment.center,
      child: Stack(
        children: [
          Positioned(
            width: width,
            height: height,
            child: Container(
              color: backColor,
              alignment: Alignment.center,
            ),
          ),
          Positioned(
            width: width,
            height: height,
            child: Container(
              color: frontColor,
              alignment: Alignment.center,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  double _toRadians(double degrees) {
    return degrees * (3.14159265359 / 180);
  }
}

    ///
    //   MaterialApp(
    //     home: Scaffold(
    //       body: Three(
    //         onSceneCreated: (scene) {
    //           final camera = three.PerspectiveCamera(
    //             fov: 0.8,
    //             aspect: 1,
    //             near: 0.1,
    //             far: 10,
    //           )..position.z = 3;
    //
    //
    //           final geometryCylinder = three.CylinderGeometry(
    //             radiusTop: 0.5,
    //             radiusBottom: 0.5,
    //             height: 1,
    //             segments: 32,
    //           );
    //
    //
    //           final materialCylinder = three.MeshBasicMaterial(
    //             color: three.Color(0xff0000),
    //           );
    //
    //
    //           final mesh = three.Mesh(geometryCylinder, materialCylinder);
    //
    //
    //           scene.children.add(mesh);
    //
    //
    //           scene.background = three.Color(0xffffffff);
    //
    //
    //           scene.children.add(three.AmbientLight(color: three.Color(0x222244)));
    //         },
    //       ),
    //     ),
    //   );'
    // Center(
    //   child: RoundedCylinder(
    //     width: 200,
    //     height: 300,
    //     colorTop: Colors.red,
    //     colorBottom: Colors.green,
    //     colorLeft: Colors.blue,
    //     colorRight: Colors.black,
    //   ),
    // ),
    ///
    //   three_jsm.DomLikeListenable(
    //     key: _globalKey,
    //     builder: (BuildContext context) {
    //       return Container(
    //         width: width,
    //         height: height,
    //         color: Colors.black,
    //         child: Builder(builder: (BuildContext context) {
    //           if (kIsWeb) {
    //             return three3dRender.isInitialized
    //                 ? HtmlElementView(
    //                 viewType: three3dRender.textureId!.toString())
    //                 : Container();
    //           } else {
    //             return three3dRender.isInitialized
    //                 ? Texture(textureId: three3dRender.textureId!)
    //                 : Container();
    //           }
    //         }),
    //       );
    //     },
    //   );

///
// class FrontAndBackColoredContainer extends StatelessWidget {
//   final Color frontColor;
//   final Color backColor;
//   final Widget child;
//
//   const FrontAndBackColoredContainer({
//     Key? key,
//     required this.frontColor,
//     required this.backColor,
//     required this.child,
//   }) : super(key: key);
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//
//         Positioned.fill(
//           child: Container(
//             color: backColor,
//             child: child,
//           ),
//         ),
//
//         Container(
//           color: frontColor,
//           child: child,
//         ),
//       ],
//     );
//   }
// }
///



///
///article///
// Future<void> initPlatformState() async {
//   width = screenSize!.width;
//   height = screenSize!.height;
//   three3dRender = FlutterGlPlugin();
//   Map<String, dynamic> options = {
//     "antialias": true,
//     "alpha": false,
//     "width": width.toInt(),
//     "height": height.toInt(),
//     "dpr": dpr
//   };
//   await three3dRender.initialize(options: options);
//   setState(() {});
//   Future.delayed(const Duration(milliseconds: 100), () async {
//     await three3dRender.prepareContext();
//     initScene();
//   });
// }
//
// initSize(BuildContext context) {
//   if (screenSize != null) {
//     return;
//   }
//   final mqd = MediaQuery.of(context);
//   screenSize = mqd.size;
//   dpr = mqd.devicePixelRatio;
//   initPlatformState();
// }
// initScene() {
//   initRenderer();
//   initPage();
// }
// initRenderer() {
//   Map<String, dynamic> options = {
//     "width": width,
//     "height": height,
//     "gl": three3dRender.gl,
//     "antialias": true,
//     "canvas": three3dRender.element
//   };
//   renderer = three.WebGLRenderer(options);
//   renderer!.setPixelRatio(dpr);
//   renderer!.setSize(width, height, false);
//   renderer!.shadowMap.enabled = false;
//   if (!kIsWeb) {
//     var pars = three.WebGLRenderTargetOptions({
//       "minFilter": three.LinearFilter,
//       "magFilter": three.LinearFilter,
//       "format": three.RGBAFormat
//     });
//     renderTarget = three.WebGLRenderTarget(
//         (width * dpr).toInt(), (height * dpr).toInt(), pars);
//     renderTarget.samples = 4;
//     renderer!.setRenderTarget(renderTarget);
//     sourceTexture = renderer!.getRenderTargetGLTexture(renderTarget);
//   }
// }
///
class RoundedCylinder extends StatelessWidget {
  final double width;
  final double height;
  final Color colorTop;
  final Color colorBottom;
  final Color colorLeft;
  final Color colorRight;

  RoundedCylinder({
    required this.width,
    required this.height,
    required this.colorTop,
    required this.colorBottom,
    required this.colorLeft,
    required this.colorRight,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, height),
      painter: CylinderPainter(
        colorTop: colorTop,
        colorBottom: colorBottom,
        colorLeft: colorLeft,
        colorRight: colorRight,
      ),
    );
  }
}

class CylinderPainter extends CustomPainter {
  final Color colorTop;
  final Color colorBottom;
  final Color colorLeft;
  final Color colorRight;

  CylinderPainter({
    required this.colorTop,
    required this.colorBottom,
    required this.colorLeft,
    required this.colorRight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 4;

    final Paint paintTop = Paint()..color = colorTop;
    final Paint paintBottom = Paint()..color = colorBottom;
    final Paint paintLeft = Paint()..color = colorLeft;
    final Paint paintRight = Paint()..color = colorRight;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, radius), radius: radius),
      math.pi,
      math.pi,
      true,
      paintTop,
    );
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, size.height - radius), radius: radius),
      0,
      math.pi,
      true,
      paintBottom,
    );


    final Path path = Path()
      ..moveTo(0, radius)
      ..arcToPoint(Offset(size.width, radius), radius: Radius.circular(radius))
      ..lineTo(size.width, size.height - radius)
      ..arcToPoint(Offset(0, size.height - radius), radius: Radius.circular(radius), clockwise: false)
      ..close();

    canvas.drawPath(path, paintLeft);

    final Path path2 = Path()
      ..moveTo(size.width, radius)
      ..arcToPoint(Offset(0, radius), radius: Radius.circular(radius), clockwise: false)
      ..lineTo(0, size.height - radius)
      ..arcToPoint(Offset(size.width, size.height - radius), radius: Radius.circular(radius))
      ..close();

    canvas.drawPath(path2, paintRight);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
// class ThreeDScene extends StatefulWidget {
//   @override
//   _ThreeDSceneState createState() => _ThreeDSceneState();
// }
//
// class _ThreeDSceneState extends State<ThreeDScene> {
//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1.0,
//       child: three_dart.ThreeDart(
//         backgroundColor: three_dart.Color.black(),
//         scene: createScene(),
//       ),
//     );
//   }
//
//   three_dart.Entity createScene() {
//     final group = three_dart.Entity();
//
//     final sphere = shapes.Sphere(radius: 1.0);
//     final sphereEntity = three_dart.Entity(shape: sphere)
//       ..translate(0.0, 0.0, -5.0);
//
//     group.children.add(sphereEntity);
//
//     return group;
//   }
// }

///
// class ExampleApp extends StatefulWidget {
//   const ExampleApp({Key? key}) : super(key: key);
//
//   @override
//   State<ExampleApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<ExampleApp> {
//   final AppRouterDelegate _routerDelegate = AppRouterDelegate();
//   final AppRouteInformationParser _routeInformationParser = AppRouteInformationParser();
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       title: 'Example app',
//       routerDelegate: _routerDelegate,
//       routeInformationParser: _routeInformationParser,
//     );
//   }
// }
//
// class AppRouteInformationParser extends RouteInformationParser<AppRoutePath> {
//   @override
//   Future<AppRoutePath> parseRouteInformation(RouteInformation routeInformation) async {
//     final uri = Uri.parse(routeInformation.location!);
//     if (uri.pathSegments.isEmpty) {
//       return AppRoutePath.home();
//     }
//
//
//     if (uri.pathSegments.length == 2) {
//       if (uri.pathSegments[0] != 'examples') return AppRoutePath.unknown();
//       var remaining = uri.pathSegments[1];
//       var id = remaining;
//       return AppRoutePath.details(id);
//     }
//
//     return AppRoutePath.unknown();
//   }
//
//   @override
//   RouteInformation? restoreRouteInformation(AppRoutePath configuration) {
//     if (configuration.isUnknown) {
//       return const RouteInformation(location: '/404');
//     }
//     if (configuration.isHomePage) {
//       return const RouteInformation(location: '/');
//     }
//     if (configuration.isDetailsPage) {
//       return RouteInformation(location: '/examples/${configuration.id}');
//     }
//     return null;
//   }
// }
//
// class AppRouterDelegate extends RouterDelegate<AppRoutePath>
//     with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
//   @override
//   final GlobalKey<NavigatorState> navigatorKey;
//
//   String? _selectedExample;
//   bool show404 = false;
//
//   AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();
//
//   @override
//   AppRoutePath get currentConfiguration {
//     if (show404) {
//       return AppRoutePath.unknown();
//     }
//     return _selectedExample == null ? AppRoutePath.home() : AppRoutePath.details(_selectedExample);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Navigator(
//       key: navigatorKey,
//       pages: [
//         MaterialPage(
//           key: const ValueKey('HomePage'),
//           child: HomePage(chooseExample: (id) {
//             _handleExampleTapped(id);
//           }),
//         ),
//         if (show404)
//           const MaterialPage(key: ValueKey('UnknownPage'), child: UnknownScreen())
//         else if (_selectedExample != null)
//           MaterialPage(
//               key: const ValueKey('ExamplePage'),
//               child: Builder(
//                 builder: (BuildContext context) {
//                   return ExamplePage(id: _selectedExample);
//                 },
//               ))
//       ],
//       onPopPage: (route, result) {
//         if (!route.didPop(result)) {
//           return false;
//         }
//
//         _selectedExample = null;
//         show404 = false;
//         notifyListeners();
//
//         return true;
//       },
//     );
//   }
//
//   @override
//   Future<void> setNewRoutePath(AppRoutePath configuration) async {
//     if (configuration.isUnknown) {
//       _selectedExample = null;
//       show404 = true;
//       return;
//     }
//
//     if (configuration.isDetailsPage) {
//       if (configuration.id == null) {
//         show404 = true;
//         return;
//       }
//
//       _selectedExample = configuration.id;
//     } else {
//       _selectedExample = null;
//     }
//
//     show404 = false;
//   }
//
//   void _handleExampleTapped(String id) {
//     _selectedExample = id;
//     notifyListeners();
//   }
// }
//
// class AppRoutePath {
//   final String? id;
//   final bool isUnknown;
//
//   AppRoutePath.home()
//       : id = null,
//         isUnknown = false;
//   AppRoutePath.details(this.id) : isUnknown = false;
//   AppRoutePath.unknown()
//       : id = null,
//         isUnknown = true;
//
//   bool get isHomePage => id == null;
//   bool get isDetailsPage => id != null;
// }
//
// class UnknownScreen extends StatelessWidget {
//   const UnknownScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: const Center(
//         child: Text('404!'),
//       ),
//     );
//   }
// }
// ///
// class HomePage extends StatefulWidget {
//   final Function chooseExample;
//
//   const HomePage({Key? key, required this.chooseExample}) : super(key: key);
//
//   @override
//   _MyAppState1 createState() => _MyAppState1();
// }
//
// class _MyAppState1 extends State<HomePage> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Example app'),
//         ),
//         body: Builder(
//           builder: (BuildContext context) {
//             return ListView.builder(
//                 itemBuilder: (BuildContext context, int index) {
//                   return _buildItem(context, index);
//                 },
//                 itemCount: filesJson.length);
//           },
//         ),
//       ),
//     );
//   }
//
//   String getName(String file) {
//     var name = file.split('_');
//     name.removeAt(0);
//     return name.join(' / ');
//   }
//
//   Widget _buildItem(BuildContext context, int index) {
//     var fileName = filesJson[index];
//
//     var assetFile = "assets/screenshots/$fileName.jpg";
//     var name = getName(fileName);
//
//     return TextButton(
//       onPressed: () {
//         widget.chooseExample(fileName);
//       },
//       child: Column(
//         children: [
//           Container(
//             constraints: const BoxConstraints(minHeight: 50),
//             child: Image.asset(assetFile),
//           ),
//           Text(name)
//         ],
//       ),
//     );
//   }
// }
// ///
// var filesJson = [
//   "webgl_camera",
//   "webgl_camera_array",
//   "webgl_loader_obj",
//   "webgl_shadow_contact",
//   "webgl_geometry_text",
//   "webgl_geometry_shapes",
//   "webgl_materials_browser",
//   "webgl_instancing_performance",
//   "webgl_shadowmap_viewer",
//   "webgl_loader_gltf",
//   // "webgl_loader_gltf_test",
//   "webgl_loader_obj_mtl",
//   "webgl_animation_keyframes",
//   "webgl_loader_texture_basis",
//   "webgl_skinning_simple",
//   "webgl_animation_multiple",
//   "webgl_animation_cloth",
//   "misc_animation_keys",
//   "webgl_clipping_advanced",
//   "webgl_clipping_intersection",
//   "webgl_clipping_stencil",
//   "webgl_clipping",
//   "webgl_geometries",
//   "webgl_materials",
//   "webgl_animation_skinning_blending",
//   "webgl_animation_skinning_additive_blending",
//   "webgl_animation_skinning_morph",
//   "webgl_geometry_colors",
//   "webgl_loader_svg",
//   "webgl_helpers",
//   "webgl_morphtargets",
//   "webgl_morphtargets_sphere",
//   "webgl_morphtargets_horse",
//   "misc_controls_orbit",
//   "misc_controls_trackball",
//   "misc_controls_arcball",
//   "misc_controls_map",
//   "webgl_loader_fbx",
//   "multi_views"
// ];
///
// class ExamplePage extends StatefulWidget {
//   final String? id;
//
//   const ExamplePage({Key? key, this.id}) : super(key: key);
//
//   @override
//   State<ExamplePage> createState() => _MyAppState2();
// }
//
// class _MyAppState2 extends State<ExamplePage> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Widget page;
//
//     String fileName = widget.id!;
//
//     if (fileName == "webgl_camera_array") {
//       page = WebglCameraArray(fileName: fileName);
//     } else if (fileName == "webgl_loader_obj") {
//       page = WebGlLoaderObj(fileName: fileName);
//     } else if (fileName == "webgl_materials_browser") {
//       page = WebglMaterialsBrowser(fileName: fileName);
//     } else if (fileName == "webgl_shadow_contact") {
//       page = WebGlShadowContact(fileName: fileName);
//     } else if (fileName == "webgl_geometry_text") {
//       page = WebGlGeometryText(fileName: fileName);
//     } else if (fileName == "webgl_geometry_shapes") {
//       page = WebGlGeometryShapes(fileName: fileName);
//     } else if (fileName == "webgl_instancing_performance") {
//       page = WebglInstancingPerformance(fileName: fileName);
//     } else if (fileName == "webgl_shadowmap_viewer") {
//       page = WebGlShadowmapViewer(fileName: fileName);
//     } else if (fileName == "webgl_loader_gltf") {
//       page = WebGlLoaderGtlf(fileName: fileName);
//     } else if (fileName == "webgl_loader_gltf_test") {
//       page = WebGlLoaderGltfTest(fileName: fileName);
//     } else if (fileName == "webgl_loader_obj_mtl") {
//       page = WebGlLoaderObjLtl(fileName: fileName);
//     } else if (fileName == "webgl_animation_keyframes") {
//       page = WebGlAnimationKeyframes(fileName: fileName);
//     } else if (fileName == "webgl_loader_texture_basis") {
//       page = WebGlLoaderTextureBasis(fileName: fileName);
//     } else if (fileName == "webgl_animation_multiple") {
//       page = WebGlAnimationMultiple(fileName: fileName);
//     } else if (fileName == "webgl_skinning_simple") {
//       page = WebGlSkinningSimple(fileName: fileName);
//     } else if (fileName == "misc_animation_keys") {
//       page = MiscAnimationKeys(fileName: fileName);
//     } else if (fileName == "webgl_clipping_intersection") {
//       page = WebGlClippingIntersection(fileName: fileName);
//     } else if (fileName == "webgl_clipping_advanced") {
//       page = WebGlClippingAdvanced(fileName: fileName);
//     } else if (fileName == "webgl_clipping_stencil") {
//       page = WebGlClippingStencil(fileName: fileName);
//     } else if (fileName == "webgl_clipping") {
//       page = WebGlClipping(fileName: fileName);
//     } else if (fileName == "webgl_geometries") {
//       page = WebglGeometries(fileName: fileName);
//     } else if (fileName == "webgl_animation_cloth") {
//       page = WebGlAnimationCloth(fileName: fileName);
//     } else if (fileName == "webgl_materials") {
//       page = WebGlMaterials(fileName: fileName);
//     } else if (fileName == "webgl_animation_skinning_blending") {
//       page = WebGlAnimationSkinningBlending(fileName: fileName);
//     } else if (fileName == "webgl_animation_skinning_additive_blending") {
//       page = WebglAnimationSkinningAdditiveBlending(fileName: fileName);
//     } else if (fileName == "webgl_animation_skinning_morph") {
//       page = WebGlAnimationSkinningMorph(fileName: fileName);
//     } else if (fileName == "webgl_camera") {
//       page = WebGlCamera(fileName: fileName);
//     } else if (fileName == "webgl_geometry_colors") {
//       page = WebGlGeometryColors(fileName: fileName);
//     } else if (fileName == "webgl_loader_svg") {
//       page = WebGlLoaderSvg(fileName: fileName);
//     } else if (fileName == "webgl_helpers") {
//       page = WebGlHelpers(fileName: fileName);
//     } else if (fileName == "webgl_morphtargets") {
//       page = WebGlMorphtargets(fileName: fileName);
//     } else if (fileName == "webgl_morphtargets_sphere") {
//       page = WebGlMorphtargetsSphere(fileName: fileName);
//     } else if (fileName == "webgl_morphtargets_horse") {
//       page = WebGlMorphtargetsHorse(fileName: fileName);
//     } else if (fileName == "misc_controls_orbit") {
//       page = MiscControlsOrbit(fileName: fileName);
//     } else if (fileName == "misc_controls_trackball") {
//       page = MiscControlsTrackball(fileName: fileName);
//     } else if (fileName == "misc_controls_arcball") {
//       page = MiscControlsArcball(fileName: fileName);
//     } else if (fileName == "misc_controls_map") {
//       page = MiscControlsMap(fileName: fileName);
//     } else if (fileName == "webgl_loader_fbx") {
//       page = WebGlLoaderFbx(fileName: fileName);
//     } else if (fileName == "multi_views") {
//       page = MultiViews(fileName: fileName);
//     } else {
//       throw ("ExamplePage fileName $fileName is not support yet ");
//     }
//
//     return page;
//   }
// }

// class AnimationAction {
//   late num time;
//   late num timeScale;
//   late AnimationMixer mixer;
//   late AnimationClip clip;
//   late Object3D? localRoot;
//   late int blendMode;
//   late Map _interpolantSettings;
//   late List<Interpolant?> interpolants;
//   late List<PropertyMixer?> propertyBindings;
//   late dynamic cacheIndex;
//   late dynamic byClipCacheIndex;
//   late dynamic _timeScaleInterpolant;
//   late dynamic _weightInterpolant;
//   late int loop;
//   late int _loopCount;
//   late num? _startTime;
//   late num _effectiveTimeScale;
//   late num weight;
//   late num _effectiveWeight;
//   late num repetitions;
//   late bool paused;
//   late bool enabled;
//   late bool clampWhenFinished;
//   late bool zeroSlopeAtStart;
//   late bool zeroSlopeAtEnd;
//
//   AnimationAction(
//       this.mixer,
//       this.clip, {
//         this.localRoot,
//         int? blendMode,
//       }) : blendMode = blendMode ?? clip.blendMode {
//     var tracks = clip.tracks, nTracks = tracks.length;
//
//     interpolants = List<Interpolant?>.filled(nTracks, null);
//
//     var interpolantSettings = {"endingStart": ZeroCurvatureEnding, "endingEnd": ZeroCurvatureEnding};
//
//     for (var i = 0; i != nTracks; ++i) {
//       var interpolant = tracks[i].createInterpolant!(null);
//       interpolants[i] = interpolant;
//       interpolant.settings = interpolantSettings;
//     }
//
//     _interpolantSettings = interpolantSettings;
//
//     // inside: PropertyMixer (managed by the mixer)
//     propertyBindings = List<PropertyMixer?>.filled(nTracks, null);
//
//     cacheIndex = null; // for the memory manager
//     byClipCacheIndex = null; // for the memory manager
//
//     _timeScaleInterpolant = null;
//     _weightInterpolant = null;
//
//     loop = LoopRepeat;
//     _loopCount = -1;
//
//     // global mixer time when the action is to be started
//     // it's set back to 'null' upon start of the action
//     _startTime = null;
//
//     // scaled local time of the action
//     // gets clamped or wrapped to 0..clip.duration according to loop
//     time = 0;
//
//     timeScale = 1;
//     _effectiveTimeScale = 1;
//
//     weight = 1;
//     _effectiveWeight = 1;
//
//     repetitions = double.infinity; // no. of repetitions when looping
//
//     paused = false; // true -> zero effective time scale
//     enabled = true; // false -> zero effective weight
//
//     clampWhenFinished = false; // keep feeding the last frame?
//
//     zeroSlopeAtStart = true; // for smooth interpolation w/o separate
//     zeroSlopeAtEnd = true; // clips for start, loop and end
//   }
//
//   // State & Scheduling
//
//   play() {
//     mixer.activateAction(this);
//
//     return this;
//   }
//
//   stop() {
//     mixer.deactivateAction(this);
//
//     return reset();
//   }
//
//   reset() {
//     paused = false;
//     enabled = true;
//
//     time = 0; // restart clip
//     _loopCount = -1; // forget previous loops
//     _startTime = null; // forget scheduling
//
//     return stopFading().stopWarping();
//   }
//
//   isRunning() {
//     return enabled && !paused && timeScale != 0 && _startTime == null && mixer.isActiveAction(this);
//   }
//
//   // return true when play has been called
//   isScheduled() {
//     return mixer.isActiveAction(this);
//   }
//
//   startAt(time) {
//     _startTime = time;
//
//     return this;
//   }
//
//   setLoop(mode, repetitions) {
//     loop = mode;
//     this.repetitions = repetitions;
//
//     return this;
//   }
//
//   // Weight
//
//   // set the weight stopping any scheduled fading
//   // although .enabled = false yields an effective weight of zero, this
//   // method does *not* change .enabled, because it would be confusing
//   setEffectiveWeight(weight) {
//     this.weight = weight;
//
//     // note: same logic as when updated at runtime
//     _effectiveWeight = enabled ? weight : 0;
//
//     return stopFading();
//   }
//
//   // return the weight considering fading and .enabled
//   getEffectiveWeight() {
//     return _effectiveWeight;
//   }
//
//   fadeIn(duration) {
//     return _scheduleFading(duration, 0, 1);
//   }
//
//   fadeOut(duration) {
//     return _scheduleFading(duration, 1, 0);
//   }
//
//   crossFadeFrom(fadeOutAction, duration, warp) {
//     fadeOutAction.fadeOut(duration);
//     fadeIn(duration);
//
//     if (warp) {
//       var fadeInDuration = clip.duration,
//           fadeOutDuration = fadeOutAction.clip.duration,
//           startEndRatio = fadeOutDuration / fadeInDuration,
//           endStartRatio = fadeInDuration / fadeOutDuration;
//
//       fadeOutAction.warp(1.0, startEndRatio, duration);
//       this.warp(endStartRatio, 1.0, duration);
//     }
//
//     return this;
//   }
//
//   crossFadeTo(fadeInAction, duration, warp) {
//     return fadeInAction.crossFadeFrom(this, duration, warp);
//   }
//
//   stopFading() {
//     var weightInterpolant = _weightInterpolant;
//
//     if (weightInterpolant != null) {
//       _weightInterpolant = null;
//       mixer.takeBackControlInterpolant(weightInterpolant);
//     }
//
//     return this;
//   }
//
//   // Time Scale Control
//
//   // set the time scale stopping any scheduled warping
//   // although .paused = true yields an effective time scale of zero, this
//   // method does *not* change .paused, because it would be confusing
//   setEffectiveTimeScale(timeScale) {
//     this.timeScale = timeScale;
//     _effectiveTimeScale = paused ? 0 : timeScale;
//
//     return stopWarping();
//   }
//
//   // return the time scale considering warping and .paused
//   getEffectiveTimeScale() {
//     return _effectiveTimeScale;
//   }
//
//   setDuration(duration) {
//     timeScale = clip.duration / duration;
//
//     return stopWarping();
//   }
//
//   syncWith(action) {
//     time = action.time;
//     timeScale = action.timeScale;
//
//     return stopWarping();
//   }
//
//   halt(duration) {
//     return warp(_effectiveTimeScale, 0, duration);
//   }
//
//   warp(startTimeScale, endTimeScale, duration) {
//     var now = mixer.time, timeScale = this.timeScale;
//
//     var interpolant = _timeScaleInterpolant;
//
//     if (interpolant == null) {
//       interpolant = mixer.lendControlInterpolant();
//       _timeScaleInterpolant = interpolant;
//     }
//
//     var times = interpolant.parameterPositions, values = interpolant.sampleValues;
//
//     times[0] = now;
//     times[1] = now + duration;
//
//     values[0] = startTimeScale / timeScale;
//     values[1] = endTimeScale / timeScale;
//
//     return this;
//   }
//
//   stopWarping() {
//     var timeScaleInterpolant = _timeScaleInterpolant;
//
//     if (timeScaleInterpolant != null) {
//       _timeScaleInterpolant = null;
//       mixer.takeBackControlInterpolant(timeScaleInterpolant);
//     }
//
//     return this;
//   }
//
//   // Object Accessors
//
//   getMixer() {
//     return mixer;
//   }
//
//   getClip() {
//     return clip;
//   }
//
//   getRoot() {
//     return localRoot ?? mixer.root;
//   }
//
//   // Interna
//
//   update(time, deltaTime, timeDirection, accuIndex) {
//     // called by the mixer
//
//     if (!enabled) {
//       // call ._updateWeight() to update ._effectiveWeight
//
//       _updateWeight(time);
//       return;
//     }
//
//     var startTime = _startTime;
//
//     if (startTime != null) {
//       // check for scheduled start of action
//
//       var timeRunning = (time - startTime) * timeDirection;
//       if (timeRunning < 0 || timeDirection == 0) {
//         return; // yet to come / don't decide when delta = 0
//
//       }
//
//       // start
//
//       _startTime = null; // unschedule
//       deltaTime = timeDirection * timeRunning;
//     }
//
//     // apply time scale and advance time
//
//     deltaTime *= _updateTimeScale(time);
//     var clipTime = _updateTime(deltaTime);
//
//     // note: _updateTime may disable the action resulting in
//     // an effective weight of 0
//
//     var weight = _updateWeight(time);
//
//     if (weight > 0) {
//       var propertyMixers = propertyBindings;
//
//       switch (blendMode) {
//         case AdditiveAnimationBlendMode:
//           for (var j = 0, m = interpolants.length; j != m; ++j) {
//             // print("AnimationAction j: ${j} ${interpolants[ j ]} ${propertyMixers[ j ]} ");
//
//             interpolants[j]!.evaluate(clipTime);
//             propertyMixers[j]!.accumulateAdditive(weight);
//           }
//
//           break;
//
//         case NormalAnimationBlendMode:
//         default:
//           for (var j = 0, m = interpolants.length; j != m; ++j) {
//             // print("AnimationAction22 j: ${j} ${interpolants[ j ]} ${propertyMixers[ j ]} ");
//
//             interpolants[j]!.evaluate(clipTime);
//
//             //  print("AnimationAction22 j: ${j} ----- ");
//
//             propertyMixers[j]!.accumulate(accuIndex, weight);
//           }
//       }
//     }
//   }
//
//   _updateWeight(time) {
//     num weight = 0;
//
//     if (enabled) {
//       weight = this.weight;
//       var interpolant = _weightInterpolant;
//
//       if (interpolant != null) {
//         var interpolantValue = interpolant.evaluate(time)[0];
//
//         weight *= interpolantValue;
//
//         if (time > interpolant.parameterPositions[1]) {
//           stopFading();
//
//           if (interpolantValue == 0) {
//             // faded out, disable
//             enabled = false;
//           }
//         }
//       }
//     }
//
//     _effectiveWeight = weight;
//     return weight;
//   }
//
//   _updateTimeScale(time) {
//     num timeScale = 0;
//
//     if (!paused) {
//       timeScale = this.timeScale;
//
//       var interpolant = _timeScaleInterpolant;
//
//       if (interpolant != null) {
//         var interpolantValue = interpolant.evaluate(time)[0];
//
//         timeScale *= interpolantValue;
//
//         if (time > interpolant.parameterPositions[1]) {
//           stopWarping();
//
//           if (timeScale == 0) {
//             // motion has halted, pause
//             paused = true;
//           } else {
//             // warp done - apply final time scale
//             this.timeScale = timeScale;
//           }
//         }
//       }
//     }
//
//     _effectiveTimeScale = timeScale;
//     return timeScale;
//   }
//
//   _updateTime(deltaTime) {
//     var duration = clip.duration;
//     var loop = this.loop;
//
//     var time = this.time + deltaTime;
//     var loopCount = _loopCount;
//
//     var pingPong = (loop == LoopPingPong);
//
//     if (deltaTime == 0) {
//       if (loopCount == -1) return time;
//
//       return (pingPong && (loopCount & 1) == 1) ? duration - time : time;
//     }
//
//     if (loop == LoopOnce) {
//       if (loopCount == -1) {
//         // just started
//
//         _loopCount = 0;
//         _setEndings(true, true, false);
//       }
//
//       handle_stop:
//       {
//         if (time >= duration) {
//           time = duration;
//         } else if (time < 0) {
//           time = 0;
//         } else {
//           this.time = time;
//
//           break handle_stop;
//         }
//
//         if (clampWhenFinished) {
//           paused = true;
//         } else {
//           enabled = false;
//         }
//
//         this.time = time;
//
//         mixer.dispatchEvent(Event({"type": 'finished', "action": this, "direction": deltaTime < 0 ? -1 : 1}));
//       }
//     } else {
//       // repetitive Repeat or PingPong
//
//       if (loopCount == -1) {
//         // just started
//
//         if (deltaTime >= 0) {
//           loopCount = 0;
//
//           _setEndings(true, repetitions == 0, pingPong);
//         } else {
//           // when looping in reverse direction, the initial
//           // transition through zero counts as a repetition,
//           // so leave loopCount at -1
//
//           _setEndings(repetitions == 0, true, pingPong);
//         }
//       }
//
//       if (time >= duration || time < 0) {
//         // wrap around
//
//         print(" duration: $duration ");
//
//         int loopDelta = Math.floor(time / duration); // signed
//         time -= duration * loopDelta;
//
//         loopCount += loopDelta.abs();
//
//         var pending = repetitions - loopCount;
//
//         if (pending <= 0) {
//           // have to stop (switch state, clamp time, fire event)
//
//           if (clampWhenFinished) {
//             paused = true;
//           } else {
//             enabled = false;
//           }
//
//           time = deltaTime > 0 ? duration : 0;
//
//           this.time = time;
//
//           mixer.dispatchEvent(Event({"type": 'finished', "action": this, "direction": deltaTime > 0 ? 1 : -1}));
//         } else {
//           // keep running
//
//           if (pending == 1) {
//             // entering the last round
//
//             var atStart = deltaTime < 0;
//             _setEndings(atStart, !atStart, pingPong);
//           } else {
//             _setEndings(false, false, pingPong);
//           }
//
//           _loopCount = loopCount;
//
//           this.time = time;
//
//           mixer.dispatchEvent(Event({"type": 'loop', "action": this, "loopDelta": loopDelta}));
//         }
//       } else {
//         this.time = time;
//       }
//
//       if (pingPong && (loopCount & 1) == 1) {
//         // invert time for the "pong round"
//
//         return duration - time;
//       }
//     }
//
//     return time;
//   }
//
//   _setEndings(atStart, atEnd, pingPong) {
//     var settings = _interpolantSettings;
//
//     if (pingPong) {
//       settings["endingStart"] = ZeroSlopeEnding;
//       settings["endingEnd"] = ZeroSlopeEnding;
//     } else {
//       // assuming for LoopOnce atStart == atEnd == true
//
//       if (atStart) {
//         settings["endingStart"] = zeroSlopeAtStart ? ZeroSlopeEnding : ZeroCurvatureEnding;
//       } else {
//         settings["endingStart"] = WrapAroundEnding;
//       }
//
//       if (atEnd) {
//         settings["endingEnd"] = zeroSlopeAtEnd ? ZeroSlopeEnding : ZeroCurvatureEnding;
//       } else {
//         settings["endingEnd"] = WrapAroundEnding;
//       }
//     }
//   }
//
//   _scheduleFading(duration, weightNow, weightThen) {
//     var now = mixer.time;
//     var interpolant = _weightInterpolant;
//
//     if (interpolant == null) {
//       interpolant = mixer.lendControlInterpolant();
//       _weightInterpolant = interpolant;
//     }
//
//     var times = interpolant.parameterPositions, values = interpolant.sampleValues;
//
//     times[0] = now;
//     values[0] = weightNow;
//     times[1] = now + duration;
//     values[1] = weightThen;
//
//     return this;
//   }
// }