import '/backend/sqlite/sqlite_manager.dart';
import '/components/book_card_widget.dart';
import '/components/bookmark_item_widget.dart';
import '/components/category_chip_widget.dart';
import '/components/section_header_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'books_library_model.dart';
export 'books_library_model.dart';

class BooksLibraryWidget extends StatefulWidget {
  const BooksLibraryWidget({super.key});

  static String routeName = 'BooksLibrary';
  static String routePath = '/booksLibrary';

  @override
  State<BooksLibraryWidget> createState() => _BooksLibraryWidgetState();
}

class _BooksLibraryWidgetState extends State<BooksLibraryWidget> {
  late BooksLibraryModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BooksLibraryModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: Color(0xFFEE8B60),
        automaticallyImplyLeading: false,
        title: Text(
          'Srila Prabhupada Books',
          textAlign: TextAlign.start,
          style: FlutterFlowTheme.of(context).headlineMedium.override(
                font: GoogleFonts.interTight(
                  fontWeight:
                      FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                  fontStyle:
                      FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                ),
                color: FlutterFlowTheme.of(context).primaryBackground,
                fontSize: 22.0,
                letterSpacing: 0.0,
                fontWeight:
                    FlutterFlowTheme.of(context).headlineMedium.fontWeight,
                fontStyle:
                    FlutterFlowTheme.of(context).headlineMedium.fontStyle,
              ),
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                context.pushNamed(SettingsWidget.routeName);
              },
              child: Icon(
                Icons.settings_sharp,
                color: Colors.white,
                size: 30.0,
              ),
            ),
          ),
        ],
        centerTitle: false,
        elevation: 2.0,
      ),
      body: SafeArea(
        top: true,
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              primary: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        wrapWithModel(
                          model: _model.categoryChipModel1,
                          updateCallback: () => safeSetState(() {}),
                          child: CategoryChipWidget(
                            selected: true,
                            label: 'All Books',
                          ),
                        ),
                        wrapWithModel(
                          model: _model.categoryChipModel2,
                          updateCallback: () => safeSetState(() {}),
                          child: CategoryChipWidget(
                            selected: false,
                            label: 'Beginner',
                          ),
                        ),
                        wrapWithModel(
                          model: _model.categoryChipModel3,
                          updateCallback: () => safeSetState(() {}),
                          child: CategoryChipWidget(
                            selected: false,
                            label: 'Advanced',
                          ),
                        ),
                        wrapWithModel(
                          model: _model.categoryChipModel4,
                          updateCallback: () => safeSetState(() {}),
                          child: CategoryChipWidget(
                            selected: false,
                            label: 'Intermediate',
                          ),
                        ),
                      ].divide(SizedBox(width: 16.0)),
                    ),
                  ),
                  FutureBuilder<List<FetchReadingHistoryRow>>(
                    future: SQLiteManager.instance.fetchReadingHistory(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return SizedBox.shrink();
                      }
                      final historyRow = snapshot.data!.first;
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          wrapWithModel(
                            model: _model.sectionHeaderModel1,
                            updateCallback: () => safeSetState(() {}),
                            child: SectionHeaderWidget(
                              title: 'Continue Reading',
                              action_label: 'History',
                              show_action: 'true',
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              context.pushNamed(
                                ReaderViewWidget.routeName,
                                queryParameters: {
                                  'bookId': serializeParam(historyRow.id, ParamType.int),
                                  'chapterNumber': serializeParam(historyRow.number ?? 1, ParamType.int),
                                  'parentId': serializeParam(0, ParamType.int),
                                }.withoutNulls,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2.0,
                                    color: Color(0x1A000000),
                                    offset: Offset(0.0, 1.0),
                                    spreadRadius: 0.0,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(32.0),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: Container(
                                        width: 100.0,
                                        height: 140.0,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 2.0,
                                              color: Color(0x1A000000),
                                              offset: Offset(0.0, 1.0),
                                              spreadRadius: 0.0,
                                            )
                                          ],
                                          borderRadius: BorderRadius.circular(16.0),
                                        ),
                                        child: CachedNetworkImage(
                                          fadeInDuration: Duration(milliseconds: 0),
                                          fadeOutDuration: Duration(milliseconds: 0),
                                          imageUrl: historyRow.cover ?? '',
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
                                          Text(
                                            historyRow.title ?? 'Unknown Title',
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
                                          ),
                                          Text(
                                            historyRow.author != null ? 'By ${historyRow.author}' : 'Unknown Author',
                                            style: FlutterFlowTheme.of(context)
                                                .bodySmall
                                                .override(
                                                  font: GoogleFonts.roboto(
                                                    fontWeight: FontWeight.normal,
                                                    fontStyle: FlutterFlowTheme.of(context)
                                                        .bodySmall
                                                        .fontStyle,
                                                  ),
                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                  fontSize: 12.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.normal,
                                                  fontStyle: FlutterFlowTheme.of(context)
                                                      .bodySmall
                                                      .fontStyle,
                                                  lineHeight: 1.33,
                                                ),
                                          ),
                                          Container(
                                            height: 8.0,
                                          ),
                                          Column(
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
                                                    '${((historyRow.percent ?? 0.0) * 100).toInt()}% Read',
                                                    style: FlutterFlowTheme.of(context)
                                                        .labelSmall
                                                        .override(
                                                          font: GoogleFonts.roboto(
                                                            fontWeight: FontWeight.w600,
                                                            fontStyle: FlutterFlowTheme.of(context)
                                                                .labelSmall
                                                                .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                          fontSize: 11.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight: FontWeight.w600,
                                                          fontStyle: FlutterFlowTheme.of(context)
                                                              .labelSmall
                                                              .fontStyle,
                                                          lineHeight: 1.45,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                              LinearPercentIndicator(
                                                percent: (historyRow.percent ?? 0.0).clamp(0.0, 1.0),
                                                lineHeight: 8.0,
                                                animation: true,
                                                animationDuration: 1000,
                                                progressColor: Color(0xFFEE8B60),
                                                backgroundColor: FlutterFlowTheme.of(context).alternate,
                                                barRadius: Radius.circular(4.0),
                                                padding: EdgeInsets.zero,
                                              ),
                                            ].divide(SizedBox(height: 4.0)),
                                          ),
                                        ].divide(SizedBox(height: 8.0)),
                                      ),
                                    ),
                                  ].divide(SizedBox(width: 24.0)),
                                ),
                              ),
                            ),
                          ),
                        ].divide(SizedBox(height: 4.0)),
                      );
                    },
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      wrapWithModel(
                        model: _model.sectionHeaderModel2,
                        updateCallback: () => safeSetState(() {}),
                        child: SectionHeaderWidget(
                          title: 'Selected Books',
                          action_label: 'Manage',
                          show_action: 'true',
                        ),
                      ),
                      FutureBuilder<List<ReadAllBooksNamesRow>>(
                        future: SQLiteManager.instance.readAllBooksNames(),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return Center(
                              child: SizedBox(
                                width: 50.0,
                                height: 50.0,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    FlutterFlowTheme.of(context).primary,
                                  ),
                                ),
                              ),
                            );
                          }
                          final gridViewReadAllBooksNamesRowList =
                              snapshot.data!;

                          return GridView.builder(
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 1.0,
                              mainAxisSpacing: 1.0,
                              childAspectRatio: 0.77,
                            ),
                            shrinkWrap: true,
                            itemCount: gridViewReadAllBooksNamesRowList.length,
                            itemBuilder: (context, gridViewIndex) {
                              final gridViewReadAllBooksNamesRow =
                                  gridViewReadAllBooksNamesRowList[
                                      gridViewIndex];
                              return Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                      ChapterListWidget.routeName,
                                      queryParameters: {
                                        'bookId': serializeParam(
                                          gridViewReadAllBooksNamesRow.id,
                                          ParamType.int,
                                        ),
                                        'parentId': serializeParam(
                                          0,
                                          ParamType.int,
                                        ),
                                      }.withoutNulls,
                                    );
                                  },
                                  child: wrapWithModel(
                                    model: _model.bookCardModels.getModel(
                                      gridViewReadAllBooksNamesRow.id!
                                          .toString(),
                                      gridViewIndex,
                                    ),
                                    updateCallback: () => safeSetState(() {}),
                                    child: BookCardWidget(
                                      key: Key(
                                        'Key2w3_${gridViewReadAllBooksNamesRow.id!.toString()}',
                                      ),
                                      title: valueOrDefault<String>(
                                        gridViewReadAllBooksNamesRow.title,
                                        'null',
                                      ),
                                      coverImage:
                                          gridViewReadAllBooksNamesRow.cover!,
                                      bookId: gridViewReadAllBooksNamesRow.id!,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ].divide(SizedBox(height: 4.0)),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      wrapWithModel(
                        model: _model.sectionHeaderModel3,
                        updateCallback: () => safeSetState(() {}),
                        child: SectionHeaderWidget(
                          title: 'Recent Bookmarks',
                          action_label: 'View All',
                          show_action: 'true',
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          wrapWithModel(
                            model: _model.bookmarkItemModel1,
                            updateCallback: () => safeSetState(() {}),
                            child: BookmarkItemWidget(
                              note: 'The concept of \'Deep Work\'',
                              book: 'Deep Work',
                              page: '42',
                            ),
                          ),
                          wrapWithModel(
                            model: _model.bookmarkItemModel2,
                            updateCallback: () => safeSetState(() {}),
                            child: BookmarkItemWidget(
                              note: 'Paul\'s vision in the desert',
                              book: 'Dune',
                              page: '189',
                            ),
                          ),
                          wrapWithModel(
                            model: _model.bookmarkItemModel3,
                            updateCallback: () => safeSetState(() {}),
                            child: BookmarkItemWidget(
                              note: 'Morning routine summary',
                              book: 'Atomic Habits',
                              page: '12',
                            ),
                          ),
                        ].divide(SizedBox(height: 16.0)),
                      ),
                    ].divide(SizedBox(height: 24.0)),
                  ),
                ].divide(SizedBox(height: 12.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
