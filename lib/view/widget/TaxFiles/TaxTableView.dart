import 'dart:math' as math;
import 'dart:ui' show FontFeature;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/Colorapp.dart';
import '../../../data/model/TaxFileModel.dart';

/// ألوان وأبعاد الجدول
class _T {
  static const header = AppColor.typography;
  static const headerText = Colors.white;
  static const stripe = Color(0xFFF5F8FC);
  static const line = Color(0xFFDDE5EE);
  static const headerLine = Color(0x33FFFFFF);
  static const ink = Color(0xFF1E293B);
  static const muted = Color(0xFF64748B);

  static const padH = 12.0;
  static const padV = 10.0;
  static const minCol = 72.0;
  static const maxCol = 240.0;
  static const minRow = 40.0;
}

/// أرقام ومبالغ: تُعرض في الوسط بأرقام متساوية العرض
final _numeric = RegExp(r'^[\s\d٠-٩.,،%\-–/+×()]*(دج|DA|DZD)?[\s.]*$');

bool _isNumeric(String text) =>
    text.trim().isNotEmpty &&
    RegExp(r'[\d٠-٩]').hasMatch(text) &&
    _numeric.hasMatch(text.trim());

TextStyle _cellStyle(TaxTableCell cell) {
  final numeric = !cell.isHeader && _isNumeric(cell.text);
  return TextStyle(
    fontSize: 13,
    height: 1.5,
    color: cell.isHeader ? _T.headerText : _T.ink,
    fontWeight: cell.isHeader ? FontWeight.bold : FontWeight.normal,
    fontFeatures: numeric ? const [FontFeature.tabularFigures()] : null,
  );
}

TextAlign _cellAlign(TaxTableCell cell) =>
    cell.isHeader || _isNumeric(cell.text) ? TextAlign.center : TextAlign.start;

/// أبعاد الأعمدة والصفوف محسوبة بقياس النصوص (TextPainter)،
/// والخلية المدمجة تأخذ مساحة كل المواضع التي تغطيها
class _TableLayout {
  final List<double> colWidths;
  final List<double> rowHeights;
  late final List<double> colX = _prefix(colWidths);
  late final List<double> rowY = _prefix(rowHeights);

  _TableLayout(this.colWidths, this.rowHeights);

  double get width => colX.last;
  double get height => rowY.last;

  static List<double> _prefix(List<double> v) {
    final out = <double>[0];
    for (final x in v) {
      out.add(out.last + x);
    }
    return out;
  }

  /// [stretchTo]: إذا كان الجدول أضيق من المساحة المتاحة تتمدد الأعمدة لتملأها
  static _TableLayout compute(
    TaxArticleTable table,
    TextScaler scaler, {
    double? stretchTo,
    double maxCol = _T.maxCol,
  }) {
    final painter =
        TextPainter(textDirection: TextDirection.rtl, textScaler: scaler);
    Size measure(TaxTableCell c, double? maxWidth) {
      painter.text = TextSpan(
          text: c.text.isEmpty ? ' ' : c.text, style: _cellStyle(c));
      painter.layout(maxWidth: maxWidth ?? double.infinity);
      return painter.size;
    }

    final anchors = table.cells;
    var cols = List<double>.filled(table.nCols, _T.minCol);
    for (final c in anchors) {
      if (c.colSpan != 1) continue;
      final w = measure(c, null).width + _T.padH * 2 + 2;
      cols[c.col] = math.max(cols[c.col], math.min(w, maxCol));
    }

    final natural = cols.fold<double>(0, (a, b) => a + b);
    if (stretchTo != null && natural < stretchTo && natural > 0) {
      final k = stretchTo / natural;
      cols = cols.map((w) => w * k).toList();
    }

    double spanWidth(TaxTableCell c) {
      double w = 0;
      for (int k = c.col; k < c.col + c.colSpan; k++) {
        w += cols[k];
      }
      return w;
    }

    final rows = List<double>.filled(table.nRows, _T.minRow);
    for (final c in anchors) {
      if (c.rowSpan != 1) continue;
      final h = measure(c, spanWidth(c) - _T.padH * 2 - 2).height + _T.padV * 2;
      rows[c.row] = math.max(rows[c.row], h);
    }
    // الخلية المدمجة عمودياً: إذا لم تكفها الصفوف نزيد آخر صف فيها
    for (final c in anchors) {
      if (c.rowSpan == 1) continue;
      final h =
          measure(c, spanWidth(c) - _T.padH * 2 - 2).height + _T.padV * 2;
      double have = 0;
      for (int r = c.row; r < c.row + c.rowSpan; r++) {
        have += rows[r];
      }
      if (h > have) rows[c.row + c.rowSpan - 1] += h - have;
    }
    painter.dispose();
    return _TableLayout(cols, rows);
  }

  Rect rectOf(TaxTableCell c) => Rect.fromLTWH(
        colX[c.col],
        rowY[c.row],
        colX[c.col + c.colSpan] - colX[c.col],
        rowY[c.row + c.rowSpan] - rowY[c.row],
      );
}

/// شبكة الجدول نفسها (خلايا في مواضع محسوبة)
class _TableGrid extends StatelessWidget {
  final TaxArticleTable table;
  final _TableLayout layout;
  final String highlight;

  const _TableGrid({
    required this.table,
    required this.layout,
    this.highlight = '',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: layout.width,
      height: layout.height,
      child: Stack(
        children: [
          for (final cell in table.cells)
            PositionedDirectional(
              start: layout.rectOf(cell).left,
              top: layout.rectOf(cell).top,
              width: layout.rectOf(cell).width,
              height: layout.rectOf(cell).height,
              child: _cell(cell),
            ),
        ],
      ),
    );
  }

  Widget _cell(TaxTableCell cell) {
    final header = cell.isHeader;
    final lastCol = cell.col + cell.colSpan >= table.nCols;
    final lastRow = cell.row + cell.rowSpan >= table.nRows;
    final line = header ? _T.headerLine : _T.line;
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: _T.padH, vertical: _T.padV),
      alignment: header || _isNumeric(cell.text)
          ? Alignment.center
          : AlignmentDirectional.centerStart,
      decoration: BoxDecoration(
        color: header
            ? _T.header
            : cell.row.isOdd
                ? _T.stripe
                : Colors.white,
        border: BorderDirectional(
          end: lastCol ? BorderSide.none : BorderSide(color: line),
          bottom: lastRow ? BorderSide.none : BorderSide(color: line),
        ),
      ),
      child: Text.rich(
        _highlighted(cell.text, _cellStyle(cell), header),
        textAlign: _cellAlign(cell),
      ),
    );
  }

  /// تلوين كلمات البحث داخل الخلية (خلفية فقط حتى لا يتغير عرض النص)
  TextSpan _highlighted(String text, TextStyle style, bool header) {
    final words = highlight
        .trim()
        .split(RegExp(r'\s+'))
        .where((w) => w.length > 1)
        .map(RegExp.escape)
        .toList();
    if (words.isEmpty) return TextSpan(text: text, style: style);
    final mark = style.copyWith(
      backgroundColor: header
          ? Colors.amber.withOpacity(0.55)
          : Colors.amber.withOpacity(0.35),
    );
    final spans = <TextSpan>[];
    int last = 0;
    for (final m in RegExp(words.join('|'), caseSensitive: false)
        .allMatches(text)) {
      if (m.start > last) {
        spans.add(TextSpan(text: text.substring(last, m.start), style: style));
      }
      spans.add(TextSpan(text: m.group(0), style: mark));
      last = m.end;
    }
    if (last < text.length) {
      spans.add(TextSpan(text: text.substring(last), style: style));
    }
    return TextSpan(children: spans);
  }
}

/// جدول مادة: بطاقة فيها رقم الجدول وعنوانه، الجدول بخلاياه المدمجة،
/// تمرير أفقي عند الحاجة، وزر عرض بملء الشاشة
class TaxTableView extends StatefulWidget {
  final TaxArticleTable table;

  /// رقم الجدول داخل المادة (يبدأ من 1)
  final int number;

  /// كلمات البحث لتلوينها داخل الخلايا
  final String highlight;

  const TaxTableView({
    super.key,
    required this.table,
    this.number = 1,
    this.highlight = '',
  });

  @override
  State<TaxTableView> createState() => _TaxTableViewState();
}

class _TaxTableViewState extends State<TaxTableView> {
  final ScrollController _scroll = ScrollController();

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _openFullscreen() {
    Get.to(() => TaxTableFullscreen(
          table: widget.table,
          number: widget.number,
          highlight: widget.highlight,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final table = widget.table;
    final scaler = MediaQuery.textScalerOf(context);

    // محتوى الجداول بالعربية: من اليمين لليسار حتى في الواجهة الإنجليزية
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _T.line),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _header(table),
            LayoutBuilder(builder: (context, constraints) {
              // على الهاتف: لا يأخذ عمود أكثر من ~42% من العرض، فيلتف النص الطويل
              // داخل خليته وتبقى الأعمدة الأخرى ظاهرة
              final layout = _TableLayout.compute(
                table,
                scaler,
                stretchTo: constraints.maxWidth,
                maxCol: (constraints.maxWidth * 0.42).clamp(110.0, _T.maxCol),
              );
              final overflows = layout.width > constraints.maxWidth + 0.5;
              final grid = _TableGrid(
                table: table,
                layout: layout,
                highlight: widget.highlight,
              );
              if (!overflows) return grid;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Scrollbar(
                    controller: _scroll,
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      controller: _scroll,
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(bottom: 8),
                      child: grid,
                    ),
                  ),
                  _swipeHint(),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _header(TaxArticleTable table) {
    final title = table.title.trim();
    return Container(
      padding: const EdgeInsetsDirectional.fromSTEB(12, 8, 4, 8),
      color: const Color(0xFFF8FAFC),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: _T.header,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.table_chart_outlined,
                    size: 14, color: Colors.white),
                const SizedBox(width: 4),
                Text(
                  '${"جدول".tr} ${widget.number}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: _T.ink,
              ),
            ),
          ),
          IconButton(
            tooltip: "عرض بملء الشاشة".tr,
            visualDensity: VisualDensity.compact,
            onPressed: _openFullscreen,
            icon: const Icon(Icons.open_in_full, size: 18, color: _T.muted),
          ),
        ],
      ),
    );
  }

  Widget _swipeHint() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.swipe, size: 14, color: _T.muted),
          const SizedBox(width: 4),
          Text(
            "اسحب لرؤية الجدول كاملاً".tr,
            style: const TextStyle(fontSize: 11, color: _T.muted),
          ),
        ],
      ),
    );
  }
}

/// عرض الجدول بملء الشاشة: يفتح مصغراً ليظهر كاملاً في عرض الشاشة،
/// ثم يمكن التكبير والتحريك بالأصابع
class TaxTableFullscreen extends StatefulWidget {
  final TaxArticleTable table;
  final int number;
  final String highlight;

  const TaxTableFullscreen({
    super.key,
    required this.table,
    required this.number,
    this.highlight = '',
  });

  @override
  State<TaxTableFullscreen> createState() => _TaxTableFullscreenState();
}

class _TaxTableFullscreenState extends State<TaxTableFullscreen> {
  static const double _pad = 16;
  final TransformationController _transform = TransformationController();
  double? _fittedFor;

  @override
  void dispose() {
    _transform.dispose();
    super.dispose();
  }

  /// تصغير الجدول ليظهر كاملاً في عرض الشاشة (مرة واحدة لكل عرض)
  void _fit(double viewportWidth, double tableWidth) {
    if (_fittedFor == viewportWidth) return;
    _fittedFor = viewportWidth;
    final contentWidth = tableWidth + _pad * 2;
    final scale = math.min(1.0, viewportWidth / contentWidth);
    _transform.value = Matrix4.identity()..scale(scale, scale);
  }

  @override
  Widget build(BuildContext context) {
    final table = widget.table;
    final layout =
        _TableLayout.compute(table, MediaQuery.textScalerOf(context));
    final title = table.title.trim();
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: Text(
          title.isEmpty ? '${"جدول".tr} ${widget.number}' : title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            tooltip: "ملاءمة العرض".tr,
            icon: const Icon(Icons.fit_screen_outlined),
            onPressed: () => setState(() => _fittedFor = null),
          ),
        ],
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: LayoutBuilder(builder: (context, constraints) {
          _fit(constraints.maxWidth, layout.width);
          return InteractiveViewer(
            transformationController: _transform,
            constrained: false,
            minScale: 0.2,
            maxScale: 5,
            boundaryMargin: const EdgeInsets.all(120),
            child: Padding(
              padding: const EdgeInsets.all(_pad),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: _T.line),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: _TableGrid(
                  table: table,
                  layout: layout,
                  highlight: widget.highlight,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
