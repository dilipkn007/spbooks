import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/sqlite/sqlite_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'book_card_model.dart';
export 'book_card_model.dart';

class BookCardWidget extends StatefulWidget {
  const BookCardWidget({
    super.key,
    this.title,
    required this.coverImage,
    required this.bookId,
  });

  final String? title;
  final String? coverImage;
  final int? bookId;

  @override
  State<BookCardWidget> createState() => _BookCardWidgetState();
}

class _BookCardWidgetState extends State<BookCardWidget> {
  late BookCardModel _model;
  bool isBookmarked = false;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BookCardModel());
    _checkBookmarkStatus();
  }

  Future<void> _checkBookmarkStatus() async {
    final books = await SQLiteManager.instance.fetchBookmarkedBooks();
    if (books.any((b) => b.id == widget.bookId)) {
      safeSetState(() {
        isBookmarked = true;
      });
    }
  }

  void _toggleBookmark() async {
    if (widget.bookId == null) return;
    
    if (isBookmarked) {
      await SQLiteManager.instance.removeBookmark(bookId: widget.bookId!, type: "book");
      safeSetState(() { isBookmarked = false; });
    } else {
      await SQLiteManager.instance.addBookmark(bookId: widget.bookId!, type: "book");
      safeSetState(() { isBookmarked = true; });
    }
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional(0.0, -1.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24.0),
            child: Container(
              width: 100.0,
              height: 130.0,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2.0,
                    color: Color(0x1A000000),
                    offset: Offset(
                      0.0,
                      1.0,
                    ),
                    spreadRadius: 0.0,
                  )
                ],
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    fadeInDuration: Duration(milliseconds: 0),
                    fadeOutDuration: Duration(milliseconds: 0),
                    imageUrl: widget.coverImage!,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Container(
                      alignment: AlignmentDirectional(1.0, -1.0),
                      child: IconButton(
                        icon: Icon(
                          isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                          color: FlutterFlowTheme.of(context).error,
                          size: 24.0,
                        ),
                        onPressed: _toggleBookmark,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ].divide(SizedBox(height: 1.0)),
      ),
    );
  }
}
