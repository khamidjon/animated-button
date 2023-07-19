import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _AnimatedButton(
              size: 112,
              onTap: () {
                print('Button 1 pressed');
              },
            ),
            const SizedBox(width: 16.0),
            _AnimatedButton(
              onTap: () {
                print('Button 2 pressed');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedButton extends StatefulWidget {
  const _AnimatedButton({
    required this.onTap,
    this.size = 130,
  });

  final VoidCallback onTap;
  final double size;

  @override
  State<_AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<_AnimatedButton>
    with SingleTickerProviderStateMixin {
  double _buttonScale = 1;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _buttonScale = 1 - _controller.value;

    return GestureDetector(
      onTapDown: (_) => _startAnimation(),
      onTapUp: (_) {
        _reverseAnimation();
        widget.onTap.call();
      },
      onTapCancel: () => _reverseAnimation(),
      child: Transform.scale(
        scale: _buttonScale,
        child: Container(
          height: widget.size,
          width: widget.size,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                offset: const Offset(0, 4),
                blurRadius: 12.0,
              ),
            ],
          ),
          child: const Center(
            child: Text('Press'),
          ),
        ),
      ),
    );
  }

  void _startAnimation() {
    _controller.forward();
  }

  void _reverseAnimation() {
    _controller.reverse();
  }
}
