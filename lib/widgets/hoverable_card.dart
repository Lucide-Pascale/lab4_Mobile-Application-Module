import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Reusable widget for interactive cards with smooth hover effects
class HoverableCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final Color hoverColor;
  final EdgeInsets padding;
  final double elevation;
  final double hoverElevation;
  final Duration transitionDuration;

  const HoverableCard({
    super.key,
    required this.child,
    this.onTap,
    this.backgroundColor = AppColors.secondaryBg,
    this.hoverColor = AppColors.softRed,
    this.padding = const EdgeInsets.all(12),
    this.elevation = 2,
    this.hoverElevation = 6,
    this.transitionDuration = const Duration(milliseconds: 250),
  });

  @override
  State<HoverableCard> createState() => _HoverableCardState();
}

class _HoverableCardState extends State<HoverableCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.transitionDuration,
      vsync: this,
    );

    _colorAnimation = ColorTween(
      begin: widget.backgroundColor,
      end: widget.hoverColor,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _elevationAnimation = Tween<double>(
      begin: widget.elevation,
      end: widget.hoverElevation,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onEnter(_) {
    setState(() => _isHovered = true);
    _animationController.forward();
  }

  void _onExit(_) {
    setState(() => _isHovered = false);
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      cursor: widget.onTap != null ? SystemMouseCursors.click : MouseCursor.defer,
      child: AnimatedBuilder(
        animation: Listenable.merge([_colorAnimation, _elevationAnimation]),
        builder: (context, child) {
          return Card(
            elevation: _elevationAnimation.value,
            color: _colorAnimation.value,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: _isHovered ? AppColors.softRed : AppColors.divider,
                width: _isHovered ? 1.5 : 1,
              ),
            ),
            child: GestureDetector(
              onTap: widget.onTap,
              child: Padding(
                padding: widget.padding,
                child: child,
              ),
            ),
          );
        },
        child: widget.child,
      ),
    );
  }
}
