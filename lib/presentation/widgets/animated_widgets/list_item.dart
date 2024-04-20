import 'package:flutter/material.dart';

class AnimatedListItem extends StatefulWidget {
  final int index;
  final Widget child;
  final VoidCallback? onTap;

  const AnimatedListItem(this.index,
      {super.key, required this.child, this.onTap});

  @override
  State<AnimatedListItem> createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem> {
  bool _animate = false;
  static bool _isStart = true;

  @override
  void initState() {
    super.initState();
    if (_isStart) {
      Future.delayed(Duration(milliseconds: widget.index * 100), () {
        setState(() {
          _animate = true;
          _isStart = false;
        });
      });
    } else {
      _animate = true;
      _isStart = true;
    }
  }

  @override
  void dispose() {
    _animate = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 1000),
      opacity: _animate ? 1 : 0,
      curve: Curves.easeInOutQuart,
      child: AnimatedPadding(
          duration: const Duration(milliseconds: 1000),
          padding: _animate
              ? const EdgeInsets.all(0)
              : const EdgeInsets.only(top: 50, left: 80),
          child: GestureDetector(onTap: widget.onTap, child: widget.child)),
    );
  }
}
