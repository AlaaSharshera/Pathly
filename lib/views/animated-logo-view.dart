import 'package:flutter/material.dart';
import 'package:pathly/constant.dart';

class AnimatedLogoView extends StatefulWidget {
  final VoidCallback onAnimationComplete;

  const AnimatedLogoView({super.key, required this.onAnimationComplete});
  

  @override
  State<AnimatedLogoView> createState() => _AnimatedLogoViewState();
}

class _AnimatedLogoViewState extends State<AnimatedLogoView> with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _slideController;

  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;

  bool startSlide = false;
  bool animateText = false;

  @override
  void initState() {
    super.initState();

    // Step 1: Scale animation
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.2).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    // Step 2: Slide upward
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -5),
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeInOut),
    );

    Future.delayed(const Duration(milliseconds: 1500), () {
  _scaleController.forward().whenComplete(() {
    setState(() {
      startSlide = true;
    });
    _slideController.forward().whenComplete(() {
      widget.onAnimationComplete(); 
    });
  });

  setState(() {
    animateText = true;
  });
});

  }

  @override
  void dispose() {
    _scaleController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  Widget _buildAnimatedImage(Widget child) {
    Widget image = ScaleTransition(scale: _scaleAnimation, child: child);

    if (startSlide) {
      image = SlideTransition(position: _slideAnimation, child: image);
    }

    return image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                _buildAnimatedImage(
                  Image.asset("assets/icons/logoVector.png", width: 350),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: 100,
                  child: Column(
                    children: [
                      _buildAnimatedImage(
                        Image.asset("assets/icons/small_heatmap.png"),
                      ),
                      const SizedBox(height: 30),
                      _buildAnimatedImage(
                        Image.asset("assets/icons/logo_arrow.png"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 120),
            AnimatedSlide(
              duration: const Duration(milliseconds: 1500),
              offset: animateText ? const Offset(0, -10) : Offset.zero,
              curve: Curves.easeInOut,
              child: Image.asset("assets/images/DriveSmart,StaySafe!.png"),
            ),
          ],
        ),
      ),
    );
  }
}
