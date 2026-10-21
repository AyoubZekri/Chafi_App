import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/Colorapp.dart';
import '../../../core/services/Services.dart';
import '../../../data/datasource/statec/statec.dart';
import '../../screen/Chat/ChatScreen.dart';

/// أيقونة المساعد الذكي: تُسحب لأي مكان في الشاشة وتبقى فيه
/// (الموضع يُحفظ كنسبة من حجم الشاشة حتى يبقى صحيحاً على كل الأجهزة)
class DraggableChatBot extends StatefulWidget {
  const DraggableChatBot({super.key});

  @override
  State<DraggableChatBot> createState() => _DraggableChatBotState();
}

class _DraggableChatBotState extends State<DraggableChatBot> {
  static const double _size = 58;
  static const double _margin = 12;
  static const _keyX = 'chatbot_pos_x';
  static const _keyY = 'chatbot_pos_y';

  final _prefs = Get.find<Myservices>().sharedPreferences;

  // النسبة من المساحة المتاحة (0 = يسار/أعلى، 1 = يمين/أسفل)
  late double _fx = _prefs?.getDouble(_keyX) ?? 0.95;
  late double _fy = _prefs?.getDouble(_keyY) ?? 0.95;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxX = constraints.maxWidth - _size - _margin * 2;
        final maxY = constraints.maxHeight - _size - _margin * 2;
        return Stack(
          children: [
            Positioned(
              left: _margin + maxX * _fx,
              top: _margin + maxY * _fy,
              child: GestureDetector(
                onPanUpdate: (d) => setState(() {
                  if (maxX > 0) _fx = (_fx + d.delta.dx / maxX).clamp(0.0, 1.0);
                  if (maxY > 0) _fy = (_fy + d.delta.dy / maxY).clamp(0.0, 1.0);
                }),
                onPanEnd: (_) {
                  _prefs?.setDouble(_keyX, _fx);
                  _prefs?.setDouble(_keyY, _fy);
                },
                child: _button(),
              ),
            ),
          ],
        );
      },
    );
  }

  // المساعد الذكي: أيقونة في دائرة متدرجة (يتطلب تسجيل الدخول لحفظ المحادثات)
  Widget _button() {
    return Tooltip(
      message: "ChafiBot",
      child: Container(
        width: _size,
        height: _size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
            colors: [AppColor.typography, AppColor.primarycolor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: () =>
                handleLoginRequired(() => Get.to(() => const ChatScreen())),
            child: const Icon(
              Icons.support_agent_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
