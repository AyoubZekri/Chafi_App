import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../controller/Chat/ChatController.dart';
import '../../../core/class/Statusrequest.dart';
import '../../../core/class/handlingview.dart';
import '../../../core/constant/Colorapp.dart';
import '../../../data/model/ChatModel.dart';
import '../../widget/TaxFiles/LinkedArticlesSheet.dart';

/// ألوان صفحة المساعد (مبنية على ألوان التطبيق)
class _C {
  static const background = Color(0xFFF3F6FB);
  static const bubble = Colors.white;
  static const soft = Color(0xFFE8F1FA); // خلفيات خفيفة (الحساب، المصادر)
  static const text = Color(0xFF1F2937);
  static const muted = Color(0xFF8A94A6);

  static const gradient = LinearGradient(
    begin: AlignmentDirectional.topStart,
    end: AlignmentDirectional.bottomEnd,
    colors: [AppColor.typography, AppColor.primarycolor],
  );

  static List<BoxShadow> shadow([double opacity = 0.06]) => [
    BoxShadow(
      color: AppColor.typography.withValues(alpha: opacity),
      blurRadius: 14,
      offset: const Offset(0, 4),
    ),
  ];
}

String _time(DateTime t) =>
    '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

/// المساعد الذكي: يجيب من قاعدة بيانات التطبيق، والمحادثات محفوظة
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ChatController());

    return GetBuilder<ChatController>(
      builder: (controller) => Scaffold(
        backgroundColor: _C.background,
        appBar: _Header(controller: controller),
        endDrawer: _ConversationsDrawer(controller: controller),
        // حقل الكتابة عائم فوق المحادثة، والرسائل تمر خلفه
        body: Stack(
          children: [
            Positioned.fill(child: _messages(context, controller)),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _InputBar(controller: controller),
            ),
          ],
        ),
      ),
    );
  }

  Widget _messages(BuildContext context, ChatController controller) {
    if (controller.loadingMessages) {
      // نفس مؤشر الانتظار في صفحات التطبيق
      return const Handlingview(
        statusrequest: Statusrequest.loadeng,
        widget: SizedBox.shrink(),
      );
    }
    if (controller.messagesStatus == Statusrequest.failure ||
        controller.messagesStatus == Statusrequest.serverfailure) {
      // فشل تحميل المحادثة: نفس عرض صفحات التطبيق، والسحب للأسفل لإعادة المحاولة
      return RefreshIndicator(
        color: AppColor.typography,
        onRefresh: controller.reloadConversation,
        child: Handlingview(
          statusrequest: controller.messagesStatus,
          widget: const SizedBox.shrink(),
        ),
      );
    }
    if (controller.messages.isEmpty && !controller.sending) {
      return const _EmptyChat();
    }
    final count = controller.messages.length + (controller.sending ? 1 : 0);
    return ListView.builder(
      controller: controller.scroll,
      // مسافة سفلية حتى لا يغطي الحقل العائم آخر رسالة
      padding: EdgeInsets.fromLTRB(
        14,
        18,
        14,
        110 + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: count,
      itemBuilder: (context, i) {
        if (i == controller.messages.length) return const _TypingBubble();
        final message = controller.messages[i];
        return _Appear(
          key: ValueKey(controller.messages[i]),
          child: _Bubble(
            message: controller.messages[i],
            // اختيار موضوع مقترح = إرساله كسؤال جديد
            onOption: controller.sending ? null : controller.send,
            onEdit:
                controller.messages[i].isUser &&
                    controller.messages[i].id != null &&
                    !controller.sending
                ? () => controller.startEdit(controller.messages[i])
                : null,
            // رسالة الفشل تظهر كجواب عادي من ChafiBot، مع إعادة المحاولة
            onRetry: message.retryText != null && !controller.sending
                ? () => controller.retry(message)
                : null,
          ),
        );
      },
    );
  }
}

// ---------------- الشريط العلوي

class _Header extends StatelessWidget implements PreferredSizeWidget {
  final ChatController controller;

  const _Header({required this.controller});

  // أطول من الشريط العادي حتى ينزل الزران قليلاً عن أعلى الشاشة
  static const double _height = 76;

  @override
  Size get preferredSize => const Size.fromHeight(_height);

  /// بدون شريط (لا ظل ولا خلفية): زر الرجوع، اسم ChafiBot في الوسط،
  /// وزر القائمة لفتح المحادثات السابقة
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: _height,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      title: const _BotName(),
      actions: [
        // المحادثات السابقة (الشريط الجانبي)
        Builder(
          builder: (context) => Padding(
            padding: const EdgeInsetsDirectional.only(end: 14),
            child: _MenuButton(
              onTap: () => Scaffold.of(context).openEndDrawer(),
            ),
          ),
        ),
      ],
    );
  }
}

/// اسم المساعد في الشريط: ✨ + "Chafi" داكن و"Bot" بتدرج ألوان التطبيق
class _BotName extends StatelessWidget {
  const _BotName();

  @override
  Widget build(BuildContext context) {
    final direction = Directionality.of(context);
    Widget gradient(Widget child) => ShaderMask(
      shaderCallback: (rect) =>
          _C.gradient.createShader(rect, textDirection: direction),
      child: child,
    );
    return Directionality(
      // الاسم لاتيني: يُكتب من اليسار إلى اليمين حتى في الواجهة العربية
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          gradient(
            const Icon(
              Icons.auto_awesome_rounded,
              size: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 6),
          const Text(
            "Chafi",
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
              color: AppColor.typography,
            ),
          ),
          gradient(
            const Text(
              "Bot",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.3,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// زر القائمة: مربع متدرج بزوايا مدورة، فيه خطان: الأول قصير والثاني كامل
class _MenuButton extends StatelessWidget {
  final VoidCallback onTap;

  const _MenuButton({required this.onTap});

  Widget _line(double width) => Container(
    width: width,
    height: 2.6,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(2),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        gradient: _C.gradient,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Center(
            child: SizedBox(
              width: 20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_line(11), const SizedBox(height: 5), _line(20)],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// صورة المساعد: دائرة متدرجة فيها أيقونة
class _Avatar extends StatelessWidget {
  final double size;

  const _Avatar({this.size = 32});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: _C.gradient,
      ),
      child: Icon(
        Icons.support_agent_rounded,
        color: Colors.white,
        size: size * 0.58,
      ),
    );
  }
}

/// ظهور ناعم للرسالة (انزلاق خفيف + شفافية)
class _Appear extends StatelessWidget {
  final Widget child;

  const _Appear({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
      builder: (context, v, child) => Opacity(
        opacity: v,
        child: Transform.translate(
          offset: Offset(0, (1 - v) * 12),
          child: child,
        ),
      ),
      child: child,
    );
  }
}

// ---------------- فقاعة رسالة

class _Bubble extends StatelessWidget {
  final ChatMessageModel message;
  final void Function(String)? onOption;

  /// تعديل سؤال المستخدم (null = غير متاح: رسالة لم تُحفظ بعد أو المساعد يكتب)
  final VoidCallback? onEdit;

  /// إعادة إرسال السؤال (لرسالة الفشل فقط)
  final VoidCallback? onRetry;

  const _Bubble({
    required this.message,
    this.onOption,
    this.onEdit,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    final maxWidth = MediaQuery.of(context).size.width * (isUser ? 0.78 : 0.80);

    final bubble = Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 8),
      decoration: BoxDecoration(
        gradient: isUser ? _C.gradient : null,
        color: isUser ? null : _C.bubble,
        borderRadius: BorderRadiusDirectional.only(
          topStart: const Radius.circular(18),
          topEnd: const Radius.circular(18),
          bottomStart: Radius.circular(isUser ? 18 : 4),
          bottomEnd: Radius.circular(isUser ? 4 : 18),
        ),
        boxShadow: _C.shadow(isUser ? 0.18 : 0.07),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            message.content,
            style: TextStyle(
              color: isUser ? Colors.white : _C.text,
              fontSize: 15,
              height: 1.65,
            ),
          ),
          if (message.calculations.isNotEmpty) ...[
            const SizedBox(height: 10),
            _Calculations(items: message.calculations),
          ],
          if (message.sources.isNotEmpty) ...[
            const SizedBox(height: 10),
            _Sources(sources: message.sources),
          ],
          if (message.options.isNotEmpty) ...[
            const SizedBox(height: 12),
            _Options(options: message.options, onTap: onOption),
          ],
          const SizedBox(height: 4),
          // الوقت + نسخ (للجميع) + تعديل (لأسئلة المستخدم، مثل ChatGPT)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _time(message.createdAt),
                style: TextStyle(
                  fontSize: 11,
                  color: isUser
                      ? Colors.white.withValues(alpha: 0.75)
                      : _C.muted,
                ),
              ),
              const SizedBox(width: 10),
              _CopyButton(text: message.content, onDark: isUser),
              if (isUser && onEdit != null) ...[
                const SizedBox(width: 10),
                _SmallAction(
                  icon: Icons.edit_outlined,
                  label: "تعديل".tr,
                  color: Colors.white.withValues(alpha: 0.85),
                  onTap: onEdit!,
                ),
              ],
              if (onRetry != null) ...[
                const SizedBox(width: 10),
                _SmallAction(
                  icon: Icons.refresh_rounded,
                  label: "إعادة المحاولة".tr,
                  color: _C.muted,
                  onTap: onRetry!,
                ),
              ],
            ],
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[const _Avatar(size: 30), const SizedBox(width: 8)],
          Flexible(child: bubble),
        ],
      ),
    );
  }
}

/// زر صغير تحت الرسالة (أيقونة + نص)
class _SmallAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _SmallAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // أيقونة فقط؛ الاسم يظهر عند الضغط المطوّل
    return Tooltip(
      message: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(icon, size: 16, color: color),
        ),
      ),
    );
  }
}

/// زر النسخ: بعد الضغط تظهر علامة ✓ لمدة ثانية ثم تعود أيقونة النسخ (بدون رسالة)
class _CopyButton extends StatefulWidget {
  final String text;

  /// على خلفية داكنة (فقاعة المستخدم): أيقونة فاتحة
  final bool onDark;

  const _CopyButton({required this.text, this.onDark = false});

  @override
  State<_CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<_CopyButton> {
  bool _copied = false;
  Timer? _timer;

  void _copy() {
    Clipboard.setData(ClipboardData(text: widget.text));
    _timer?.cancel();
    setState(() => _copied = true);
    _timer = Timer(const Duration(seconds: 1), () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final idle = widget.onDark
        ? Colors.white.withValues(alpha: 0.85)
        : _C.muted;
    final copiedColor = widget.onDark ? Colors.white : const Color(0xFF16A34A);
    final color = _copied ? copiedColor : idle;
    // أيقونة فقط؛ الاسم يظهر عند الضغط المطوّل
    return Tooltip(
      message: "نسخ".tr,
      child: InkWell(
        onTap: _copy,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, animation) =>
                ScaleTransition(scale: animation, child: child),
            child: Icon(
              _copied ? Icons.check_rounded : Icons.copy_rounded,
              key: ValueKey(_copied),
              size: 16,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}

/// مواضيع مقترحة عندما لا يفهم المساعد السؤال: الضغط على أحدها يرسله كسؤال
class _Options extends StatelessWidget {
  final List<String> options;
  final void Function(String)? onTap;

  const _Options({required this.options, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final option in options)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Material(
              color: _C.soft,
              borderRadius: BorderRadius.circular(14),
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: onTap == null ? null : () => onTap!(option),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 11,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.help_outline_rounded,
                        size: 18,
                        color: AppColor.typography,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          option,
                          style: const TextStyle(
                            color: AppColor.typography,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 1.4,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 13,
                        color: AppColor.typography,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// العمليات الحسابية التي أجرتها أداة الحساب
class _Calculations extends StatelessWidget {
  final List<String> items;

  const _Calculations({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _C.soft,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColor.primarycolor.withValues(alpha: 0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.calculate_rounded,
                size: 18,
                color: AppColor.typography,
              ),
              const SizedBox(width: 6),
              Text(
                "الحساب".tr,
                style: const TextStyle(
                  color: AppColor.typography,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          for (final c in items)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Directionality(
                // العملية الحسابية تُقرأ من اليسار إلى اليمين
                textDirection: TextDirection.ltr,
                child: Text(
                  c,
                  style: const TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    color: AppColor.typography,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// مصادر الجواب: كل مصدر يُفتح بالضغط عليه
class _Sources extends StatelessWidget {
  final List<ChatSourceModel> sources;

  const _Sources({required this.sources});

  /// اسم القسم وأيقونته حسب نوع المصدر
  static const Map<String, (String, IconData)> _types = {
    'article': ("مادة", Icons.description_outlined),
    'tax_system': ("نظام جبائي", Icons.account_balance_outlined),
    'penalty': ("جزاءات", Icons.gavel_outlined),
    'institution': ("مؤسسة", Icons.business_outlined),
    'different': ("سؤال / موضوع", Icons.help_outline),
    'appointment': ("موعد والتزام", Icons.event_outlined),
    'activity': ("نشاط", Icons.work_outline),
    'post': ("مقال", Icons.article_outlined),
  };

  String _label(ChatSourceModel s) {
    if (s.isArticle) {
      return s.number != null && s.number!.isNotEmpty
          ? "${"المادة".tr} ${s.number}"
          : s.title;
    }
    final type = _types[s.type]?.$1;
    final title = s.title.length > 40
        ? '${s.title.substring(0, 40)}…'
        : s.title;
    return type == null ? title : "${type.tr}: $title";
  }

  /// نص المصدر في نافذة سفلية (للمصادر غير المواد)
  void _showContent(BuildContext context, ChatSourceModel s) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.55,
        maxChildSize: 0.9,
        builder: (context, scroll) => ListView(
          controller: scroll,
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: _C.muted.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  _types[s.type]?.$2 ?? Icons.info_outline,
                  color: AppColor.typography,
                ),
                const SizedBox(width: 8),
                Text(
                  (_types[s.type]?.$1 ?? "المصدر").tr,
                  style: const TextStyle(color: _C.muted, fontSize: 13),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              s.title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: AppColor.typography,
              ),
            ),
            const SizedBox(height: 12),
            SelectableText(
              (s.content == null || s.content!.isEmpty)
                  ? "لا يوجد نص لهذا المصدر".tr
                  : s.content!,
              style: const TextStyle(fontSize: 15, height: 1.7),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(BuildContext context, ChatSourceModel s) {
    return Material(
      color: _C.soft,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => s.isArticle
            ? showLinkedArticles(context, [s.id])
            : _showContent(context, s),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                _types[s.type]?.$2 ?? Icons.info_outline,
                size: 15,
                color: AppColor.typography,
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  _label(s),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColor.typography,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final articles = sources.where((s) => s.isArticle).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(height: 14, color: _C.muted.withValues(alpha: 0.2)),
        Row(
          children: [
            const Icon(Icons.link_rounded, size: 15, color: _C.muted),
            const SizedBox(width: 4),
            Text(
              "المصادر".tr,
              style: const TextStyle(
                color: _C.muted,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [for (final s in sources) _chip(context, s)],
        ),
        // زر واحد لعرض كل المواد المستعملة في الجواب
        if (articles.length > 1)
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: TextButton.icon(
              onPressed: () =>
                  showLinkedArticles(context, [for (final s in articles) s.id]),
              icon: const Icon(Icons.menu_book_outlined, size: 18),
              label: Text("عرض كل المواد".tr),
              style: TextButton.styleFrom(foregroundColor: AppColor.typography),
            ),
          ),
      ],
    );
  }
}

// ---------------- بداية محادثة جديدة

/// محادثة فارغة: الشعار في الوسط و"كيف يمكنني مساعدتك؟"
class _EmptyChat extends StatelessWidget {
  const _EmptyChat();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 110),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // الشعار مع هالة
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColor.primarycolor.withValues(alpha: 0.07),
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColor.primarycolor.withValues(alpha: 0.12),
                ),
                child: const _Avatar(size: 96),
              ),
            ),
            const SizedBox(height: 22),
            Text(
              "كيف يمكنني مساعدتك؟".tr,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColor.typography,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- المساعد يكتب (نقاط متحركة)

class _TypingBubble extends StatefulWidget {
  const _TypingBubble();

  @override
  State<_TypingBubble> createState() => _TypingBubbleState();
}

class _TypingBubbleState extends State<_TypingBubble>
    with SingleTickerProviderStateMixin {
  late final AnimationController _anim = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..repeat();

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const _Avatar(size: 30),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: _C.bubble,
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(18),
                topEnd: Radius.circular(18),
                bottomEnd: Radius.circular(18),
                bottomStart: Radius.circular(4),
              ),
              boxShadow: _C.shadow(0.07),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedBuilder(
                  animation: _anim,
                  builder: (context, _) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [for (int i = 0; i < 3; i++) _dot(i)],
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  "جاري البحث عن جواب...".tr,
                  style: const TextStyle(color: _C.muted, fontSize: 12.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// كل نقطة تقفز بعد التي قبلها
  Widget _dot(int i) {
    final t = (_anim.value - i * 0.18) % 1.0;
    final lift = t < 0.4 ? (t < 0.2 ? t / 0.2 : (0.4 - t) / 0.2) : 0.0;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      transform: Matrix4.translationValues(0, -5 * lift, 0),
      width: 7,
      height: 7,
      decoration: BoxDecoration(
        color: Color.lerp(_C.muted, AppColor.primarycolor, lift),
        shape: BoxShape.circle,
      ),
    );
  }
}

// ---------------- خانة الكتابة

class _InputBar extends StatelessWidget {
  final ChatController controller;

  const _InputBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      // تلاشٍ ناعم خلف الحقل حتى تختفي الرسائل تحته بدل أن تُقطع
      padding: EdgeInsets.fromLTRB(
        14,
        18,
        14,
        14 + MediaQuery.of(context).padding.bottom,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            _C.background.withValues(alpha: 0),
            _C.background.withValues(alpha: 0.95),
            _C.background,
          ],
          stops: const [0, 0.45, 1],
        ),
      ),
      // الحقل: كبسولة بيضاء عائمة بظل، وزر الإرسال داخلها
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // تعديل سؤال سابق: شريط فوق الحقل مع زر الإلغاء
          if (controller.notice != null)
            _NoticeBanner(text: controller.notice!),
          if (controller.editing != null)
            _EditingBanner(onCancel: controller.cancelEdit),
          Container(
            padding: const EdgeInsetsDirectional.fromSTEB(6, 6, 6, 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: AppColor.primarycolor.withValues(alpha: 0.10),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColor.typography.withValues(alpha: 0.16),
                  blurRadius: 28,
                  offset: const Offset(0, 10),
                ),
                BoxShadow(
                  color: AppColor.typography.withValues(alpha: 0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 10,
                    bottom: 12,
                  ),
                  child: Icon(
                    Icons.auto_awesome_rounded,
                    size: 20,
                    color: AppColor.primarycolor.withValues(alpha: 0.7),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: controller.input,
                    minLines: 1,
                    maxLines: 5,
                    maxLength: 2000,
                    enabled: !controller.sending,
                    textInputAction: TextInputAction.newline,
                    style: const TextStyle(fontSize: 15, color: _C.text),
                    decoration: InputDecoration(
                      hintText: "${"اسأل".tr} ChafiBot",
                      hintStyle: TextStyle(
                        color: _C.muted.withValues(alpha: 0.8),
                      ),
                      counterText: '',
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 13,
                      ),
                    ),
                  ),
                ),
                // زر الإرسال: متدرج عندما يوجد نص، رمادي عندما يكون فارغاً أو أثناء الإرسال
                ValueListenableBuilder<TextEditingValue>(
                  valueListenable: controller.input,
                  builder: (context, value, _) {
                    final active =
                        value.text.trim().isNotEmpty && !controller.sending;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOut,
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: active || controller.sending
                            ? _C.gradient
                            : null,
                        color: active || controller.sending ? null : _C.soft,
                        boxShadow: active ? _C.shadow(0.3) : null,
                      ),
                      child: Material(
                        color: Colors.transparent,
                        shape: const CircleBorder(),
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: active ? () => controller.send() : null,
                          child: controller.sending
                              ? const Padding(
                                  padding: EdgeInsets.all(13),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.2,
                                    color: Colors.white,
                                  ),
                                )
                              // الأيقونة تنعكس تلقائياً حسب اتجاه اللغة
                              : AnimatedScale(
                                  scale: active ? 1 : 0.85,
                                  duration: const Duration(milliseconds: 220),
                                  child: Icon(
                                    Icons.send_rounded,
                                    size: 21,
                                    color: active
                                        ? Colors.white
                                        : AppColor.typography.withValues(
                                            alpha: 0.35,
                                          ),
                                  ),
                                ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// شريط "تعديل السؤال" فوق حقل الكتابة
class _EditingBanner extends StatelessWidget {
  final VoidCallback onCancel;

  const _EditingBanner({required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsetsDirectional.fromSTEB(14, 4, 4, 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColor.primarycolor.withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.edit_rounded,
            size: 18,
            color: AppColor.primarycolor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "تعديل السؤال".tr,
              style: const TextStyle(
                color: AppColor.typography,
                fontWeight: FontWeight.bold,
                fontSize: 13.5,
              ),
            ),
          ),
          IconButton(
            tooltip: "إلغاء".tr,
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.close_rounded, size: 20, color: _C.muted),
            onPressed: onCancel,
          ),
        ],
      ),
    );
  }
}

// ---------------- المحادثات السابقة

class _ConversationsDrawer extends StatefulWidget {
  final ChatController controller;

  const _ConversationsDrawer({required this.controller});

  @override
  State<_ConversationsDrawer> createState() => _ConversationsDrawerState();
}

class _ConversationsDrawerState extends State<_ConversationsDrawer> {
  String _query = '';

  ChatController get controller => widget.controller;

  /// مجموعة المحادثة حسب تاريخها
  String _group(DateTime? t) {
    if (t == null) return "أقدم".tr;
    final local = t.toLocal();
    final now = DateTime.now();
    final days = DateTime(
      now.year,
      now.month,
      now.day,
    ).difference(DateTime(local.year, local.month, local.day)).inDays;
    if (days <= 0) return "اليوم".tr;
    if (days == 1) return "أمس".tr;
    if (days < 7) return "هذا الأسبوع".tr;
    return "أقدم".tr;
  }

  /// "14:05" لليوم، وإلا "12/10/2026"
  String _date(DateTime t) {
    final local = t.toLocal();
    final now = DateTime.now();
    final today =
        local.year == now.year &&
        local.month == now.month &&
        local.day == now.day;
    return today ? _time(local) : '${local.day}/${local.month}/${local.year}';
  }

  Future<void> _rename(ChatConversationModel c) async {
    final title = await showDialog<String>(
      context: context,
      builder: (_) => _RenameDialog(initial: c.title),
    );
    if (title == null) return;
    final error = await controller.rename(c, title);
    if (error != null && mounted) _showError(error);
  }

  void _showError(String message) {
    showDialog<void>(
      context: context,
      builder: (_) => _ErrorDialog(message: message),
    );
  }

  Future<void> _delete(ChatConversationModel c) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => const _DeleteDialog(),
    );
    if (ok != true) return;
    final error = await controller.delete(c);
    if (error != null && mounted) _showError(error);
  }

  @override
  Widget build(BuildContext context) {
    final count = controller.conversations.length;
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.84,
      backgroundColor: _C.background,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.horizontal(
          start: Radius.circular(28),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // ---- الرأس: تدرج + أشكال زخرفية
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(gradient: _C.gradient),
            child: Stack(
              children: [
                PositionedDirectional(
                  top: -40,
                  end: -30,
                  child: _circle(140, 0.08),
                ),
                PositionedDirectional(
                  bottom: -50,
                  start: -20,
                  child: _circle(110, 0.06),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    18,
                    MediaQuery.of(context).padding.top + 18,
                    18,
                    18,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withValues(alpha: 0.2),
                            ),
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: const Icon(
                                Icons.support_agent_rounded,
                                color: AppColor.typography,
                                size: 26,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "محادثاتي".tr,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "$count ${"محادثة".tr}",
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    fontSize: 12.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // محادثة جديدة
                      Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            Navigator.pop(context);
                            controller.newConversation();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: const BoxDecoration(
                                    gradient: _C.gradient,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.add_rounded,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "محادثة جديدة".tr,
                                  style: const TextStyle(
                                    color: AppColor.typography,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ---- البحث في المحادثات
          if (count > 0)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 4),
              child: TextField(
                onChanged: (v) => setState(() => _query = v.trim()),
                style: const TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: "ابحث في المحادثات".tr,
                  hintStyle: const TextStyle(color: _C.muted, fontSize: 14),
                  prefixIcon: const Icon(Icons.search_rounded, color: _C.muted),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

          Expanded(child: _list()),
        ],
      ),
    );
  }

  Widget _circle(double size, double opacity) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white.withValues(alpha: opacity),
    ),
  );

  /// مثل صفحات التطبيق: Handlingview (انتظار، خطأ، بدون إنترنت، لا توجد بيانات)
  /// والسحب للأسفل لتحديث القائمة
  Widget _list() {
    return RefreshIndicator(
      color: AppColor.typography,
      onRefresh: controller.loadConversations,
      child: Handlingview(
        statusrequest: controller.conversationsStatus,
        title: "لا توجد محادثات بعد".tr,
        widget: _items(),
      ),
    );
  }

  Widget _items() {
    final items = controller.conversations
        .where((c) => _query.isEmpty || c.title.contains(_query))
        .toList();
    if (items.isEmpty) {
      // بحث بلا نتائج: نفس عرض Handlingview في صفحات التطبيق
      return Handlingview(
        statusrequest: Statusrequest.nodata,
        title: "لا توجد نتائج".tr,
        iconData: Icons.search_off_rounded,
        widget: const SizedBox.shrink(),
      );
    }

    // عناوين المجموعات (اليوم، أمس...) بين المحادثات
    final rows = <Widget>[];
    String? last;
    for (final c in items) {
      final group = _group(c.updatedAt);
      if (group != last) {
        rows.add(
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(6, 14, 6, 8),
            child: Text(
              group,
              style: const TextStyle(
                color: _C.muted,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3,
              ),
            ),
          ),
        );
        last = group;
      }
      rows.add(_tile(c));
    }
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 20),
      children: rows,
    );
  }

  Widget _tile(ChatConversationModel c) {
    final selected = controller.current?.id == c.id;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          gradient: selected ? _C.gradient : null,
          color: selected ? null : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: _C.shadow(selected ? 0.25 : 0.05),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              Navigator.pop(context);
              controller.openConversation(c);
            },
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(12, 11, 2, 11),
              child: Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: selected
                          ? Colors.white.withValues(alpha: 0.2)
                          : _C.soft,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.chat_rounded,
                      size: 18,
                      color: selected ? Colors.white : AppColor.typography,
                    ),
                  ),
                  const SizedBox(width: 11),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          c.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: selected ? Colors.white : _C.text,
                            fontSize: 14,
                            height: 1.35,
                            fontWeight: selected
                                ? FontWeight.bold
                                : FontWeight.w500,
                          ),
                        ),
                        if (c.updatedAt != null) ...[
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              Icon(
                                Icons.schedule_rounded,
                                size: 12,
                                color: selected
                                    ? Colors.white.withValues(alpha: 0.75)
                                    : _C.muted,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                _date(c.updatedAt!),
                                style: TextStyle(
                                  fontSize: 11,
                                  color: selected
                                      ? Colors.white.withValues(alpha: 0.75)
                                      : _C.muted,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: Icon(
                      Icons.more_vert_rounded,
                      size: 20,
                      color: selected ? Colors.white : _C.muted,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    onSelected: (value) =>
                        value == 'rename' ? _rename(c) : _delete(c),
                    itemBuilder: (_) => [
                      PopupMenuItem(
                        value: 'rename',
                        child: Row(
                          children: [
                            const Icon(
                              Icons.edit_rounded,
                              size: 18,
                              color: AppColor.typography,
                            ),
                            const SizedBox(width: 10),
                            Text("إعادة تسمية".tr),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            const Icon(
                              Icons.delete_outline_rounded,
                              size: 18,
                              color: Colors.red,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "حذف".tr,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------- نوافذ إعادة التسمية والحذف (بنفس تصميم نوافذ السجلات)

const _dialogRed = Color(0xFFEF4444);
const _dialogGreyButton = Color(0xFFF1F5F9);
const _dialogMessage = Color(0xFF475569);

/// إطار نوافذ السجلات: بطاقة بيضاء، أيقونة في دائرة ملونة، عنوان، محتوى، وزران
Widget _recordsDialogFrame({
  required IconData icon,
  required Color iconColor,
  required Color iconBackground,
  required Color iconBorder,
  required String title,
  required Widget content,
  required Widget confirm,
  Widget? cancel,
}) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    elevation: 0,
    backgroundColor: Colors.transparent,
    child: Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: iconBackground,
              shape: BoxShape.circle,
              border: Border.all(color: iconBorder, width: 1.5),
            ),
            child: Icon(icon, color: iconColor, size: 36),
          ),
          const SizedBox(height: 18),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: AppColor.typography,
            ),
          ),
          const SizedBox(height: 12),
          content,
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(child: confirm),
              if (cancel != null) ...[
                const SizedBox(width: 12),
                Expanded(child: cancel),
              ],
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _dialogFilledButton(String label, Color color, VoidCallback onPressed) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      foregroundColor: AppColor.white,
      padding: const EdgeInsets.symmetric(vertical: 14),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
    onPressed: onPressed,
    child: Text(
      label,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    ),
  );
}

Widget _dialogCancelButton(VoidCallback onPressed) {
  return TextButton(
    style: TextButton.styleFrom(
      backgroundColor: _dialogGreyButton,
      foregroundColor: AppColor.typography,
      padding: const EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
    onPressed: onPressed,
    child: Text(
      "إلغاء".tr,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    ),
  );
}

/// تأكيد حذف المحادثة
class _DeleteDialog extends StatelessWidget {
  const _DeleteDialog();

  @override
  Widget build(BuildContext context) {
    return _recordsDialogFrame(
      icon: Icons.delete_outline_rounded,
      iconColor: _dialogRed,
      iconBackground: const Color(0xFFFEF2F2),
      iconBorder: const Color(0xFFFEE2E2),
      title: "تأكيد الحذف".tr,
      content: Text(
        "هل أنت متأكد من أنك تريد حذف هذه المحادثة بشكل نهائي؟".tr,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
          height: 1.6,
          color: _dialogMessage,
          fontWeight: FontWeight.w600,
        ),
      ),
      confirm: _dialogFilledButton(
        "حذف".tr,
        _dialogRed,
        () => Navigator.of(context).pop(true),
      ),
      cancel: _dialogCancelButton(() => Navigator.of(context).pop(false)),
    );
  }
}

/// إعادة تسمية المحادثة. النافذة تملك حقل الكتابة وتتخلص منه بعد إغلاقها تماماً
/// (التخلص منه مباشرة بعد الإلغاء كان يسبب خطأ أثناء حركة الإغلاق)
class _RenameDialog extends StatefulWidget {
  final String initial;

  const _RenameDialog({required this.initial});

  @override
  State<_RenameDialog> createState() => _RenameDialogState();
}

class _RenameDialogState extends State<_RenameDialog> {
  late final TextEditingController _text = TextEditingController(
    text: widget.initial,
  );

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  void _save() {
    final title = _text.text.trim();
    if (title.isEmpty) return;
    Navigator.of(context).pop(title);
  }

  @override
  Widget build(BuildContext context) {
    return _recordsDialogFrame(
      icon: Icons.edit_outlined,
      iconColor: AppColor.primarycolor,
      iconBackground: AppColor.primarycolor.withValues(alpha: 0.08),
      iconBorder: AppColor.primarycolor.withValues(alpha: 0.15),
      title: "إعادة تسمية المحادثة".tr,
      content: TextField(
        controller: _text,
        autofocus: true,
        maxLength: 255,
        textInputAction: TextInputAction.done,
        onSubmitted: (_) => _save(),
        style: const TextStyle(
          fontSize: 14,
          color: AppColor.typography,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          counterText: '',
          hintText: "اسم المحادثة".tr,
          filled: true,
          fillColor: _dialogGreyButton,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
          // صريحة: ثيم التطبيق يخفي إطار الحقول
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: AppColor.primarycolor,
              width: 1.5,
            ),
          ),
        ),
      ),
      confirm: _dialogFilledButton("حفظ".tr, AppColor.typography, _save),
      cancel: _dialogCancelButton(() => Navigator.of(context).pop()),
    );
  }
}

/// نافذة خطأ (فشل إعادة التسمية أو الحذف) بتصميم نوافذ السجلات
class _ErrorDialog extends StatelessWidget {
  final String message;

  const _ErrorDialog({required this.message});

  @override
  Widget build(BuildContext context) {
    return _recordsDialogFrame(
      icon: Icons.warning_amber_rounded,
      iconColor: _dialogRed,
      iconBackground: const Color(0xFFFEF2F2),
      iconBorder: const Color(0xFFFEE2E2),
      title: "حدث خطأ".tr,
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
          height: 1.6,
          color: _dialogMessage,
          fontWeight: FontWeight.w600,
        ),
      ),
      confirm: _dialogFilledButton(
        "حسنًا".tr,
        AppColor.typography,
        () => Navigator.of(context).pop(),
      ),
    );
  }
}

/// تنبيه قصير فوق حقل الكتابة (مثل "انتظر حتى يكمل ChafiBot الجواب")
class _NoticeBanner extends StatelessWidget {
  final String text;

  const _NoticeBanner({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF7ED),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFED7AA)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.hourglass_top_rounded,
            size: 18,
            color: Color(0xFFEA580C),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF9A3412),
                fontWeight: FontWeight.w600,
                fontSize: 13.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
