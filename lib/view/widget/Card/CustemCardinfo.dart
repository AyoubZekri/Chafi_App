import 'package:chafi/view/screen/pdf.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../LinkApi.dart';
import '../../../core/constant/Colorapp.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class Custemcardinfo extends StatefulWidget {
  final String body;
  final String title;
  final List<dynamic>? laws;
  final VoidCallback? onCalculator;
  final VoidCallback? onLink;
  final Function(dynamic)? onLawTap;
  final bool Calculator;
  final bool Link;
  final VoidCallback? onOpen;
  final bool? isRead;

  const Custemcardinfo({
    super.key,
    required this.body,
    required this.title,
    this.laws,
    this.onCalculator,
    this.onLink,
    this.onLawTap,
    required this.Calculator,
    required this.Link,
    this.onOpen,
    this.isRead,
  });

  @override
  State<Custemcardinfo> createState() => _CustemcardinfoState();
}

class _CustemcardinfoState extends State<Custemcardinfo>
    with SingleTickerProviderStateMixin {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    String lang = Get.locale?.languageCode ?? 'ar';
    return GestureDetector(
      onTap: () {
        setState(() {
          isOpen = !isOpen;

          if (isOpen && widget.onOpen != null) {
            widget.onOpen!();
          }
        });
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ===== TITLE =====
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.title,
                        style: context.textTheme.headlineMedium?.copyWith(
                          color: AppColor.black,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    AnimatedRotation(
                      turns: isOpen ? 0.5 : 0,
                      duration: const Duration(milliseconds: 300),
                      child: const Icon(Icons.keyboard_arrow_down),
                    ),
                  ],
                ),

                /// ===== BODY + ACTIONS =====
                AnimatedSize(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  child: isOpen
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12),
                            buildRichText(widget.body, context),

                            if (widget.Calculator ||
                                widget.Link ||
                                (widget.laws != null &&
                                    widget.laws!.isNotEmpty)) ...[
                              const SizedBox(height: 15),
                              Divider(
                                color: Colors.grey.shade300,
                                thickness: 1,
                              ),
                              const SizedBox(height: 10),
                              Column(
                                children: [
                                  if (widget.Calculator)
                                    OutlinedButton.icon(
                                      onPressed: widget.onCalculator,
                                      icon: const Icon(Icons.calculate),
                                      label: Text(
                                        "حاسبة",
                                        style: context.textTheme.bodyMedium
                                            ?.copyWith(
                                              color: AppColor.typography,
                                              fontSize: 17,
                                            ),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: AppColor.typography,
                                        minimumSize: const Size(
                                          double.infinity,
                                          48,
                                        ),
                                        side: const BorderSide(
                                          color: AppColor.typography,
                                          width: 1.5,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (widget.Calculator &&
                                      (widget.Link ||
                                          (widget.laws != null &&
                                              widget.laws!.isNotEmpty)))
                                    const SizedBox(height: 10),

                                  if (widget.laws != null &&
                                      widget.laws!.isNotEmpty)
                                    PopupMenuButton<dynamic>(
                                      constraints: BoxConstraints(
                                        minWidth:
                                            context.width *
                                            0.82, // 70% of screen width for example
                                        maxWidth: context.width * 0.82,
                                      ),
                                      offset: const Offset(0, 50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      onSelected: (selectedLaw) {},
                                      itemBuilder: (context) {
                                        return widget.laws!.map((law) {
                                          String lawName = lang == 'ar'
                                              ? (law['name_ar'] ?? '')
                                              : (law['name_fr'] ?? '');
                                          return PopupMenuItem<dynamic>(
                                            value: law,
                                            onTap: () {
                                              Get.to(
                                                () => PdfSearchPage(
                                                  url:
                                                      "${Applink.image}${law['pdf']}",
                                                  initialPage:
                                                      int.tryParse(
                                                        law['index_link']
                                                            .toString(),
                                                      ) ??
                                                      1,
                                                ),
                                              );
                                            },
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(
                                                  Icons.description_outlined,
                                                  size: 18,
                                                  color: AppColor.typography,
                                                ),
                                                const SizedBox(width: 10),
                                                Flexible(
                                                  child: Text(
                                                    lawName,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: context
                                                        .textTheme
                                                        .bodyMedium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList();
                                      },

                                      child: Container(
                                        height: 48,
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          border: Border.all(
                                            color: AppColor.typography,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.gavel,
                                              size: 18,
                                              color: AppColor.typography,
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              lang == 'ar'
                                                  ? "القوانين"
                                                  : "Lois",
                                              style: context
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                    color: AppColor.typography,
                                                    fontSize: 17,
                                                  ),
                                            ),
                                            const Icon(
                                              Icons.arrow_drop_down,
                                              color: AppColor.typography,
                                              size: 24,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  else if (widget.Link)
                                    OutlinedButton.icon(
                                      onPressed: widget.onLink,
                                      icon: const Icon(Icons.link),
                                      label: const Text("رابط"),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: AppColor.typography,
                                        minimumSize: const Size(
                                          double.infinity,
                                          48,
                                        ),
                                        side: const BorderSide(
                                          color: AppColor.typography,
                                          width: 1.5,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ],
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          ),

          /// ===== مؤشر القراءة =====
          if (widget.isRead == true)
            Positioned(
              top: 20,
              right: 20,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: AppColor.acteve,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColor.white, width: 2),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildRichText(String text, BuildContext context) {
    final urlRegex = RegExp(r'(https?:\/\/[^\s]+)');
    final keywordRegex = RegExp(
      r'(المادة\s*\d+([\-–]\d+)?(\s*مكرر(\s*\d+)?)?)',
    );
    List<TextSpan> spans = [];
    int currentIndex = 0;

    final matches = RegExp(
      '${urlRegex.pattern}|${keywordRegex.pattern}',
    ).allMatches(text);

    for (final match in matches) {
      if (match.start > currentIndex) {
        spans.add(
          TextSpan(
            text: text.substring(currentIndex, match.start),
            style: context.textTheme.bodyLarge?.copyWith(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        );
      }

      final matchedText = match.group(0)!;

      if (urlRegex.hasMatch(matchedText)) {
        spans.add(
          TextSpan(
            text: matchedText,
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                final uri = Uri.parse(matchedText);
                if (!await launchUrl(
                  uri,
                  mode: LaunchMode.externalApplication,
                )) {
                  throw 'Could not launch $matchedText';
                }
              },
          ),
        );
      }
      // ✅ إذا كلمة مميزة
      else if (keywordRegex.hasMatch(matchedText)) {
        spans.add(
          TextSpan(
            text: matchedText,
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
          ),
        );
      }

      currentIndex = match.end;
    }

    // باقي النص
    if (currentIndex < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(currentIndex),
          style: context.textTheme.bodyLarge?.copyWith(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      );
    }

    return RichText(text: TextSpan(children: spans));
  }
}
