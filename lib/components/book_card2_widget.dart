import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/sqlite/sqlite_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'book_card2_model.dart';
export 'book_card2_model.dart';

class BookCard2Widget extends StatefulWidget {
  const BookCard2Widget({
    super.key,
    this.img,
    this.title,
    this.author,
    this.category,
    this.bookId,
  });

  final String? img;
  final String? title;
  final String? author;
  final String? category;
  final int? bookId;

  @override
  State<BookCard2Widget> createState() => _BookCard2WidgetState();
}

class _BookCard2WidgetState extends State<BookCard2Widget> {
  late BookCard2Model _model;
  bool isBookmarked = false;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BookCard2Model());
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
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                width: 80.0,
                height: 120.0,
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
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: (widget.img?.startsWith('assets/') ?? false)
                    ? Image.asset(
                        widget.img!,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.fill,
                      )
                    : CachedNetworkImage(
                        fadeInDuration: Duration(milliseconds: 0),
                        fadeOutDuration: Duration(milliseconds: 0),
                        imageUrl: valueOrDefault<String>(
                          widget.img?.trim(),
                          'https://dimg.dreamflow.cloud/v1/image/book cover psychological thriller',
                        ),
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        valueOrDefault<String>(
                          widget.title,
                          'The Silent Patient',
                        ),
                        maxLines: 2,
                        style: FlutterFlowTheme.of(context)
                            .titleMedium
                            .override(
                              font: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .fontStyle,
                              lineHeight: 1.5,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      FlutterFlowIconButton(
                        buttonSize: 40.0,
                        icon: Icon(
                          isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                          color: Color(0xFFC4836A),
                          size: 20.0,
                        ),
                        onPressed: _toggleBookmark,
                      ),
                    ],
                  ),
// Removed FlutterFlowChoiceChips
                ].divide(SizedBox(height: 4.0)),
              ),
            ),
          ].divide(SizedBox(width: 16.0)),
        ),
      ),
    );
  }
}
