import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bookmark_tab_model.dart';
export 'bookmark_tab_model.dart';

class BookmarkTabWidget extends StatefulWidget {
  const BookmarkTabWidget({
    super.key,
    this.selected,
    this.label,
  });

  final bool? selected;
  final String? label;

  @override
  State<BookmarkTabWidget> createState() => _BookmarkTabWidgetState();
}

class _BookmarkTabWidgetState extends State<BookmarkTabWidget> {
  late BookmarkTabModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BookmarkTabModel());
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
        color: widget.selected!
            ? FlutterFlowTheme.of(context).secondaryBackground
            : Colors.transparent,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: widget.selected!
              ? FlutterFlowTheme.of(context).alternate
              : Colors.transparent,
          width: 1.0,
        ),
      ),
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          valueOrDefault<String>(
            widget.label,
            'Books',
          ),
          style: FlutterFlowTheme.of(context).labelLarge.override(
                font: GoogleFonts.roboto(
                  fontWeight: FontWeight.w600,
                  fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                ),
                color: widget.selected!
                    ? FlutterFlowTheme.of(context).primaryText
                    : FlutterFlowTheme.of(context).secondaryText,
                fontSize: 14.0,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
                fontStyle: FlutterFlowTheme.of(context).labelLarge.fontStyle,
                lineHeight: 1.43,
              ),
        ),
      ),
    );
  }
}
