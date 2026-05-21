/*
import 'package:flutter/material.dart';
import 'dart:math' as math;

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

// We use SingleTickerProviderStateMixin to provide a ticker for the AnimationController.
class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  // FIX: Declare the AnimationController variable here.
  late AnimationController _controller;
  String _selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(); // The ..repeat() makes the animation loop indefinitely.
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0A4E6C), Color(0xFF00BFA5)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // 2. Animated Waves at the Bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                // We use a CustomPaint widget to draw the waves.
                return CustomPaint(
                  // The painter is where the wave-drawing logic lives.
                  painter: WavePainter(_controller.value),
                  child: SizedBox(
                    height: 200,
                    width: double.infinity,
                  ),
                );
              },
            ),
          ),

          // 3. Main UI Content
          SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      // App Logo
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: Color.fromRGBO(255, 255, 255, 0.2),
                        child: Icon(Icons.waves, color: Colors.white, size: 40),
                      ),
                      const SizedBox(height: 20),

                      // App Name & Tagline
                      const Text(
                        'SamudraSetu ⛵',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const Text(
                        'समुद्र सेतु',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Bridging Safety & Community',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Main Heading & Description
                      const Text(
                        'Protecting Coastal Communities',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Real-time hazard alerts, community reporting, and emergency response for India\'s coastline. Stay informed, stay safe, stay connected.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white70,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Feature Icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildFeatureIcon(Icons.warning_amber_rounded, 'Live Alerts'),
                          _buildFeatureIcon(Icons.map_outlined, 'Smart Maps'),
                          _buildFeatureIcon(Icons.people_alt_outlined, 'Community'),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Language Selection
                      const Text(
                        'Choose your language / भाषा चुनें',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 2.5,
                        children: [
                          _buildLanguageButton('English', '🇮🇳'),
                          _buildLanguageButton('हिंदी', '🇮🇳'),
                          _buildLanguageButton('தமிழ்', '🇮🇳'),
                          _buildLanguageButton('മലയാളം', '🇮🇳'),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Decorative Sailboat
                      const Text('⛵', style: TextStyle(fontSize: 24)),
                      const SizedBox(height: 10),

                      // Get Started Button
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to the signup screen
                          Navigator.pushNamed(context, '/signup');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0),
                          ),
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFFB74D), Color(0xFFFFA726)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Container(
                            constraints: const BoxConstraints(minWidth: 88.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Get Started',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(Icons.arrow_forward, color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Footer Text
                      const Text(
                        'Join 50,000+ coastal residents staying safe',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 0.15),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: Colors.white, size: 30),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _buildLanguageButton(String language, String flag) {
    final isSelected = _selectedLanguage == language;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLanguage = language;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : const Color.fromRGBO(255, 255, 255, 0.2),
          borderRadius: BorderRadius.circular(12),
          border: isSelected ? Border.all(color: Colors.blue.shade200, width: 2) : null,
        ),
        child: Center(
          child: Text(
            '$flag $language',
            style: TextStyle(
              color: isSelected ? const Color(0xFF0A4E6C) : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// This is the custom painter class that draws the animated waves.
class WavePainter extends CustomPainter {
  final double animationValue;

  WavePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    // We create three paint objects for three overlapping waves.
    final paint1 = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final paint3 = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..style = PaintingStyle.fill;

    // We define three paths for the waves.
    final path1 = Path();
    final path2 = Path();
    final path3 = Path();

    // Start each path from the bottom-left corner.
    path1.moveTo(0, size.height);
    path2.moveTo(0, size.height);
    path3.moveTo(0, size.height);

    // The logic to draw a sine wave.
    // We vary the frequency, amplitude, and phase for each wave to create a parallax effect.
    for (double i = 0.0; i < size.width; i++) {
      // Wave 1
      path1.lineTo(i, size.height * 0.7 + 20 * math.sin((i / size.width * 2 * math.pi) + (animationValue * 2 * math.pi)));
      // Wave 2
      path2.lineTo(i, size.height * 0.7 + 30 * math.sin((i / size.width * 1.5 * math.pi) + (animationValue * 2 * math.pi + math.pi)));
      // Wave 3
      path3.lineTo(i, size.height * 0.7 + 15 * math.sin((i / size.width * 2.5 * math.pi) + (animationValue * 2 * math.pi + math.pi / 2)));
    }

    // Close the paths to the bottom-right and bottom-left to fill the area.
    path1.lineTo(size.width, size.height);
    path1.close();
    path2.lineTo(size.width, size.height);
    path2.close();
    path3.lineTo(size.width, size.height);
    path3.close();

    // Draw the paths on the canvas.
    canvas.drawPath(path3, paint3);
    canvas.drawPath(path2, paint2);
    canvas.drawPath(path1, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // We repaint on every frame of the animation.
    return true;
  }
}

*/
import 'package:flutter/material.dart';
import 'dart:math' as math;

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

// We use SingleTickerProviderStateMixin to provide a ticker for the AnimationController.
class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  // FIX: Declare the AnimationController variable here.
  late AnimationController _controller;
  String _selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(); // The ..repeat() makes the animation loop indefinitely.
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0A4E6C), Color(0xFF00BFA5)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // 2. Animated Waves at the Bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                // We use a CustomPaint widget to draw the waves.
                return CustomPaint(
                  // The painter is where the wave-drawing logic lives.
                  painter: WavePainter(_controller.value),
                  child: SizedBox(
                    height: 200,
                    width: double.infinity,
                  ),
                );
              },
            ),
          ),

          // 3. Main UI Content
          SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      // App Logo
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: Color.fromRGBO(255, 255, 255, 0.2),
                        child: Icon(Icons.waves, color: Colors.white, size: 40),
                      ),
                      const SizedBox(height: 20),

                      // App Name & Tagline
                      const Text(
                        'SamudraSetu',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const Text(
                        'समुद्र सेतु',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Bridging Safety & Community',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Main Heading & Description
                      const Text(
                        'Protecting Coastal Communities',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Real-time hazard alerts, community reporting, and emergency response for India\'s coastline. Stay informed, stay safe, stay connected.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white70,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Feature Icons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildFeatureIcon(Icons.warning_amber_rounded, 'Live Alerts'),
                          _buildFeatureIcon(Icons.map_outlined, 'Smart Maps'),
                          _buildFeatureIcon(Icons.people_alt_outlined, 'Community'),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Language Selection
                      const Text(
                        'Choose your language / भाषा चुनें',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 20),
                      GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 2.5,
                        children: [
                          _buildLanguageButton('English', '🇮🇳'),
                          _buildLanguageButton('हिंदी', '🇮🇳'),
                          _buildLanguageButton('தமிழ்', '🇮🇳'),
                          _buildLanguageButton('മലയാളം', '🇮🇳'),
                        ],
                      ),
                      const SizedBox(height: 50),

                      // Get Started Button
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to the signup screen
                          Navigator.pushNamed(context, '/signup');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0),
                          ),
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFFFB74D), Color(0xFFFFA726)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Container(
                            constraints: const BoxConstraints(minWidth: 88.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Get Started',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(Icons.arrow_forward, color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Footer Text
                      const Text(
                        'Join 50,000+ coastal residents staying safe',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 0.15),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: Colors.white, size: 30),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _buildLanguageButton(String language, String flag) {
    final isSelected = _selectedLanguage == language;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLanguage = language;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : const Color.fromRGBO(255, 255, 255, 0.2),
          borderRadius: BorderRadius.circular(12),
          border: isSelected ? Border.all(color: Colors.blue.shade200, width: 2) : null,
        ),
        child: Center(
          child: Text(
            '$flag $language',
            style: TextStyle(
              color: isSelected ? const Color(0xFF0A4E6C) : Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// This is the custom painter class that draws the animated waves.
class WavePainter extends CustomPainter {
  final double animationValue;

  WavePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    // We create three paint objects for three overlapping waves.
    final paint1 = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = Colors.white.withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final paint3 = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..style = PaintingStyle.fill;

    // We define three paths for the waves.
    final path1 = Path();
    final path2 = Path();
    final path3 = Path();

    // Start each path from the bottom-left corner.
    path1.moveTo(0, size.height);
    path2.moveTo(0, size.height);
    path3.moveTo(0, size.height);

    // The logic to draw a sine wave.
    // We vary the frequency, amplitude, and phase for each wave to create a parallax effect.
    for (double i = 0.0; i < size.width; i++) {
      // Wave 1
      path1.lineTo(i, size.height * 0.7 + 20 * math.sin((i / size.width * 2 * math.pi) + (animationValue * 2 * math.pi)));
      // Wave 2
      path2.lineTo(i, size.height * 0.7 + 30 * math.sin((i / size.width * 1.5 * math.pi) + (animationValue * 2 * math.pi + math.pi)));
      // Wave 3
      path3.lineTo(i, size.height * 0.7 + 15 * math.sin((i / size.width * 2.5 * math.pi) + (animationValue * 2 * math.pi + math.pi / 2)));
    }

    // Close the paths to the bottom-right and bottom-left to fill the area.
    path1.lineTo(size.width, size.height);
    path1.close();
    path2.lineTo(size.width, size.height);
    path2.close();
    path3.lineTo(size.width, size.height);
    path3.close();

    // Draw the paths on the canvas.
    canvas.drawPath(path3, paint3);
    canvas.drawPath(path2, paint2);
    canvas.drawPath(path1, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // We repaint on every frame of the animation.
    return true;
  }
}