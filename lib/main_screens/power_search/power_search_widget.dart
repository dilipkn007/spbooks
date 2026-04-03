import '/backend/sqlite/sqlite_manager.dart';
import '/components/deep_search_result_widget.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'power_search_model.dart';
export 'power_search_model.dart';

class PowerSearchWidget extends StatefulWidget {
  const PowerSearchWidget({
    super.key,
    int? bookId,
    this.chapter,
  }) : this.bookId = bookId ?? -1;

  final int bookId;
  final int? chapter;

  static String routeName = 'PowerSearch';
  static String routePath = '/powerSearch';

  @override
  State<PowerSearchWidget> createState() => _PowerSearchWidgetState();
}

class _PowerSearchWidgetState extends State<PowerSearchWidget> {
  late PowerSearchModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Cached future to avoid re-running on every rebuild
  Future<List<SearchContentRow>>? _searchFuture;
  Future<List<ReadAllBooksNamesRow>>? _booksFuture;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PowerSearchModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
    _model.switchValue = true;

    // pre-load books list once
    _booksFuture = SQLiteManager.instance.readAllBooksNames();

    // Initial search with empty string to show no results
    _triggerSearch();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _triggerSearch() {
    setState(() {
      _searchFuture = SQLiteManager.instance.searchContent(
        bookId: _model.book,
        chapterId: _model.chapter,
        content: _model.search.isEmpty ? null : _model.search,
      );
    });
  }

  /// Extracts a text snippet around the search keyword for display.
  String _extractSnippet(String content, String? keyword,
      {int contextChars = 80}) {
    if (keyword == null || keyword.isEmpty) {
      return content.length > contextChars * 2
          ? '${content.substring(0, contextChars * 2)}...'
          : content;
    }
    final lower = content.toLowerCase();
    final idx = lower.indexOf(keyword.toLowerCase());
    if (idx == -1) return content.length > 160 ? '${content.substring(0, 160)}...' : content;
    final start = (idx - contextChars).clamp(0, content.length);
    final end = (idx + keyword.length + contextChars).clamp(0, content.length);
    return content.substring(start, end);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ── Header ────────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Power Search',
                        style: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .override(
                              font: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 28.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                              lineHeight: 1.29,
                            ),
                      ),
                      Text(
                        'Search across books',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.roboto(
                                fontWeight: FontWeight.normal,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.normal,
                              lineHeight: 1.43,
                            ),
                      ),
                    ].divide(const SizedBox(height: 4.0)),
                  ),
                  Container(
                    width: 44.0,
                    height: 44.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(9999.0),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 1.0,
                      ),
                    ),
                    alignment: AlignmentDirectional.center,
                    child: Icon(
                      Icons.auto_awesome_rounded,
                      color: FlutterFlowTheme.of(context).primary,
                      size: 20.0,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24.0),

              // ── Search bar ────────────────────────────────────────
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 2.0,
                          color: Color(0x1A000000),
                          offset: Offset(0.0, 1.0),
                          spreadRadius: 0.0,
                        )
                      ],
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 1.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          24.0, 12.0, 24.0, 12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_rounded,
                            color: FlutterFlowTheme.of(context).primary,
                            size: 24.0,
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: TextFormField(
                              controller: _model.textController,
                              focusNode: _model.textFieldFocusNode,
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.textController',
                                const Duration(milliseconds: 400),
                                () {
                                  _model.search = _model.textController!.text.trim();
                                  // Reset chapter filter when search text changes
                                  _triggerSearch();
                                },
                              ),
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'Search keywords inside books...',
                                hintStyle: TextStyle(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText
                                      .withOpacity(0.6),
                                  fontSize: 14.0,
                                ),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                              style: TextStyle(
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 14.0,
                              ),
                              maxLines: 1,
                              validator: _model.textControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          // Clear button
                          if (_model.search.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                _model.textController!.clear();
                                _model.search = '';
                                _triggerSearch();
                              },
                              child: Icon(
                                Icons.close_rounded,
                                color: FlutterFlowTheme.of(context).secondaryText,
                                size: 18.0,
                              ),
                            )
                          else
                            Icon(
                              Icons.settings_voice_rounded,
                              color: FlutterFlowTheme.of(context).secondaryText,
                              size: 20.0,
                            ),
                        ],
                      ),
                    ),
                  ),

                  // ── Deep search toggle ──
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8.0, 0, 8.0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Switch(
                              value: _model.switchValue!,
                              onChanged: (newValue) {
                                setState(() => _model.switchValue = newValue);
                                _model.deepSearchFlag = newValue;
                              },
                              activeThumbColor:
                                  FlutterFlowTheme.of(context).primary,
                              activeTrackColor:
                                  FlutterFlowTheme.of(context).accent1,
                              inactiveTrackColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              inactiveThumbColor:
                                  FlutterFlowTheme.of(context).secondaryText,
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              'Deep Content Search',
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    font: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w500,
                                    ),
                                    color:
                                        FlutterFlowTheme.of(context).primaryText,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                    lineHeight: 1.33,
                                  ),
                            ),
                          ],
                        ),
                        FlutterFlowIconButton(
                          buttonSize: 40.0,
                          icon: Icon(
                            Icons.info_outline_rounded,
                            color: FlutterFlowTheme.of(context).tertiary,
                            size: 18.0,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text('Deep Content Search'),
                                content: const Text(
                                  'When enabled, your search looks inside the full text of every chapter across all books.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Got it'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ].divide(const SizedBox(height: 16.0)),
              ),

              const SizedBox(height: 24.0),

              // ── Book & Chapter filters ─────────────────────────────
              Row(
                children: [
                  // Book filter (dynamically loaded)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Book',
                          style: FlutterFlowTheme.of(context)
                              .labelSmall
                              .override(
                                font: GoogleFonts.roboto(fontWeight: FontWeight.w500),
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                fontSize: 11.0,
                                fontWeight: FontWeight.w500,
                                lineHeight: 1.45,
                              ),
                        ),
                        const SizedBox(height: 8.0),
                        FutureBuilder<List<ReadAllBooksNamesRow>>(
                          future: _booksFuture,
                          builder: (context, snapshot) {
                            final books = snapshot.data ?? [];
                            final options = [-1, ...books.map((b) => b.id ?? -1)];
                            final labels = [
                              'All Books',
                              ...books.map((b) => b.title ?? '—'),
                            ];
                            return Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, 0),
                              child: FlutterFlowDropDown<int>(
                                controller: _model.dropDownValueController1 ??=
                                    FormFieldController<int>(
                                  _model.dropDownValue1 ??= -1,
                                ),
                                options: List<int>.from(options),
                                optionLabels: labels,
                                onChanged: (val) {
                                  setState(() {
                                    _model.dropDownValue1 = val;
                                    _model.book = val;
                                    // Reset chapter when book changes
                                    _model.dropDownValue2 = -1;
                                    _model.chapter = -1;
                                    _model.dropDownValueController2
                                        ?.value = -1;
                                  });
                                  _triggerSearch();
                                },
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                      ),
                                      letterSpacing: 0.0,
                                    ),
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color:
                                      FlutterFlowTheme.of(context).secondaryText,
                                  size: 24.0,
                                ),
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                elevation: 2.0,
                                borderColor:
                                    FlutterFlowTheme.of(context).alternate,
                                borderWidth: 1.0,
                                borderRadius: 16.0,
                                margin: const EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 12.0, 0.0),
                                hidesUnderline: true,
                                isOverButton: false,
                                isSearchable: true,
                                isMultiSelect: false,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 16.0),

                  // Chapter filter
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chapter',
                          style: FlutterFlowTheme.of(context)
                              .labelSmall
                              .override(
                                font: GoogleFonts.roboto(fontWeight: FontWeight.w500),
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                fontSize: 11.0,
                                fontWeight: FontWeight.w500,
                                lineHeight: 1.45,
                              ),
                        ),
                        const SizedBox(height: 8.0),
                        FutureBuilder<List<FetchChaptersRow>>(
                          future: _model.book != null && _model.book != -1
                              ? SQLiteManager.instance.fetchChapters(
                                  bookId: _model.book!,
                                  parentId: 0,
                                )
                              : Future.value([]),
                          builder: (context, snapshot) {
                            if (_model.book == -1) {
                              return FlutterFlowDropDown<int>(
                                controller: _model.dropDownValueController2 ??=
                                    FormFieldController<int>(-1),
                                options: const [-1],
                                optionLabels: const ['All Chapters'],
                                onChanged: (_) {},
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.inter(),
                                      letterSpacing: 0.0,
                                    ),
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color:
                                      FlutterFlowTheme.of(context).secondaryText,
                                  size: 24.0,
                                ),
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                elevation: 2.0,
                                borderColor:
                                    FlutterFlowTheme.of(context).alternate,
                                borderWidth: 1.0,
                                borderRadius: 16.0,
                                margin: const EdgeInsetsDirectional.fromSTEB(
                                    12.0, 0.0, 12.0, 0.0),
                                hidesUnderline: true,
                                disabled: true,
                                isOverButton: false,
                                isSearchable: false,
                                isMultiSelect: false,
                              );
                            }
                            if (!snapshot.hasData) {
                              return const SizedBox(
                                height: 48,
                                child: Center(
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  ),
                                ),
                              );
                            }
                            final chapters = snapshot.data!;
                            final opts = [-1, ...chapters.map((e) => e.number)];
                            final lbls = [
                              'All Chapters',
                              ...chapters.map((e) => e.title),
                            ];
                            return FlutterFlowDropDown<int>(
                              controller: _model.dropDownValueController2 ??=
                                  FormFieldController<int>(
                                _model.dropDownValue2 ??= -1,
                              ),
                              options: List<int>.from(opts),
                              optionLabels: lbls,
                              onChanged: (val) {
                                setState(() {
                                  _model.dropDownValue2 = val;
                                  _model.chapter = val;
                                });
                                _triggerSearch();
                              },
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                    ),
                                    letterSpacing: 0.0,
                                  ),
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 24.0,
                              ),
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              elevation: 2.0,
                              borderColor: FlutterFlowTheme.of(context).alternate,
                              borderWidth: 1.0,
                              borderRadius: 16.0,
                              margin: const EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 12.0, 0.0),
                              hidesUnderline: true,
                              isOverButton: false,
                              isSearchable: false,
                              isMultiSelect: false,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24.0),

              // ── Results section ────────────────────────────────────
              Expanded(
                child: FutureBuilder<List<SearchContentRow>>(
                  future: _searchFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FlutterFlowTheme.of(context).primary,
                          ),
                        ),
                      );
                    }

                    final results = snapshot.data ?? [];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Results header row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Content Matches',
                              style: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    font: GoogleFonts.roboto(
                                        fontWeight: FontWeight.w600),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                    lineHeight: 1.43,
                                  ),
                            ),
                            if (_model.search.isNotEmpty)
                              Text(
                                '${results.length} ${results.length == 1 ? 'result' : 'results'}',
                                style: FlutterFlowTheme.of(context)
                                    .labelSmall
                                    .override(
                                      font: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w500),
                                      color:
                                          FlutterFlowTheme.of(context).tertiary,
                                      fontSize: 11.0,
                                      fontWeight: FontWeight.w500,
                                      lineHeight: 1.45,
                                    ),
                              ),
                          ],
                        ),

                        const SizedBox(height: 16.0),

                        // Empty states
                        if (_model.search.isEmpty)
                          Expanded(
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.search_rounded,
                                    size: 56,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText
                                        .withOpacity(0.4),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Start typing to search',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.roboto(),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                        ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Filter by book and chapter for precise results',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .override(
                                          font: GoogleFonts.roboto(),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText
                                              .withOpacity(0.6),
                                          fontSize: 12,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else if (results.isEmpty)
                          Expanded(
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.search_off_rounded,
                                    size: 56,
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryText
                                        .withOpacity(0.4),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No results found',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.roboto(),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                        ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Try different keywords or remove filters',
                                    style: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .override(
                                          font: GoogleFonts.roboto(),
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText
                                              .withOpacity(0.6),
                                          fontSize: 12,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else
                          // Result list
                          Expanded(
                            child: ListView.builder(
                              itemCount: results.length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                final row = results[index];
                                final content = row.content ?? '';
                                final keyword = _model.search;

                                // Extract a meaningful snippet around the keyword
                                final snippet = _extractSnippet(content, keyword);
                                final kwIdx = snippet
                                    .toLowerCase()
                                    .indexOf(keyword.toLowerCase());

                                String snippetBefore = '';
                                String matchText = '';
                                String snippetAfter = '';

                                if (kwIdx != -1) {
                                  snippetBefore = snippet.substring(0, kwIdx);
                                  matchText = snippet.substring(
                                      kwIdx, kwIdx + keyword.length);
                                  snippetAfter =
                                      snippet.substring(kwIdx + keyword.length);
                                } else {
                                  snippetBefore = snippet;
                                }

                                return InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () {
                                    context.pushNamed(
                                      ReaderViewWidget.routeName,
                                      queryParameters: {
                                        'chapterNumber': serializeParam(
                                          row.number,
                                          ParamType.int,
                                        ),
                                        'bookId': serializeParam(
                                          row.bookId,
                                          ParamType.int,
                                        ),
                                        'parentId': serializeParam(
                                          row.parent,
                                          ParamType.int,
                                        ),
                                        'searchKeyword': serializeParam(
                                          _model.search.isNotEmpty ? _model.search : null,
                                          ParamType.String,
                                        ),
                                      }.withoutNulls,
                                    );
                                  },
                                  child: DeepSearchResultWidget(
                                    key: Key('result_${index}_${row.id}'),
                                    title: row.title,
                                    page_num: row.number?.toString(),
                                    author: '',
                                    snippet_start: snippetBefore,
                                    match_text: matchText,
                                    snippet_end: snippetAfter,
                                    chapterNumber: row.number?.toString(),
                                    image: row.bookCover ?? '',
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
