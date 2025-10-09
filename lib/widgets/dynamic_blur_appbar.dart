import 'dart:ui';
import 'package:basepack/basepack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
class DynamicBlurAppbar extends StatefulWidget {
  final Widget? title;
  final Widget? bottom;

  final double scrollScaling;
  final double titleHeight;
  final double bottomHeight;
  final double blurSigma;

  final bool pinned;
  final bool floating;

  const DynamicBlurAppbar({
    super.key,
    this.title,
    this.pinned = false,
    this.floating = false,
    required this.titleHeight,
    required this.bottomHeight,
    this.scrollScaling = 0.5,
    this.blurSigma = 10,
    this.bottom,
  });

  @override
  State<DynamicBlurAppbar> createState() => _DynamicBlurAppbarState();
}

class _DynamicBlurAppbarState extends State<DynamicBlurAppbar> {
  ScrollNotificationObserverState? _scrollObserver;
  bool _scrolledUnder = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollObserver?.removeListener(_handleScrollNotification);
    final ScaffoldState? scaffoldState = Scaffold.maybeOf(context);

    if (scaffoldState != null &&
        (scaffoldState.isDrawerOpen || scaffoldState.isEndDrawerOpen)) {
      return;
    }
    _scrollObserver = ScrollNotificationObserver.maybeOf(context);
    _scrollObserver?.addListener(_handleScrollNotification);
  }

  @override
  void dispose() {
    if (_scrollObserver != null) {
      _scrollObserver!.removeListener(_handleScrollNotification);
      _scrollObserver = null;
    }
    super.dispose();
  }

  void _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollUpdateNotification) {
      final bool oldScrolledUnder = _scrolledUnder;
      final ScrollMetrics metrics = notification.metrics;
      switch (metrics.axisDirection) {
        case AxisDirection.up:
          // Scroll view is reversed
          _scrolledUnder = metrics.extentAfter > 0;
        case AxisDirection.down:
          _scrolledUnder = metrics.extentBefore > 0;
        case AxisDirection.right:
        case AxisDirection.left:
          // Scrolled under is only supported in the vertical axis, and should
          // not be altered based on horizontal notifications of the same
          // predicate since it could be a 2D scroller.
          break;
      }

      if (_scrolledUnder != oldScrolledUnder) {
        setState(() {
          // React to a change in MaterialState.scrolledUnder
        });
      }

    }
  }

  @override
  Widget build(BuildContext context) {

    return SliverAppBar(
      pinned: widget.pinned,
      floating: widget.floating,
      expandedHeight: 120 + widget.bottomHeight,
      collapsedHeight: 60 + widget.bottomHeight,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        titlePadding: const EdgeInsets.all(0),
        expandedTitleScale: 1,
        title: ClipRRect(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(_scrolledUnder ? 15 : 0),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: _scrolledUnder ? widget.blurSigma : 0,
              sigmaY: _scrolledUnder ? widget.blurSigma : 0,
            ),
            child: ColoredBox(
              color: _scrolledUnder
                  // ? context.colorScheme.surface.opaque(0.3)
                  ? context.colorScheme.inversePrimary.opaque(0.5)
                  : Colors.transparent,
              child: Column(
                spacing: 12,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.title!
                      .animate(target: _scrolledUnder ? 1 : 0)
                      .scale(
                        duration: 250.ms,
                        // curve: Curves.easeOut,
                        curve: Curves.easeOut,
                        begin: const Offset(1, 1),
                        end: Offset(widget.scrollScaling, widget.scrollScaling),
                        alignment: Alignment.bottomLeft,
                      ),

                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    height: 50, child: widget.bottom),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
