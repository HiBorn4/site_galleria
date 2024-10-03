import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'reports_detail.dart'; // Import your reports_detail file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

// Splash Screen with Semicircular Arc Animation
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: Offset(-1.0, 0.0), // Start just off the left side
      end: Offset(0.0, 0.0),    // Move into place (center-left)
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();

    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SlideTransition(
          position: _animation,
          child: Container(
            width: MediaQuery.of(context).size.width, // Full width
            height: 200,
            alignment: Alignment.centerLeft, // Align semicircle to left
            child: CustomPaint(
              painter: SemicircleWithOrbitsPainter(),
            ),
          ),
        ),
      ),
    );
  }
}

// Main Screen with "Solar System" Semicircle and Orbits
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Semicircular Arc on Left Side
          Positioned(
            left: 0, // No gap on the left side
            top: MediaQuery.of(context).size.height / 3,
            child: Container(
              width: MediaQuery.of(context).size.width, // Full width
              height: 300, // Larger height to accommodate orbits
              alignment: Alignment.centerLeft, // Align semicircle to left
              child: CustomPaint(
                painter: SemicircleWithOrbitsPainter(),
              ),
            ),
          ),
          // Icons and labels positioned along the second orbit
          Positioned.fill(
            child: LayoutBuilder(
              builder: (context, constraints) {
                const radius = 240.0; // Same as the second orbit
                const radiusCareer = 220.0;
                const radiusMarriage = 190.0;
                const radiusFamily = 190.0;
                const radiusHealth = 200.0;
                const centerX = 0.0; // Center of the semicircle at (0, centerY)
                final centerY = constraints.maxHeight / 2;

                return Stack(
                  children: [
                    _buildIconOnArc(context, centerX, centerY, radius, pi/2, Icons.business, 'Business'),
                    _buildIconOnArc(context, centerX, centerY, radiusCareer, pi/3.8, Icons.school, 'Career'),
                    _buildIconOnArc(context, centerX, centerY, radiusMarriage, 0, Icons.favorite, 'Marriage'),
                    _buildIconOnArc(context, centerX, centerY, radiusFamily, -pi/3.8, Icons.family_restroom, 'Family'),
                    _buildIconOnArc(context, centerX, centerY, radiusHealth, -pi/2, Icons.health_and_safety, 'Health'),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Function to calculate positions of icons along the arc and build the icon with its label
  Widget _buildIconOnArc(BuildContext context, double centerX, double centerY, double radius, double angle, IconData icon, String label) {
    // Calculate x and y positions along the arc using trigonometric functions
    final x = centerX + radius * cos(angle);
    final y = centerY - radius * sin(angle);

    return Positioned(
      left: x , // Positioning based on calculated x
      top: y ,  // Positioning based on calculated y
      child: GestureDetector(
        onTap: () {
          // Navigate to the reports details page on icon tap
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ReportsDetailScreen()),
          );
        },
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.blueAccent,
              size: 40,
            ),
            SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Painter with Semicircle and Orbits
class SemicircleWithOrbitsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueAccent
      ..style = PaintingStyle.fill;

    // Draw the main semicircle
    final semicirclePath = Path()
      ..moveTo(0, size.height / 2) // Start at the center left
      ..arcTo(
        Rect.fromCircle(center: Offset(0, size.height / 2), radius: 100),
        1.5 * 3.14, // Start from top of the semicircle
        3.14,       // Sweep angle (180 degrees for semicircle)
        false,
      )
      ..close();

    canvas.drawPath(semicirclePath, paint);

    // Draw the semicircular orbits around the main semicircle
    final orbitPaint = Paint()
      ..color = Colors.blueAccent.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // First orbit
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width*0.3, size.height+ size.height*0.3), radius: 140),
      1.5 * 3.14, // Start from top
      3.14,       // 180-degree arc
      false,
      orbitPaint,
    );

    // Second orbit
    canvas.drawArc(
      Rect.fromCircle(center: Offset(0, size.height / 2), radius: 220),
      1.5 * 3.14,
      3.14,
      false,
      orbitPaint,
    );

    // Third orbit
    canvas.drawArc(
      Rect.fromCircle(center: Offset(0, size.height / 2), radius: 360),
      1.5 * 3.14,
      3.14,
      false,
      orbitPaint,
    );

    // Fourth orbit
    canvas.drawArc(
      Rect.fromCircle(center: Offset(0, size.height / 2), radius: 400),
      1.5 * 3.14,
      3.14,
      false,
      orbitPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}


// import 'package:flutter/material.dart';
// import 'reports_detail.dart'; // Import your reports_detail file

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Reports Detail',
//       debugShowCheckedModeBanner: false, // Remove debug banner
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         scaffoldBackgroundColor: const Color(0xFF0B0F19), // Match background color
//       ),
//       home: ReportsDetailScreen(), // Set your ReportsDetailScreen as the home
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'dart:async';
// import 'dart:math';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SplashScreen(),
//     );
//   }
// }

// // Splash Screen with Semicircular Arc Animation
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Offset> _animation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: Duration(seconds: 2),
//       vsync: this,
//     );

//     _animation = Tween<Offset>(
//       begin: Offset(-1.0, 0.0), // Start just off the left side
//       end: Offset(0.0, 0.0),    // Move into place (center-left)
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     ));

//     _controller.forward();

//     Timer(Duration(seconds: 3), () {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => MainScreen()),
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: SlideTransition(
//           position: _animation,
//           child: Container(
//             width: MediaQuery.of(context).size.width, // Full width
//             height: 200,
//             alignment: Alignment.centerLeft, // Align semicircle to left
//             child: CustomPaint(
//               painter: SemicircleWithOrbitsPainter(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Main Screen with "Solar System" Semicircle and Orbits
// class MainScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           // Semicircular Arc on Left Side
//           Positioned(
//             left: 0, // No gap on the left side
//             top: MediaQuery.of(context).size.height / 3,
//             child: Container(
//               width: MediaQuery.of(context).size.width, // Full width
//               height: 300, // Larger height to accommodate orbits
//               alignment: Alignment.centerLeft, // Align semicircle to left
//               child: CustomPaint(
//                 painter: SemicircleWithOrbitsPainter(),
//               ),
//             ),
//           ),
//           // Icons and labels positioned along the second orbit
//           Positioned.fill(
//             child: LayoutBuilder(
//               builder: (context, constraints) {
//                 final radius = 220.0; // Same as the second orbit
//                 final centerX = 0.0; // Center of the semicircle at (0, centerY)
//                 final centerY = constraints.maxHeight / 2;

//                 return Stack(
//                   children: [
//                     _buildIconOnArc(centerX, centerY, radius, pi / 5, Icons.business, 'Business'),
//                     _buildIconOnArc(centerX, centerY, radius, 2 * pi / 5, Icons.school, 'Career'),
//                     _buildIconOnArc(centerX, centerY, radius,  pi / 10, Icons.favorite, 'Marriage'),
//                     _buildIconOnArc(centerX, centerY, radius,  pi / 2, Icons.family_restroom, 'Family'),
//                     _buildIconOnArc(centerX, centerY, radius, 2 * pi / 6, Icons.health_and_safety, 'Health'),
//                   ],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Function to calculate positions of icons along the arc and build the icon with its label
//   Widget _buildIconOnArc(double centerX, double centerY, double radius, double angle, IconData icon, String label) {
//     // Calculate x and y positions along the arc using trigonometric functions
//     final x = centerX + radius * cos(angle);
//     final y = centerY - radius * sin(angle);

//     return Positioned(
//       left: x, // Positioning based on calculated x
//       top: y,  // Positioning based on calculated y
//       child: Column(
//         children: [
//           Icon(
//             icon,
//             color: Colors.blueAccent,
//             size: 40,
//           ),
//           SizedBox(height: 5),
//           Text(
//             label,
//             style: TextStyle(color: Colors.white, fontSize: 14),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Custom Painter with Semicircle and Orbits
// class SemicircleWithOrbitsPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.blueAccent
//       ..style = PaintingStyle.fill;

//     // Draw the main semicircle
//     final semicirclePath = Path()
//       ..moveTo(0, size.height / 2) // Start at the center left
//       ..arcTo(
//         Rect.fromCircle(center: Offset(0, size.height / 2), radius: 100),
//         1.5 * 3.14, // Start from top of the semicircle
//         3.14,       // Sweep angle (180 degrees for semicircle)
//         false,
//       )
//       ..close();

//     canvas.drawPath(semicirclePath, paint);

//     // Draw the semicircular orbits around the main semicircle
//     final orbitPaint = Paint()
//       ..color = Colors.blueAccent.withOpacity(0.5)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2;

//     // First orbit
//     canvas.drawArc(
//       Rect.fromCircle(center: Offset(0, size.height / 2), radius: 140),
//       1.5 * 3.14, // Start from top
//       3.14,       // 180-degree arc
//       false,
//       orbitPaint,
//     );

//     // Second orbit
//     canvas.drawArc(
//       Rect.fromCircle(center: Offset(0, size.height / 2), radius: 220),
//       1.5 * 3.14,
//       3.14,
//       false,
//       orbitPaint,
//     );

//     // Third orbit
//     canvas.drawArc(
//       Rect.fromCircle(center: Offset(0, size.height / 2), radius: 360),
//       1.5 * 3.14,
//       3.14,
//       false,
//       orbitPaint,
//     );
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }


// **
// import 'package:flutter/material.dart';
// import 'dart:async';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SplashScreen(),
//     );
//   }
// }

// // Splash Screen with Semicircular Arc Animation
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Offset> _animation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: Duration(seconds: 2),
//       vsync: this,
//     );

//     _animation = Tween<Offset>(
//       begin: Offset(-1.0, 0.0), // Start just off the left side
//       end: Offset(0.0, 0.0),    // Move into place (center-left)
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     ));

//     _controller.forward();

//     Timer(Duration(seconds: 3), () {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => MainScreen()),
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: SlideTransition(
//           position: _animation,
//           child: Container(
//             width: MediaQuery.of(context).size.width, // Full width
//             height: 200,
//             alignment: Alignment.centerLeft, // Align semicircle to left
//             child: CustomPaint(
//               painter: SemicircleWithOrbitsPainter(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Main Screen with "Solar System" Semicircle and Orbits
// class MainScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           // Semicircular Arc on Left Side
//           Positioned(
//             left: 0, // No gap on the left side
//             top: MediaQuery.of(context).size.height / 3,
//             child: Container(
//               width: MediaQuery.of(context).size.width, // Full width
//               height: 300, // Larger height to accommodate orbits
//               alignment: Alignment.centerLeft, // Align semicircle to left
//               child: CustomPaint(
//                 painter: SemicircleWithOrbitsPainter(),
//               ),
//             ),
//           ),
//           // Icons and labels positioned along the second orbit
//           Positioned(
//             top: MediaQuery.of(context).size.height / 3 + 130, // Adjust to align with second orbit
//             left: 50, // Adjust based on position
//             right: 50, // Padding from both sides
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 buildIconWithLabel(Icons.business, 'Business'),
//                 buildIconWithLabel(Icons.school, 'Career'),
//                 buildIconWithLabel(Icons.favorite, 'Marriage'),
//                 buildIconWithLabel(Icons.family_restroom, 'Family'),
//                 buildIconWithLabel(Icons.health_and_safety, 'Health'),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Helper widget to build icons with labels
//   Widget buildIconWithLabel(IconData iconData, String label) {
//     return Column(
//       children: [
//         Icon(
//           iconData,
//           color: Colors.blueAccent,
//           size: 40,
//         ),
//         SizedBox(height: 5),
//         Text(
//           label,
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 14,
//           ),
//         ),
//       ],
//     );
//   }
// }

// // Custom Painter with Semicircle and Orbits
// class SemicircleWithOrbitsPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.blueAccent
//       ..style = PaintingStyle.fill;

//     // Draw the main semicircle
//     final semicirclePath = Path()
//       ..moveTo(0, size.height / 2) // Start at the center left
//       ..arcTo(
//         Rect.fromCircle(center: Offset(0, size.height / 2), radius: 100),
//         1.5 * 3.14, // Start from top of the semicircle
//         3.14,       // Sweep angle (180 degrees for semicircle)
//         false,
//       )
//       ..close();

//     canvas.drawPath(semicirclePath, paint);

//     // Draw the semicircular orbits around the main semicircle
//     final orbitPaint = Paint()
//       ..color = Colors.blueAccent.withOpacity(0.5)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2;

//     // First orbit
//     canvas.drawArc(
//       Rect.fromCircle(center: Offset(0, size.height / 2), radius: 140),
//       1.5 * 3.14, // Start from top
//       3.14,       // 180-degree arc
//       false,
//       orbitPaint,
//     );

//     // Second orbit
//     canvas.drawArc(
//       Rect.fromCircle(center: Offset(0, size.height / 2), radius: 220),
//       1.5 * 3.14,
//       3.14,
//       false,
//       orbitPaint,
//     );

//     // Third orbit
//     canvas.drawArc(
//       Rect.fromCircle(center: Offset(0, size.height / 2), radius: 360),
//       1.5 * 3.14,
//       3.14,
//       false,
//       orbitPaint,
//     );
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }


// import 'package:flutter/material.dart';
// import 'dart:async';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SplashScreen(),
//     );
//   }
// }

// // Splash Screen with Semicircular Arc Animation
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Offset> _animation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: Duration(seconds: 2),
//       vsync: this,
//     );

//     _animation = Tween<Offset>(
//       begin: Offset(-1.0, 0.0), // Start just off the left side
//       end: Offset(0.0, 0.0),    // Move into place (center-left)
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     ));

//     _controller.forward();

//     Timer(Duration(seconds: 3), () {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => MainScreen()),
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: SlideTransition(
//           position: _animation,
//           child: Container(
//             width: MediaQuery.of(context).size.width, // Full width
//             height: 200,
//             alignment: Alignment.centerLeft, // Align semicircle to left
//             child: CustomPaint(
//               painter: SemicircleWithOrbitsPainter(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Main Screen with "Solar System" Semicircle and Orbits
// class MainScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           // Semicircular Arc on Left Side
//           Positioned(
//             left: 0, // No gap on the left side
//             top: MediaQuery.of(context).size.height / 3,
//             child: Container(
//               width: MediaQuery.of(context).size.width, // Full width
//               height: 300, // Larger height to accommodate orbits
//               alignment: Alignment.centerLeft, // Align semicircle to left
//               child: CustomPaint(
//                 painter: SemicircleWithOrbitsPainter(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Custom Painter with Semicircle and Orbits
// class SemicircleWithOrbitsPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.blueAccent
//       ..style = PaintingStyle.fill;

//     // Draw the main semicircle
//     final semicirclePath = Path()
//       ..moveTo(0, size.height / 2) // Start at the center left
//       ..arcTo(
//         Rect.fromCircle(center: Offset(0, size.height / 2), radius: 100),
//         1.5 * 3.14, // Start from top of the semicircle
//         3.14,       // Sweep angle (180 degrees for semicircle)
//         false,
//       )
//       ..close();

//     canvas.drawPath(semicirclePath, paint);

//     // Draw the semicircular orbits around the main semicircle
//     final orbitPaint = Paint()
//       ..color = Colors.blueAccent.withOpacity(0.5)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2;

//     // First orbit
//     canvas.drawArc(
//       Rect.fromCircle(center: Offset(0, size.height / 2), radius: 140),
//       1.5 * 3.14, // Start from top
//       3.14,       // 180-degree arc
//       false,
//       orbitPaint,
//     );

//     // Second orbit
//     canvas.drawArc(
//       Rect.fromCircle(center: Offset(0, size.height / 2), radius: 220),
//       1.5 * 3.14,
//       3.14,
//       false,
//       orbitPaint,
//     );

//     // Third orbit
//     canvas.drawArc(
//       Rect.fromCircle(center: Offset(0, size.height / 2), radius: 360),
//       1.5 * 3.14,
//       3.14,
//       false,
//       orbitPaint,
//     );
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }


// import 'package:flutter/material.dart';
// import 'dart:async';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SplashScreen(),
//     );
//   }
// }

// // Splash Screen with Semicircular Arc Animation
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Offset> _animation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: Duration(seconds: 2),
//       vsync: this,
//     );

//     _animation = Tween<Offset>(
//       begin: Offset(-1.0, 0.0), // Start just off the left side
//       end: Offset(0.0, 0.0),    // Move into place (center-left)
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     ));

//     _controller.forward();

//     Timer(Duration(seconds: 3), () {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => MainScreen()),
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: SlideTransition(
//           position: _animation,
//           child: Container(
//             width: MediaQuery.of(context).size.width, // Full width
//             height: 200,
//             alignment: Alignment.centerLeft, // Align semicircle to left
//             child: CustomPaint(
//               painter: SemicircleWithOrbitsPainter(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Main Screen with "Solar System" Buttons and Semicircle
// class MainScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           // Semicircular Arc on Left Side
//           Positioned(
//             left: 0, // No gap on the left side
//             top: MediaQuery.of(context).size.height / 3,
//             child: Container(
//               width: MediaQuery.of(context).size.width, // Full width
//               height: 300, // Larger height to accommodate orbits
//               alignment: Alignment.centerLeft, // Align semicircle to left
//               child: CustomPaint(
//                 painter: SemicircleWithOrbitsPainter(),
//               ),
//             ),
//           ),
//           // Rotating Buttons on the Right Side of Semicircle
//           Positioned.fill(
//             child: Align(
//               alignment: Alignment(-0.3, -0.4),
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(builder: (context) => DetailsScreen()),
//                   );
//                 },
//                 child: CircleAvatar(
//                   backgroundColor: Colors.blue,
//                   child: Icon(Icons.business, color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//           Positioned.fill(
//             child: Align(
//               alignment: Alignment(-0.3, 0.1),
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(builder: (context) => DetailsScreen()),
//                   );
//                 },
//                 child: CircleAvatar(
//                   backgroundColor: Colors.blue,
//                   child: Icon(Icons.person, color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//           // Add more rotating buttons as needed
//         ],
//       ),
//     );
//   }
// }

// // Custom Painter with Semicircle and Orbits
// class SemicircleWithOrbitsPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.blueAccent
//       ..style = PaintingStyle.fill;

//     // Draw the main semicircle
//     final semicirclePath = Path()
//       ..moveTo(0, size.height / 2) // Start at the center left
//       ..arcTo(
//         Rect.fromCircle(center: Offset(0, size.height / 2), radius: 100),
//         1.5 * 3.14, // Start from top of the semicircle
//         3.14,       // Sweep angle (180 degrees for semicircle)
//         false,
//       )
//       ..close();

//     canvas.drawPath(semicirclePath, paint);

//     // Draw the semicircular orbits around the main semicircle
//     final orbitPaint = Paint()
//       ..color = Colors.blueAccent.withOpacity(0.5)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2;

//     // First orbit
//     canvas.drawArc(
//       Rect.fromCircle(center: Offset(0, size.height / 2), radius: 140),
//       1.5 * 3.14, // Start from top
//       3.14,       // 180-degree arc
//       false,
//       orbitPaint,
//     );

//     // Second orbit
//     canvas.drawArc(
//       Rect.fromCircle(center: Offset(0, size.height / 2), radius: 220),
//       1.5 * 3.14,
//       3.14,
//       false,
//       orbitPaint,
//     );

//     // Third orbit
//     canvas.drawArc(
//       Rect.fromCircle(center: Offset(0, size.height / 2), radius: 360),
//       1.5 * 3.14,
//       3.14,
//       false,
//       orbitPaint,
//     );
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }

// // Detailed Screen with Options for View and Purchase
// class DetailsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Text('Premium Reports'),
//       ),
//       backgroundColor: Colors.black,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Search Bar
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'Search Marriage, Career, etc.',
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             ),
//           ),
//           // Option List
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               'Marriage',
//               style: TextStyle(color: Colors.white, fontSize: 18),
//             ),
//           ),
//           ListTile(
//             title: Text('Marriage Timing Prediction',
//                 style: TextStyle(color: Colors.white)),
//             subtitle: Text('999.00 ₹',
//                 style: TextStyle(color: Colors.white60)),
//             trailing: Wrap(
//               spacing: 12,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: Text('View'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: Text('Purchase'),
//                 ),
//               ],
//             ),
//           ),
//           // Repeat for more options
//         ],
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'dart:async';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: SplashScreen(),
//     );
//   }
// }

// // Splash Screen with Semicircular Arc Animation
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Offset> _animation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: Duration(seconds: 2),
//       vsync: this,
//     );

//     _animation = Tween<Offset>(
//       begin: Offset(-1.0, 0.0), // Start just off the left side
//       end: Offset(0.0, 0.0),    // Move into place (center-left)
//     ).animate(CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     ));

//     _controller.forward();

//     Timer(Duration(seconds: 3), () {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => MainScreen()),
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: SlideTransition(
//           position: _animation,
//           child: Container(
//             width: MediaQuery.of(context).size.width, // Full width
//             height: 200,
//             alignment: Alignment.centerLeft, // Align semicircle to left
//             child: CustomPaint(
//               painter: SemicirclePainter(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Main Screen with "Solar System" Buttons and Semicircle
// class MainScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           // Semicircular Arc on Left Side
//           Positioned(
//             left: 0, // No gap on the left side
//             top: MediaQuery.of(context).size.height / 3,
//             child: Container(
//               width: MediaQuery.of(context).size.width, // Full width
//               height: 200,
//               alignment: Alignment.centerLeft, // Align semicircle to left
//               child: CustomPaint(
//                 painter: SemicirclePainter(),
//               ),
//             ),
//           ),
//           // Rotating Buttons on the Right Side of Semicircle
//           Positioned.fill(
//             child: Align(
//               alignment: Alignment(-0.3, -0.4),
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(builder: (context) => DetailsScreen()),
//                   );
//                 },
//                 child: CircleAvatar(
//                   backgroundColor: Colors.blue,
//                   child: Icon(Icons.business, color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//           Positioned.fill(
//             child: Align(
//               alignment: Alignment(-0.3, 0.1),
//               child: GestureDetector(
//                 onTap: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute(builder: (context) => DetailsScreen()),
//                   );
//                 },
//                 child: CircleAvatar(
//                   backgroundColor: Colors.blue,
//                   child: Icon(Icons.person, color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//           // Add more rotating buttons as needed
//         ],
//       ),
//     );
//   }
// }

// // Semicircle Painter for the Custom Widget
// class SemicirclePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.blueAccent
//       ..style = PaintingStyle.fill;

//     // Draw a full semicircle on the left side of the canvas
//     final path = Path()
//       ..moveTo(0, size.height / 2) // Start at the center left
//       ..arcTo(
//         Rect.fromCircle(center: Offset(0, size.height / 2), radius: 100),
//         1.5 * 3.14, // Start from top of the semicircle
//         3.14,       // Sweep angle (180 degrees for semicircle)
//         false,
//       )
//       ..close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }

// // Detailed Screen with Options for View and Purchase
// class DetailsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Text('Premium Reports'),
//       ),
//       backgroundColor: Colors.black,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Search Bar
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'Search Marriage, Career, etc.',
//                 filled: true,
//                 fillColor: Colors.white,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//             ),
//           ),
//           // Option List
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               'Marriage',
//               style: TextStyle(color: Colors.white, fontSize: 18),
//             ),
//           ),
//           ListTile(
//             title: Text('Marriage Timing Prediction',
//                 style: TextStyle(color: Colors.white)),
//             subtitle: Text('999.00 ₹',
//                 style: TextStyle(color: Colors.white60)),
//             trailing: Wrap(
//               spacing: 12,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: Text('View'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {},
//                   child: Text('Purchase'),
//                 ),
//               ],
//             ),
//           ),
//           // Repeat for more options
//         ],
//       ),
//     );
//   }
// }


