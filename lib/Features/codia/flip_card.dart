import 'dart:math';
import 'package:flutter/material.dart';

/// Custom widget that implements a flippable card with front and back sides
class FlipCard extends StatefulWidget {
  final Widget frontSide;
  final Widget backSide;
  final Function onFlip;

  const FlipCard({
    Key? key,
    required this.frontSide,
    required this.backSide,
    required this.onFlip,
  }) : super(key: key);

  @override
  _FlipCardState createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _showFrontSide = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flip() {
    if (_showFrontSide) {
      _controller.forward();
    } else {
      _controller.reverse();
    }

    setState(() {
      _showFrontSide = !_showFrontSide;
    });

    widget.onFlip();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flip,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final angle = _animation.value * pi;
          final transform = Matrix4.identity()
            ..setEntry(3, 2, 0.001) // Perspective
            ..rotateY(angle);

          return Transform(
            transform: transform,
            alignment: Alignment.center,
            child: angle < pi / 2
                ? widget.frontSide
                : Transform(
                    transform: Matrix4.identity()..rotateY(pi),
                    alignment: Alignment.center,
                    child: widget.backSide,
                  ),
          );
        },
      ),
    );
  }
}
