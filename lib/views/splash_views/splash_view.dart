import 'package:flutter/material.dart';
import 'package:pathly/views/Auth_views/auth_view.dart';
import 'package:pathly/views/splash_views/initial_view.dart';
import 'package:pathly/views/splash_views/second_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _topAnimation;
  late Animation<double> _rightAnimation;
  late Animation<double> _bottomAnimation;
  late Animation<double> _leftAnimation;

  bool _isInitialized = false;
  bool _isAnimationCompleted = false;
  bool _showInitialScreen = true;
  bool _showsignupview = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isAnimationCompleted = true;
        });

        Future.delayed(const Duration(milliseconds: 50), () {
          setState(() {
            _showsignupview = true;
          });
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      double screenHeight = MediaQuery.of(context).size.height;
      double screenWidth = MediaQuery.of(context).size.width;

      final curvedAnimation = CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      );

      _topAnimation = Tween<double>(
        begin: 0,
        end: -screenHeight / 2,
      ).animate(curvedAnimation);
      _bottomAnimation = Tween<double>(
        begin: 0,
        end: screenHeight / 2,
      ).animate(curvedAnimation);
      _rightAnimation = Tween<double>(
        begin: 0,
        end: screenWidth * 1.9,
      ).animate(curvedAnimation);
      _leftAnimation = Tween<double>(
        begin: 0,
        end: -screenWidth * 1.8,
      ).animate(curvedAnimation);

      setState(() {
        _isInitialized = true;
      });

      Future.delayed(const Duration(milliseconds: 1200), () {
        setState(() {
          _showInitialScreen = false;
        });
        _controller.forward();
      });
    }
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
          if (_showInitialScreen)
            const InitialView()
          else if (_showsignupview)
            AuthView()
          else
            const SecondView(),
          if (!_isAnimationCompleted && !_showInitialScreen) ...[
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Positioned(
                  top: -25 + _topAnimation.value,
                  left: -330,
                  child: Image.asset("assets/images/top.png"),
                );
              },
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  right: -100 - _rightAnimation.value,
                  child: Image.asset("assets/images/right.png"),
                );
              },
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Positioned(
                  height: 555,
                  bottom: -45 - _bottomAnimation.value,
                  right: -250,
                  left: -385,
                  child: Image.asset("assets/images/bottom.png"),
                );
              },
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Positioned(
                  top: 0,
                  bottom: 0,
                  left: -120 + _leftAnimation.value,
                  right: 0,
                  child: Image.asset("assets/images/left.png"),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}
