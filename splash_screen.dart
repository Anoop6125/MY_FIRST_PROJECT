import 'dart:async';
import 'package:flutter/material.dart';
import 'package:new_project/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _morphController;
  late AnimationController _fadeController;
  late Animation<double> _morphAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _blurAnimation;
  bool _showLoading = false;

  @override
  void initState() {
    super.initState();
    
    _morphController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );
    
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _morphAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _morphController,
        curve: Curves.easeInOutQuart,
      ),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(
        parent: _morphController,
        curve: Interval(0.0, 0.8, curve: Curves.elasticOut),
      ),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: Curves.easeIn,
      ),
    );
    
    _blurAnimation = Tween<double>(begin: 10.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _morphController,
        curve: Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    _morphController.forward();
    _fadeController.forward();

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _showLoading = true;
      });
    });

    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  void dispose() {
    _morphController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.2,
            colors: [
              Colors.blueAccent.withOpacity(0.8),
              Colors.black87,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _morphController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'MOVIE',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 48,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2.0 + (3.0 * _morphAnimation.value),
                                shadows: [
                                  Shadow(
                                    blurRadius: 10 + (15 * _morphAnimation.value),
                                    color: Colors.black.withOpacity(0.5),
                                    offset: Offset(2, 2),
                                  ),
                                  Shadow(
                                    blurRadius: 20 * _morphAnimation.value,
                                    color: Colors.blueAccent.withOpacity(
                                      0.3 * _morphAnimation.value
                                    ),
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                            ),
                            TextSpan(
                              text: 'FLIX',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 48,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2.0 + (3.0 * _morphAnimation.value),
                                shadows: [
                                  Shadow(
                                    blurRadius: 10 + (15 * _morphAnimation.value),
                                    color: Colors.black.withOpacity(0.5),
                                    offset: Offset(2, 2),
                                  ),
                                  Shadow(
                                    blurRadius: 20 * _morphAnimation.value,
                                    color: Colors.blueAccent.withOpacity(
                                      0.3 * _morphAnimation.value
                                    ),
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 40),
              _showLoading
                  ? FadeTransition(
                      opacity: _fadeAnimation,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.amber),
                        strokeWidth: 5,
                        backgroundColor: Colors.white.withOpacity(0.2),
                      ),
                    )
                  : SizedBox.shrink(),
              SizedBox(height: 40),
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  "Team 4's first project",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}