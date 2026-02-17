import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/HomeController.dart';
import '../../core/constant/Colorapp.dart';
import '../widget/home/CustemCardHome.dart';
import '../widget/home/ScrollCardServece.dart';
import '../widget/home/Slaider.dart';
import '../widget/home/Welcome.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final HomecontrollerImp controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(HomecontrollerImp(), permanent: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: GetBuilder<HomecontrollerImp>(
        builder: (_) {
          return ListView(
            children: [
              Container(
                margin: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Welcome(),
                    SizedBox(height: 20),
                    Slaider(),
                    SizedBox(height: 40),
                    Text(
                      "22".tr,
                      style: context.textTheme.headlineLarge,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 20),
                    Scrollcardservece(),
                    SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "23".tr,
                          style: context.textTheme.headlineLarge,
                          textAlign: TextAlign.start,
                        ),
                        InkWell(
                          onTap: () {
                            controller.gotoArticles();
                          },
                          child: Text(
                            "24".tr,
                            style: context.textTheme.headlineLarge?.copyWith(
                              color: AppColor.primarycolor,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 20, right: 20),
                height: 280,
                child: controller.datapost.isEmpty
                    ? const _EmptyAnimatedSlider()
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.datapost.length,
                        itemBuilder: (context, index) {
                          final item = controller.datapost[index];
                          return Custemcardhome(
                            image: File(item.image!),
                            content: item.localizedTitle,
                            onTap: () {
                              controller.gotoditailsarticles(item.id);
                            },
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _EmptyAnimatedSlider extends StatefulWidget {
  const _EmptyAnimatedSlider();

  @override
  State<_EmptyAnimatedSlider> createState() => _EmptyAnimatedSliderState();
}

class _EmptyAnimatedSliderState extends State<_EmptyAnimatedSlider> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (_, __) => const _SkeletonCard(),
    );
  }
}

class _SkeletonCard extends StatefulWidget {
  const _SkeletonCard();

  @override
  State<_SkeletonCard> createState() => _SkeletonCardState();
}

class _SkeletonCardState extends State<_SkeletonCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(left: 20),
      width: 255,
      decoration: BoxDecoration(
        color: const Color(0xffEFF5F4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: _ShimmerBox(
              controller: _controller,
              height: 159,
              width: 238,
            ),
          ),
          const SizedBox(height: 20),

          // العنوان (سطر 1)
          _ShimmerBox(
            controller: _controller,
            height: 14,
            width: 200,
            radius: 6,
          ),
          const SizedBox(height: 8),

          // العنوان (سطر 2)
          _ShimmerBox(
            controller: _controller,
            height: 14,
            width: 150,
            radius: 6,
          ),
        ],
      ),
    );
  }
}

class _ShimmerBox extends StatelessWidget {
  final AnimationController controller;
  final double height;
  final double width;
  final double radius;

  const _ShimmerBox({
    required this.controller,
    required this.height,
    required this.width,
    this.radius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) {
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            gradient: LinearGradient(
              begin: Alignment(-1.0 + controller.value * 2, 0),
              end: Alignment(1.0 + controller.value * 2, 0),
              colors: [
                Color(0xFFE5E7EB),
                Colors.white.withOpacity(0.35),
                Color(0xFFE5E7EB),
              ],
              stops: const [0.35, 0.5, 0.65],
            ),
          ),
        );
      },
    );
  }
}
