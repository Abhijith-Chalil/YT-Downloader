import 'package:flutter/material.dart';

class FadeInContainer extends StatefulWidget {
  const FadeInContainer({super.key});

  @override
  _FadeInContainerState createState() => _FadeInContainerState();
}

class _FadeInContainerState extends State<FadeInContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: _animation,
        child: Container(
          padding: const EdgeInsets.all(20),
          color: Colors.red,
          child: const Text('Fade In'),
        ));
  }
}
