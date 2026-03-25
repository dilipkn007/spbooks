import '/components/book_card2_widget.dart';
import '/components/page_card2_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/backend/sqlite/sqlite_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bookmarks_copy_model.dart';
export 'bookmarks_copy_model.dart';

class BookmarksCopyWidget extends StatefulWidget {
  const BookmarksCopyWidget({super.key});

  static String routeName = 'BookmarksCopy';
  static String routePath = '/bookmarksCopy';

  @override
  State<BookmarksCopyWidget> createState() => _BookmarksCopyWidgetState();
}

class _BookmarksCopyWidgetState extends State<BookmarksCopyWidget>
    with TickerProviderStateMixin {
  late BookmarksCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BookmarksCopyModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          print('FloatingActionButton pressed ...');
        },
        backgroundColor: Color(0xFF4A6741),
        icon: Icon(
          Icons.add_rounded,
          color: Colors.white,
        ),
        label: Text(
          'New Mark',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        top: true,
        child: Container(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              primary: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Library',
                            style: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .fontStyle,
                                  ),
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 28.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w800,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .fontStyle,
                                  lineHeight: 1.29,
                                ),
                          ),
                          Text(
                            'Saved books and highlights',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                  lineHeight: 1.43,
                                ),
                          ),
                        ].divide(SizedBox(height: 4.0)),
                      ),
                      Container(
                        width: 40.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Color(0xFF4A6741),
                          shape: BoxShape.circle,
                        ),
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Text(
                          'JD',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(24.0),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_rounded,
                            color: FlutterFlowTheme.of(context).tertiary,
                            size: 20.0,
                          ),
                          Text(
                            'Search your bookmarks...',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  font: GoogleFonts.roboto(
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                                  color: FlutterFlowTheme.of(context).tertiary,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .fontStyle,
                                  lineHeight: 1.43,
                                ),
                          ),
                        ].divide(SizedBox(width: 16.0)),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF0F0F0),
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                    child: Container(
                      height: 584.51,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment(0.0, 0),
                            child: TabBar(
                              labelColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              unselectedLabelColor:
                                  FlutterFlowTheme.of(context).secondaryText,
                              labelStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.interTight(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                              unselectedLabelStyle: FlutterFlowTheme.of(context)
                                  .titleMedium
                                  .override(
                                    font: GoogleFonts.interTight(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .fontStyle,
                                  ),
                              indicatorColor:
                                  FlutterFlowTheme.of(context).tertiary,
                              tabs: [
                                Tab(
                                  text: 'Books',
                                ),
                                Tab(
                                  text: 'Page Marks',
                                ),
                              ],
                              controller: _model.tabBarController,
                              onTap: (i) async {
                                [() async {}, () async {}][i]();
                              },
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: _model.tabBarController,
                              children: [
                                FutureBuilder<List<FetchBookmarkedBooksRow>>(
                                  future: SQLiteManager.instance.fetchBookmarkedBooks(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Center(child: CircularProgressIndicator(color: FlutterFlowTheme.of(context).primary));
                                    }
                                    final books = snapshot.data!;
                                    if (books.isEmpty) {
                                      return Center(child: Text('No bookmarked books.'));
                                    }
                                    return SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: books.map((book) {
                                          return BookCard2Widget(
                                            img: book.cover ?? 'book cover psychological thriller',
                                            title: book.title ?? 'Unknown',
                                            author: book.author ?? 'Unknown',
                                            category: book.language ?? 'Unknown',
                                            bookId: book.id,
                                          );
                                        }).toList()
                                          .divide(SizedBox(height: 4.0))
                                          .addToStart(SizedBox(height: 4.0))
                                          .addToEnd(SizedBox(height: 100.0)),
                                      ),
                                    );
                                  },
                                ),
                                FutureBuilder<List<FetchBookmarkedPagesRow>>(
                                  future: SQLiteManager.instance.fetchBookmarkedPages(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Center(child: CircularProgressIndicator(color: FlutterFlowTheme.of(context).primary));
                                    }
                                    final pages = snapshot.data!;
                                    if (pages.isEmpty) {
                                      return Center(child: Text('No bookmarked pages.'));
                                    }
                                    return SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: pages.map((pageData) {
                                          return PageCard2Widget(
                                            title: '${pageData.number ?? ''}. ${pageData.title ?? ''}',
                                            content: pageData.content ?? '',
                                            bookId: pageData.bookId,
                                            chapterId: pageData.id,
                                          );
                                        }).toList()
                                          .divide(SizedBox(height: 4.0))
                                          .addToStart(SizedBox(height: 4.0))
                                          .addToEnd(SizedBox(height: 100.0)),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ].divide(SizedBox(height: 24.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
