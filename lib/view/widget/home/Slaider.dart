import 'dart:async';
import 'dart:io';
import 'package:chafi/controller/HomeController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../Onbarding/DOT.dart';

class Slaider extends GetView<HomecontrollerImp> {
  const Slaider({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: 200,
            width: double.infinity,
            child: GetBuilder<HomecontrollerImp>(
              builder: (_) {
                if (controller.dataimg.isEmpty) {
                  return emptySlider();
                } else {
                  return PageView.builder(
                    controller: controller.pageController,
                    onPageChanged: controller.Onbardinslider,
                    itemCount: controller.dataimg.length,
                    itemBuilder: (context, i) {
                      return Image.file(
                        File(controller.dataimg[i].image!),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
        // Dot يظهر فقط إذا هناك صور
        GetBuilder<HomecontrollerImp>(
          builder: (_) {
            if (controller.dataimg.isEmpty) return SizedBox.shrink();
            return Positioned(
              bottom: 10,
              left: (Get.width / 2) - ((controller.dataimg.length * 8) + 20),
              child: Dot(),
            );
          },
        ),
      ],
    );
  }
}

Widget emptySlider() {
  return _EmptyAnimatedSlider();
}

class _EmptyAnimatedSlider extends StatefulWidget {
  @override
  State<_EmptyAnimatedSlider> createState() => _EmptyAnimatedSliderState();
}

class _EmptyAnimatedSliderState extends State<_EmptyAnimatedSlider> {
  late PageController _controller;
  int _index = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 1);

    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!_controller.hasClients) return;
      _index = (_index + 1) % 3;
      _controller.animateToPage(
        _index,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      itemCount: 3,
      itemBuilder: (context, i) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            double scale = 1;
            if (_controller.position.haveDimensions) {
              scale = (_controller.page! - i).abs();
              scale = (1 - scale * 0.15).clamp(0.88, 1.0);
            }

            return Center(
              child: Transform.scale(scale: scale, child: child),
            );
          },
          child: _PinterestCard(),
        );
      },
    );
  }
}

class _PinterestCard extends StatefulWidget {
  @override
  State<_PinterestCard> createState() => _PinterestCardState();
}

class _PinterestCardState extends State<_PinterestCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            children: [
              // base card
              Container(
                width: double.infinity,
                height: double.infinity,
                color: const Color(0xFFE5E7EB),
              ),

              // moving white light
              Transform.translate(
                offset: Offset(-300 + (600 * _controller.value), 0),
                child: Container(
                  width: 200,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Colors.white.withOpacity(0.0),
                        Colors.white.withOpacity(0.6),
                        Colors.white.withOpacity(0.0),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
