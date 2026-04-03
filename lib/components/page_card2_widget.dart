import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/sqlite/sqlite_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'page_card2_model.dart';
export 'page_card2_model.dart';

class PageCard2Widget extends StatefulWidget {
  const PageCard2Widget({
    super.key,
    this.title,
    this.content,
    this.bookId,
    this.chapterId,
  });

  final String? title;
  final String? content;
  final int? bookId;
  final int? chapterId;

  @override
  State<PageCard2Widget> createState() => _PageCard2WidgetState();
}

class _PageCard2WidgetState extends State<PageCard2Widget> {
  late PageCard2Model _model;
  bool isBookmarked = false;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PageCard2Model());
    _checkBookmarkStatus();
  }

  Future<void> _checkBookmarkStatus() async {
    final pages = await SQLiteManager.instance.fetchBookmarkedPages();
    if (pages.any((p) => p.id == widget.chapterId)) {
      safeSetState(() {
        isBookmarked = true;
      });
    }
  }

  void _toggleBookmark() async {
    if (widget.bookId == null || widget.chapterId == null) return;
    
    if (isBookmarked) {
      await SQLiteManager.instance.removeBookmark(bookId: widget.bookId!, chapterId: widget.chapterId!, type: "pagemark");
      safeSetState(() { isBookmarked = false; });
    } else {
      await SQLiteManager.instance.addBookmark(bookId: widget.bookId!, chapterId: widget.chapterId!, type: "pagemark");
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
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: FlutterFlowTheme.of(context).alternate,
            width: 1.0,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            valueOrDefault<String>(
                              widget.title,
                              'The Silent Patient',
                            ),
                            maxLines: 2,
                            style: FlutterFlowTheme.of(context).titleMedium.override(
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
                  ].divide(SizedBox(height: 4.0)),
                ),
              ),
            ].divide(SizedBox(width: 16.0)),
          ),
        ),
      ),
    );
  }
}
