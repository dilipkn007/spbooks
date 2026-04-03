import '/backend/sqlite/sqlite_manager.dart';
import '/components/cust_app_bar_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'sub_chapter_list_model.dart';
export 'sub_chapter_list_model.dart';

class SubChapterListWidget extends StatefulWidget {
  const SubChapterListWidget({
    super.key,
    required this.bookId,
    int? parentId,
  }) : this.parentId = parentId ?? 0;

  final int? bookId;
  final int parentId;

  static String routeName = 'SubChapterList';
  static String routePath = '/subChapterList';

  @override
  State<SubChapterListWidget> createState() => _SubChapterListWidgetState();
}

class _SubChapterListWidgetState extends State<SubChapterListWidget> {
  late SubChapterListModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SubChapterListModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              wrapWithModel(
                model: _model.custAppBarModel,
                updateCallback: () => safeSetState(() {}),
                child: CustAppBarWidget(),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(24.0, 10.0, 24.0, 0.0),
                  child: FutureBuilder<List<FetchSubChaptersRow>>(
                    future: SQLiteManager.instance.fetchSubChapters(
                      chapterId: widget.parentId,
                      bookId: widget.bookId,
                    ),
                    builder: (context, snapshot) {
                      // Customize what your widget looks like when it's loading.
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            width: 40.0,
                            height: 40.0,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                FlutterFlowTheme.of(context).tertiary,
                              ),
                            ),
                          ),
                        );
                      }
                      final listViewFetchSubChaptersRowList = snapshot.data!;

                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: listViewFetchSubChaptersRowList.length,
                        itemBuilder: (context, listViewIndex) {
                          final listViewFetchSubChaptersRow =
                              listViewFetchSubChaptersRowList[listViewIndex];
                          return Container(
                            decoration: BoxDecoration(
                              color:
                                  FlutterFlowTheme.of(context).primaryBackground,
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 0.0, 10.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      _model.subChapters = await SQLiteManager
                                          .instance
                                          .fetchSubChapters(
                                        chapterId: listViewFetchSubChaptersRow.id,
                                        bookId: widget.bookId,
                                      );
                                      if (_model.subChapters!.length > 0
                                          ? true
                                          : false) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Testing sub page screen',
                                              style: TextStyle(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                              ),
                                            ),
                                            duration:
                                                Duration(milliseconds: 4000),
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondary,
                                          ),
                                        );

                                        context.pushNamed(
                                          SubChapterListWidget.routeName,
                                          queryParameters: {
                                            'bookId': serializeParam(
                                              _model.subChapters
                                                  ?.elementAtOrNull(0)
                                                  ?.bookId,
                                              ParamType.int,
                                            ),
                                            'parentId': serializeParam(
                                              listViewFetchSubChaptersRow.id,
                                              ParamType.int,
                                            ),
                                          }.withoutNulls,
                                        );
                                      } else {
                                        context.pushNamed(
                                          ReaderViewWidget.routeName,
                                          queryParameters: {
                                            'chapterNumber': serializeParam(
                                              listViewFetchSubChaptersRow.number,
                                              ParamType.int,
                                            ),
                                            'content': serializeParam(
                                              listViewFetchSubChaptersRow.content,
                                              ParamType.String,
                                            ),
                                            'title': serializeParam(
                                              listViewFetchSubChaptersRow.title,
                                              ParamType.String,
                                            ),
                                            'bookId': serializeParam(
                                              listViewFetchSubChaptersRow.bookId,
                                              ParamType.int,
                                            ),
                                            'parentId': serializeParam(
                                              widget.parentId,
                                              ParamType.int,
                                            ),
                                          }.withoutNulls,
                                        );
                                      }

                                      safeSetState(() {});
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              10.0, 0.0, 10.0, 0.0),
                                          child: Text(
                                            formatNumber(
                                              listViewFetchSubChaptersRow.number,
                                              formatType: FormatType.custom,
                                              format: '##\'.\'',
                                              locale: 'en_US',
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            listViewFetchSubChaptersRow.title,
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                            overflow: TextOverflow.fade,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 10.0, 0.0),
                                  child: Container(
                                    width: double.infinity,
                                    height: 2.0,
                                    decoration: BoxDecoration(
                                      color: Color(0x1514181B),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
