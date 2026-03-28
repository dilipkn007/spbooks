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
  }) : this.parentId = parentId ?? 0;

  final int? chapterNumber;
  final String? content;
  final String? title;
  final int? bookId;
  final int parentId;

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
      floatingActionButton: FloatingActionButton(
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
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Stack(
                  children: [
                    Container(
                      height: (MediaQuery.sizeOf(context).height * 0.90),
                      decoration: BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                                child: Container(
                                  width: double.infinity,
                                  height: 500.0,
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 0.0, 40.0),
                                        child: PageView.builder(
                                          controller: _model
                                                  .pageViewController ??=
                                              PageController(
                                                  initialPage: max(
                                                      0,
                                                      min(
                                                          valueOrDefault<int>(
                                                            (widget.chapterNumber!) -
                                                                1,
                                                            0,
                                                          ),
                                                          pageViewFetchChaptersContentRowList
                                                                  .length -
                                                              1))),
                                          onPageChanged: (_) async {
                                            _currentScrollFraction = 0.0;
                                            safeSetState(() {});
                                          },
                                          scrollDirection: Axis.horizontal,
                                          itemCount:
                                              pageViewFetchChaptersContentRowList
                                                  .length,
                                          itemBuilder:
                                              (context, pageViewIndex) {
                                            final pageViewFetchChaptersContentRow =
                                                pageViewFetchChaptersContentRowList[
                                                    pageViewIndex];
                                            return Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Expanded(
                                                  child: NotificationListener<ScrollNotification>(
                                                    onNotification: (ScrollNotification scrollInfo) {
                                                      if (scrollInfo.metrics.axis == Axis.vertical && scrollInfo.metrics.maxScrollExtent > 0) {
                                                        final fraction = scrollInfo.metrics.pixels / scrollInfo.metrics.maxScrollExtent;
                                                        final clampedFraction = fraction.clamp(0.0, 1.0);
                                                        if ((clampedFraction - _currentScrollFraction).abs() > 0.01) {
                                                          safeSetState(() {
                                                            _currentScrollFraction = clampedFraction;
                                                          });
                                                        }
                                                      }
                                                      return false;
                                                    },
                                                    child: SingleChildScrollView(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      64.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Expanded(
                                                                child: Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          -1.0,
                                                                          0.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            24.0,
                                                                            2.0,
                                                                            24.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      '${pageViewFetchChaptersContentRow.number.toString()}. ${pageViewFetchChaptersContentRow.title}',
                                                                      maxLines:
                                                                          3,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .displaySmall
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.interTight(
                                                                              fontWeight: FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                              fontStyle: FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                            ),
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).displaySmall.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).displaySmall.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  -1.0, 0.0),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        24.0,
                                                                        24.0,
                                                                        24.0,
                                                                        10.0),
                                                            child:
                                                                SelectionArea(
                                                                    child: Text(
                                                              pageViewFetchChaptersContentRow
                                                                  .content,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .labelMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .inter(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .labelMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .labelMedium
                                                                        .fontStyle,
                                                                  ),
                                                            )).animateOnPageLoad(
                                                                    animationsMap[
                                                                        'textOnPageLoadAnimation']!),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 1.0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 16.0),
                                          child: smooth_page_indicator
                                              .SmoothPageIndicator(
                                            controller: _model
                                                    .pageViewController ??=
                                                PageController(
                                                    initialPage: max(
                                                        0,
                                                        min(
                                                            valueOrDefault<int>(
                                                              (widget.chapterNumber!) -
                                                                  1,
                                                              0,
                                                            ),
                                                            pageViewFetchChaptersContentRowList
                                                                    .length -
                                                                1))),
                                            count:
                                                pageViewFetchChaptersContentRowList
                                                    .length,
                                            axisDirection: Axis.horizontal,
                                            onDotClicked: (i) async {
                                              await _model.pageViewController!
                                                  .animateToPage(
                                                i,
                                                duration:
                                                    Duration(milliseconds: 500),
                                                curve: Curves.ease,
                                              );
                                              safeSetState(() {});
                                            },
                                            effect: smooth_page_indicator
                                                .SlideEffect(
                                              spacing: 8.0,
                                              radius: 8.0,
                                              dotWidth: 8.0,
                                              dotHeight: 8.0,
                                              dotColor:
                                                  FlutterFlowTheme.of(context)
                                                      .accent1,
                                              activeDotColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              paintStyle: PaintingStyle.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 80.0,
                      decoration: BoxDecoration(),
                      child: wrapWithModel(
                        model: _model.custAppBarModel,
                        updateCallback: () => safeSetState(() {}),
                        child: CustAppBarWidget(
                          isBookmarked: isBookmarked,
                          onBookmarkTap: () => toggleBookmark(currentChapterId),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0x00FEFEFF),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            24.0, 0.0, 24.0, 24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${(((currentIndex + _currentScrollFraction) / pageViewFetchChaptersContentRowList.length) * 100).toInt()}% read',
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            font: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 11.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            lineHeight: 1.45,
                                          ),
                                    ),
                                    Text(
                                      '${currentIndex + 1} of ${pageViewFetchChaptersContentRowList.length}',
                                      style: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            font: GoogleFonts.roboto(
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelSmall
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 11.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            lineHeight: 1.45,
                                          ),
                                    ),
                                  ],
                                ),
                                LinearPercentIndicator(
                                  percent: ((currentIndex + _currentScrollFraction) / pageViewFetchChaptersContentRowList.length).clamp(0.0, 1.0),
                                  lineHeight: 2.0,
                                  animation: false,
                                  animateFromLastPercent: true,
                                  progressColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).alternate,
                                  barRadius: Radius.circular(1.0),
                                  padding: EdgeInsets.zero,
                                ),
                              ].divide(SizedBox(height: 4.0)),
                            ),
                            if (!_model.utilityFlag)
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFFEFEFF),
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
                                  borderRadius: BorderRadius.circular(32.0),
                                  border: Border.all(
                                    color: Color(0xFFE0E0E8),
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            wrapWithModel(
                                              model: _model.controlChipModel1,
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              child: ControlChipWidget(
                                                selected: true,
                                                label: 'Serif',
                                              ),
                                            ),
                                            wrapWithModel(
                                              model: _model.controlChipModel2,
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              child: ControlChipWidget(
                                                selected: false,
                                                label: 'Sans',
                                              ),
                                            ),
                                            wrapWithModel(
                                              model: _model.controlChipModel3,
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              child: ControlChipWidget(
                                                selected: false,
                                                label: 'Mono',
                                              ),
                                            ),
                                            wrapWithModel(
                                              model: _model.controlChipModel4,
                                              updateCallback: () =>
                                                  safeSetState(() {}),
                                              child: ControlChipWidget(
                                                selected: false,
                                                label: 'Classic',
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 8.0)),
                                        ),
                                      ),
                                      Divider(
                                        thickness: 0.5,
                                        color: FlutterFlowTheme.of(context)
                                            .alternate,
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              wrapWithModel(
                                                model:
                                                    _model.fontSizeButtonModel1,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: FontSizeButtonWidget(
                                                  icon: 'text_fields_rounded',
                                                  size: 16.0,
                                                ),
                                              ),
                                              wrapWithModel(
                                                model:
                                                    _model.fontSizeButtonModel2,
                                                updateCallback: () =>
                                                    safeSetState(() {}),
                                                child: FontSizeButtonWidget(
                                                  icon: 'text_fields_rounded',
                                                  size: 24.0,
                                                ),
                                              ),
                                            ].divide(SizedBox(width: 8.0)),
                                          ),
                                          Container(
                                            child: Padding(
                                              padding: EdgeInsets.all(4.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: 32.0,
                                                    height: 32.0,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9999.0),
                                                      border: Border.all(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32.0,
                                                    height: 32.0,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFF5E6D3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9999.0),
                                                      border: Border.all(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32.0,
                                                    height: 32.0,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFF1A1A1A),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              9999.0),
                                                      border: Border.all(
                                                        color:
                                                            Color(0xFF333333),
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                  ),
                                                ].divide(SizedBox(width: 4.0)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ].divide(SizedBox(height: 16.0)),
                                  ),
                                ),
                              ),
                            if (!_model.utilityFlag)
                              FFButtonWidget(
                                onPressed: () {
                                  print('Button pressed ...');
                                },
                                text: 'Power Search in Chapter',
                                icon: Icon(
                                  Icons.search_rounded,
                                  size: 15.0,
                                ),
                                options: FFButtonOptions(
                                  width: double.infinity,
                                  height: 44.0,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  iconColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  textStyle: GoogleFonts.roboto(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.0,
                                  ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color: Color(0xFFE0E0E8),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(24.0),
                                ),
                              ),
                          ].divide(SizedBox(height: 16.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
