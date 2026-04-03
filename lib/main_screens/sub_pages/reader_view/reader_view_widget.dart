import '/backend/sqlite/sqlite_manager.dart';
import '/components/control_chip_widget.dart';
import '/components/cust_app_bar_widget.dart';
import '/components/font_size_button_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'reader_view_model.dart';
export 'reader_view_model.dart';

class ReaderViewWidget extends StatefulWidget {
  const ReaderViewWidget({
    super.key,
    required this.chapterNumber,
    this.content,
    this.title,
    required this.bookId,
    int? parentId,
    this.searchKeyword,
  }) : this.parentId = parentId ?? 0;

  final int? chapterNumber;
  final String? content;
  final String? title;
  final int? bookId;
  final int parentId;
  final String? searchKeyword;

  static String routeName = 'ReaderView';
  static String routePath = '/readerView';

  @override
  State<ReaderViewWidget> createState() => _ReaderViewWidgetState();
}

class _ReaderViewWidgetState extends State<ReaderViewWidget>
    with TickerProviderStateMixin {
  late ReaderViewModel _model;
  List<FetchChaptersContentRow>? chapters;
  Set<int> bookmarkedChapterIds = {};
  double _currentScrollFraction = 0.0;
  double _lastSavedScrollFraction = 0.0;
  bool _hasScrolledToMatch = false;
  List<GlobalKey> _matchKeys = [];
  int _currentMatchIndex = 0;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = <String, AnimationInfo>{};

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReaderViewModel());
    _loadData();

    animationsMap.addAll({
      'textOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 0.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 0.0.ms,
            begin: Offset(0.0, 120.0),
            end: Offset(0.0, 0.0),
          ),
        ],
      ),
    });
    setupAnimations(
      animationsMap.values.where((anim) =>
          anim.trigger == AnimationTrigger.onActionTrigger ||
          !anim.applyInitialState),
      this,
    );
  }

  Future<void> _loadData() async {
    final fetchedChapters = await SQLiteManager.instance.fetchChaptersContent(
      bookId: widget.bookId!,
      parentId: widget.parentId,
    );
    final pages = await SQLiteManager.instance.fetchBookmarkedPages();
    if (mounted) {
      safeSetState(() {
        chapters = fetchedChapters;
        bookmarkedChapterIds = pages.map((p) => p.id).toSet();
      });
    }
  }

  Future<void> toggleBookmark(int chapterId) async {
    if (bookmarkedChapterIds.contains(chapterId)) {
      await SQLiteManager.instance.removeBookmark(bookId: widget.bookId!, chapterId: chapterId, type: "pagemark");
      safeSetState(() {
        bookmarkedChapterIds.remove(chapterId);
      });
    } else {
      await SQLiteManager.instance.addBookmark(bookId: widget.bookId!, chapterId: chapterId, type: "pagemark");
      safeSetState(() {
        bookmarkedChapterIds.add(chapterId);
      });
    }
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  /// Scrolls to the match at the specified index.
  void _scrollToMatch(int index) {
    if (index >= 0 && index < _matchKeys.length) {
      safeSetState(() => _currentMatchIndex = index);
      final key = _matchKeys[index];
      if (key.currentContext != null) {
        Scrollable.ensureVisible(
          key.currentContext!,
          duration: Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          alignment: 0.3,
        );
      }
    }
  }

  /// Builds the chapter title with search keyword highlighted.
  Widget _buildTitle(BuildContext context, String content) {
    final keyword = widget.searchKeyword;
    final baseStyle = FlutterFlowTheme.of(context).displaySmall.override(
          font: GoogleFonts.interTight(
            fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
            fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
          ),
          letterSpacing: 0.0,
          fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
          fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
        );

    if (keyword == null || keyword.isEmpty) {
      return Text(content, style: baseStyle);
    }

    final lowerContent = content.toLowerCase();
    final lowerKeyword = keyword.toLowerCase();
    final spans = <InlineSpan>[];
    int start = 0;

    while (true) {
      final idx = lowerContent.indexOf(lowerKeyword, start);
      if (idx == -1) {
        spans.add(TextSpan(text: content.substring(start)));
        break;
      }
      if (idx > start) {
        spans.add(TextSpan(text: content.substring(start, idx)));
      }

      final key = GlobalKey();
      _matchKeys.add(key);
      spans.add(WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: KeyedSubtree(
          key: key,
          child: Text(
            content.substring(idx, idx + keyword.length),
            style: TextStyle(
              backgroundColor: FlutterFlowTheme.of(context).tertiary,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: baseStyle.fontSize,
            ),
          ),
        ),
      ));
      start = idx + keyword.length;
    }

    return RichText(
      text: TextSpan(style: baseStyle, children: spans),
    );
  }

  /// Builds the chapter content with search keyword highlighted.
  Widget _buildContent(BuildContext context, String content, bool isCurrentPage) {
    final keyword = widget.searchKeyword;
    final baseStyle = FlutterFlowTheme.of(context).labelMedium.override(
          font: GoogleFonts.inter(
            fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
            fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
          ),
          letterSpacing: 0.0,
          fontWeight: FlutterFlowTheme.of(context).labelMedium.fontWeight,
          fontStyle: FlutterFlowTheme.of(context).labelMedium.fontStyle,
        );

    if (keyword == null || keyword.isEmpty) {
      return Text(content, style: baseStyle);
    }

    final lowerContent = content.toLowerCase();
    final lowerKeyword = keyword.toLowerCase();
    final spans = <InlineSpan>[];
    int start = 0;

    while (true) {
      final idx = lowerContent.indexOf(lowerKeyword, start);
      if (idx == -1) {
        spans.add(TextSpan(text: content.substring(start)));
        break;
      }
      if (idx > start) {
        spans.add(TextSpan(text: content.substring(start, idx)));
      }

      final key = GlobalKey();
      _matchKeys.add(key);
      spans.add(WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: KeyedSubtree(
          key: key,
          child: Container(
            color: FlutterFlowTheme.of(context).tertiary,
            child: Text(
              content.substring(idx, idx + keyword.length),
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: baseStyle.fontSize,
              ),
            ),
          ),
        ),
      ));
      
      start = idx + keyword.length;
    }

    if (isCurrentPage && _matchKeys.isNotEmpty && !_hasScrolledToMatch) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && _matchKeys.isNotEmpty && _matchKeys[0].currentContext != null) {
          _hasScrolledToMatch = true;
          Scrollable.ensureVisible(
            _matchKeys[0].currentContext!,
            duration: Duration(milliseconds: 600),
            curve: Curves.easeInOut,
            alignment: 0.3,
          );
        }
      });
    }

    return RichText(
      text: TextSpan(style: baseStyle, children: spans),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (chapters == null) {
      return Scaffold(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              FlutterFlowTheme.of(context).primary,
            ),
          ),
        ),
      );
    }
    
    final pageViewFetchChaptersContentRowList = chapters!;
    final int currentIndex = _model.pageViewController?.page?.round() ?? max(
      0, min(valueOrDefault<int>((widget.chapterNumber!) - 1, 0), pageViewFetchChaptersContentRowList.length - 1)
    );
    final currentChapterId = pageViewFetchChaptersContentRowList[currentIndex].id;
    final bool isBookmarked = bookmarkedChapterIds.contains(currentChapterId);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (widget.searchKeyword != null && _matchKeys.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4.0,
                      color: Color(0x33000000),
                      offset: Offset(0.0, 2.0),
                    )
                  ],
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).alternate,
                    width: 1.0,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.keyboard_arrow_up_rounded),
                      onPressed: _currentMatchIndex > 0
                          ? () => _scrollToMatch(_currentMatchIndex - 1)
                          : null,
                      color: FlutterFlowTheme.of(context).primaryText,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        '${_currentMatchIndex + 1} of ${_matchKeys.length}',
                        style: FlutterFlowTheme.of(context).labelMedium,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.keyboard_arrow_down_rounded),
                      onPressed: _currentMatchIndex < _matchKeys.length - 1
                          ? () => _scrollToMatch(_currentMatchIndex + 1)
                          : null,
                      color: FlutterFlowTheme.of(context).primaryText,
                    ),
                  ],
                ),
              ),
            ),
          FloatingActionButton(
            onPressed: () async {
              _model.utilityFlag = !_model.utilityFlag;
              safeSetState(() {});
            },
            backgroundColor: FlutterFlowTheme.of(context).primary,
            elevation: 8.0,
            child: Icon(
              Icons.add_rounded,
              color: FlutterFlowTheme.of(context).info,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0.0, 70.0, 0.0, 100.0),
                        child: PageView.builder(
                          controller: _model.pageViewController ??= PageController(
                            initialPage: max(0, min(valueOrDefault<int>((widget.chapterNumber!) - 1, 0), pageViewFetchChaptersContentRowList.length - 1)),
                          ),
                          onPageChanged: (_) async {
                            _currentScrollFraction = 0.0;
                            _lastSavedScrollFraction = 0.0;
                            _hasScrolledToMatch = false;
                            safeSetState(() {});
                            SQLiteManager.instance.updateReadingHistory(
                              bookId: widget.bookId!,
                              chapterId: pageViewFetchChaptersContentRowList[_model.pageViewController?.page?.round() ?? 0].id,
                              percent: (((_model.pageViewController?.page?.round() ?? 0) + _currentScrollFraction) / pageViewFetchChaptersContentRowList.length),
                            );
                          },
                          itemCount: pageViewFetchChaptersContentRowList.length,
                          itemBuilder: (context, pageViewIndex) {
                            final row = pageViewFetchChaptersContentRowList[pageViewIndex];
                            if (pageViewIndex == currentIndex) {
                              _matchKeys.clear();
                            }
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: NotificationListener<ScrollNotification>(
                                    onNotification: (scrollInfo) {
                                      if (scrollInfo.metrics.axis == Axis.vertical && scrollInfo.metrics.maxScrollExtent > 0) {
                                        final fraction = scrollInfo.metrics.pixels / scrollInfo.metrics.maxScrollExtent;
                                        final clampedFraction = fraction.clamp(0.0, 1.0);
                                        if ((clampedFraction - _currentScrollFraction).abs() > 0.01) {
                                          safeSetState(() {
                                            _currentScrollFraction = clampedFraction;
                                          });
                                          if ((clampedFraction - _lastSavedScrollFraction).abs() > 0.05) {
                                            _lastSavedScrollFraction = clampedFraction;
                                            SQLiteManager.instance.updateReadingHistory(
                                              bookId: widget.bookId!,
                                              chapterId: pageViewFetchChaptersContentRowList[_model.pageViewController?.page?.round() ?? 0].id,
                                              percent: (((_model.pageViewController?.page?.round() ?? 0) + clampedFraction) / pageViewFetchChaptersContentRowList.length),
                                            );
                                          }
                                        }
                                      }
                                      return false;
                                    },
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 0.0),
                                            child: _buildTitle(context, '${row.number}. ${row.title}'),
                                          ),
                                          Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 10.0),
                                            child: SelectionArea(
                                              child: _buildContent(context, row.content, pageViewIndex == currentIndex),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation']!),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional(0.0, 1.0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                          child: smooth_page_indicator.SmoothPageIndicator(
                            controller: _model.pageViewController!,
                            count: pageViewFetchChaptersContentRowList.length,
                            effect: smooth_page_indicator.SlideEffect(
                              spacing: 8.0,
                              radius: 8.0,
                              dotWidth: 8.0,
                              dotHeight: 8.0,
                              dotColor: FlutterFlowTheme.of(context).accent1,
                              activeDotColor: FlutterFlowTheme.of(context).primary,
                              paintStyle: PaintingStyle.fill,
                            ),
                          ),
                        ),
                      ),
                      if (!_model.utilityFlag)
                        Align(
                          alignment: AlignmentDirectional(0.0, 1.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 24.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFFEFEFF),
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(color: Color(0xFFE0E0E8)),
                                  ),
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            ControlChipWidget(selected: true, label: 'Serif'),
                                            ControlChipWidget(selected: false, label: 'Sans'),
                                            ControlChipWidget(selected: false, label: 'Mono'),
                                            ControlChipWidget(selected: false, label: 'Classic'),
                                          ].divide(SizedBox(width: 8.0)),
                                        ),
                                      ),
                                      Divider(thickness: 0.5, color: FlutterFlowTheme.of(context).alternate),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              FontSizeButtonWidget(icon: 'text_fields_rounded', size: 16.0),
                                              FontSizeButtonWidget(icon: 'text_fields_rounded', size: 24.0),
                                            ].divide(SizedBox(width: 8.0)),
                                          ),
                                          Row(
                                            children: [
                                              Container(width: 32, height: 32, decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: FlutterFlowTheme.of(context).alternate))),
                                              Container(width: 32, height: 32, decoration: BoxDecoration(color: Color(0xFFF5E6D3), shape: BoxShape.circle, border: Border.all(color: FlutterFlowTheme.of(context).alternate))),
                                              Container(width: 32, height: 32, decoration: BoxDecoration(color: Color(0xFF1A1A1A), shape: BoxShape.circle, border: Border.all(color: Color(0xFF333333)))),
                                            ].divide(SizedBox(width: 4.0)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16.0),
                                FFButtonWidget(
                                  onPressed: () {},
                                  text: 'Power Search in Chapter',
                                  icon: Icon(Icons.search_rounded, size: 15.0),
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 44.0,
                                    color: FlutterFlowTheme.of(context).secondaryBackground,
                                    textStyle: FlutterFlowTheme.of(context).titleSmall,
                                    borderSide: BorderSide(color: Color(0xFFE0E0E8)),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ],
                            ),
                          ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation']!),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: AlignmentDirectional(0.0, -1.0),
              child: Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${(((currentIndex + _currentScrollFraction) / pageViewFetchChaptersContentRowList.length) * 100).toInt()}% read', style: FlutterFlowTheme.of(context).labelSmall),
                          Text('${currentIndex + 1} of ${pageViewFetchChaptersContentRowList.length}', style: FlutterFlowTheme.of(context).labelSmall),
                        ],
                      ),
                      LinearPercentIndicator(
                        percent: ((currentIndex + _currentScrollFraction) / pageViewFetchChaptersContentRowList.length).clamp(0.0, 1.0),
                        lineHeight: 2.0,
                        progressColor: Color(0xFFEE8B60),
                        backgroundColor: FlutterFlowTheme.of(context).alternate,
                        padding: EdgeInsets.zero,
                      ),
                    ].divide(SizedBox(height: 4.0)),
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, -1.0),
              child: Padding(
                padding: EdgeInsets.only(top: 24.0), // Pulled up closer to progress bar
                child: Container(
                  height: 80.0,
                  child: wrapWithModel(
                    model: _model.custAppBarModel,
                    updateCallback: () => safeSetState(() {}),
                    child: CustAppBarWidget(
                      isBookmarked: isBookmarked,
                      onBookmarkTap: () => toggleBookmark(currentChapterId),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
