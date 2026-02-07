import 'package:chafi/LinkApi.dart';
import 'package:chafi/controller/Articles/Ditailsarticlescontroller.dart';
import 'package:chafi/core/class/handlingview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../core/constant/Colorapp.dart';

class Ditailsarticles extends StatefulWidget {
  const Ditailsarticles({super.key});

  @override
  State<Ditailsarticles> createState() => _DitailsarticlesState();
}

class _DitailsarticlesState extends State<Ditailsarticles> {
  @override
  Widget build(BuildContext context) {
    Get.put(Ditailsarticlescontroller());
    return Scaffold(
      backgroundColor: AppColor.white,
      body: GetBuilder<Ditailsarticlescontroller>(
        builder: (contriller) {
          if (contriller.datapost.isEmpty) {
            return Handlingview(
              statusrequest: contriller.statusrequest,
              widget: const SizedBox(),
            );
          }
          final item = contriller.datapost[0];
          return CustomScrollView(
            slivers: [
              // ===== HEADER IMAGE =====
              SliverAppBar(
                expandedHeight: 380,
                pinned: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Get.back(),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 25,
                  ),
                  title: Text(
                    item.localizedTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(
                              "${Applink.image}${item.image}",
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                        // child: Image.asset(Appimageassets.one, fit: BoxFit.cover),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.15),
                              Colors.black.withOpacity(0.65),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ===== CONTENT =====
              SliverToBoxAdapter(
                child: Container(
                  transform: Matrix4.translationValues(0, -20, 0),
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TITLE
                      const SizedBox(height: 30),
                      Text(
                        item.localizedTitle2,
                        style: context.textTheme.titleLarge?.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColor.black,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // ARTICLE BODY
                      Text(
                        item.localizedBody,
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontSize: 16.5,
                          height: 1.8,
                          color: AppColor.grey,
                        ),
                        textAlign: TextAlign.justify,
                      ),

                      const SizedBox(height: 40),
                    ],
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
