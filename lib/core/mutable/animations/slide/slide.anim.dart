import 'package:flutter/material.dart';

class SlideAnim extends StatefulWidget {
  final Widget child;
  final Offset begin;
  final Offset end;
  final Duration duration;

  const SlideAnim({
    super.key,
    required this.child,
    required this.begin,
    required this.end,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  State<SlideAnim> createState() => _SlideAnimState();
}

class _SlideAnimState extends State<SlideAnim>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: widget.duration,
    vsync: this,
  )..forward();

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: widget.begin,
    end: widget.end,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: widget.child,
    );
  }
}
