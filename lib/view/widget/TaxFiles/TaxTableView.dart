import 'package:flutter/material.dart';

import '../../../core/constant/Colorapp.dart';
import '../../../data/model/TaxFileModel.dart';

/// عرض جدول مادة: صفوف العناوين بلون التطبيق، وأسطر متناوبة،
/// والخلية المدمجة يظهر نصها في أول موضع منها
class TaxTableView extends StatelessWidget {
  final TaxArticleTable table;

  const TaxTableView({super.key, required this.table});

  static const Color _line = Color(0xFFDCE3EC);
  static const Color _stripe = Color(0xFFF4F7FB);

  @override
  Widget build(BuildContext context) {
    // محتوى الجداول بالعربية: نبقيها من اليمين لليسار حتى في الواجهة الإنجليزية
    return Directionality(
      textDirection: TextDirection.rtl,
      child: _table(),
    );
  }

  Widget _table() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (table.title.trim().isNotEmpty) ...[
          Row(
            children: [
              const Icon(Icons.table_chart_outlined,
                  size: 18, color: AppColor.typography),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  table.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColor.typography,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: _line),
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAlias,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Table(
              defaultColumnWidth: const IntrinsicColumnWidth(),
              defaultVerticalAlignment:
                  TableCellVerticalAlignment.intrinsicHeight,
              border: const TableBorder(
                horizontalInside: BorderSide(color: _line),
                verticalInside: BorderSide(color: _line),
              ),
              children: [
                for (int r = 0; r < table.nRows; r++)
                  TableRow(
                    children: [
                      for (int c = 0; c < table.nCols; c++) _cell(r, c),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _cell(int r, int c) {
    final cell = table.cellCovering(r, c);
    final isAnchor = cell != null && cell.row == r && cell.col == c;
    final header = cell?.isHeader ?? false;
    final row = cell?.row ?? r;
    return Container(
      constraints: const BoxConstraints(minWidth: 70, maxWidth: 220),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      color: header
          ? AppColor.typography
          : row.isOdd
              ? _stripe
              : Colors.white,
      child: Text(
        isAnchor ? cell.text : '',
        textAlign: header ? TextAlign.center : TextAlign.start,
        style: TextStyle(
          fontSize: 13,
          height: 1.5,
          color: header ? Colors.white : Colors.black87,
          fontWeight: header ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
