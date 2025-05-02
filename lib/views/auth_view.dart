import 'package:flutter/material.dart';
import 'package:pathly/widgets/auth_widgets/auth_row.dart';
import 'package:pathly/widgets/auth_widgets/login_form.dart';
import 'package:pathly/widgets/auth_widgets/signup_form.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoPositionAnimation;
  late Animation<double> _logoSizeAnimation;
  bool isSignup = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _logoSizeAnimation = Tween<double>(
      begin: 300,
      end: 150,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    Future.delayed(const Duration(milliseconds: 50), () {
      _controller.forward();
    });
  }

  void toggleForm() {
    setState(() {
      isSignup = !isSignup;
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
      resizeToAvoidBottomInset: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          _logoPositionAnimation = Tween<double>(begin: 0, end: -10).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
          );
          return Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _logoPositionAnimation.value),
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: _logoSizeAnimation.value,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 50,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    width: 382,
                    height: isSignup ? 520 : 480,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.all(22),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child:
                                isSignup
                                    ? const CustomSignupForm()
                                    : const CustomLoginForm(),
                            transitionBuilder:
                                (child, animation) => FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 20,
                  child: AuthRow(
                    text:
                        isSignup
                            ? "Already have an account?"
                            : "Don’t have an account?",
                    buttonText: isSignup ? "Log In" : "Sign Up",
                    onPressed: () => setState(() => isSignup = !isSignup),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
