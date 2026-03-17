import 'package:chafi/core/constant/Colorapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfSearchPage extends StatefulWidget {
  final String url;
  final int? initialPage;

  const PdfSearchPage({super.key, required this.url, this.initialPage});

  @override
  State<PdfSearchPage> createState() => _PdfSearchPageState();
}

class _PdfSearchPageState extends State<PdfSearchPage> {
  final PdfViewerController _pdfController = PdfViewerController();
  PdfTextSearchResult _searchResult = PdfTextSearchResult();
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  int _currentPage = 1;
  int _totalPages = 0;

  @override
  void initState() {
    super.initState();

    if (widget.initialPage != null && widget.initialPage! > 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _pdfController.jumpToPage(widget.initialPage!);
      });
    }

    // إضافة Listener لتحديث إجمالي الصفحات
    _pdfController.addListener(() {
      if (!mounted) return; // <--- مهم جداً لمنع الخطأ
      if (_pdfController.pageCount != _totalPages &&
          _pdfController.pageCount != 0) {
        setState(() {
          _totalPages = _pdfController.pageCount;
        });
      }
    });
  }

  @override
  void dispose() {
    _pdfController.dispose(); // إزالة listener
    super.dispose();
  }

  void _searchText() {
    if (_searchController.text.isEmpty) return;
    _searchResult = _pdfController.searchText(_searchController.text);
    setState(() {});
  }

  void _nextInstance() {
    if (_searchResult.hasResult) {
      _searchResult.nextInstance();
      setState(() {});
    }
  }

  void _previousInstance() {
    if (_searchResult.hasResult) {
      _searchResult.previousInstance();
      setState(() {});
    }
  }

  String _resultText() {
    if (!_searchResult.hasResult || _searchResult.totalInstanceCount == 0) {
      return "0 / 0";
    }
    return "${_searchResult.currentInstanceIndex + 1} / ${_searchResult.totalInstanceCount}";
  }

  void _showJumpToPageDialog() {
    final TextEditingController _pageController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColor.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            "اذهب إلى الصفحة".tr,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.typography,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          content: TextField(
            controller: _pageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "أدخل رقم الصفحة".tr,
              hintStyle: TextStyle(color: Colors.grey[400]),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
            ),
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
          actionsPadding: const EdgeInsets.only(right: 10, bottom: 10),
          actions: [
            TextButton(
              style: TextButton.styleFrom(foregroundColor: Colors.grey[700]),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("إلغاء".tr),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.typography,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  final int? page = int.tryParse(_pageController.text);
                  if (page != null && page > 0) {
                    _pdfController.jumpToPage(page);
                  }
                  Navigator.of(context).pop();
                },
                child: Text("اذهب".tr),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: !_isSearching
            ? Text('PDF Viewer'.tr)
            : TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'ابحث داخل الملف...'.tr,
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white54),
                ),
                style: const TextStyle(color: Colors.black, fontSize: 19),
                onSubmitted: (_) => _searchText(),
              ),
        actions: [
          if (!_isSearching)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                setState(() {
                  _isSearching = true;
                });
              },
            )
          else ...[
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                setState(() {
                  _isSearching = false;
                  _searchController.clear();
                  _searchResult.clear();
                });
              },
            ),
            if (_searchResult.hasResult)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    _resultText(),
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: _previousInstance,
            ),
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: _nextInstance,
            ),
          ],
          // زر الانتقال للصفحة مع ستايل شافي
          IconButton(
            icon: const Icon(Icons.menu_book),
            tooltip: "اذهب إلى الصفحة".tr,
            onPressed: _showJumpToPageDialog,
          ),
        ],
      ),
      body: Stack(
        children: [
          SfPdfViewer.network(
            widget.url,
            controller: _pdfController,
            enableTextSelection: true,
            canShowScrollHead: false,
            onPageChanged: (details) {
              setState(() {
                _currentPage = details.newPageNumber;
              });
            },
          ),

          // رقم الصفحة على الجانب
          Positioned(
            top: 50, // أعلى الشاشة مع مسافة
            right: 10, // على اليمين
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$_currentPage',
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
