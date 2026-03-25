import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'cust_app_bar_model.dart';
export 'cust_app_bar_model.dart';

class CustAppBarWidget extends StatefulWidget {
  const CustAppBarWidget({
    super.key,
    this.isBookmarked = false,
    this.onBookmarkTap,
  });
  
  final bool isBookmarked;
  final Future<void> Function()? onBookmarkTap;

  @override
  State<CustAppBarWidget> createState() => _CustAppBarWidgetState();
}

class _CustAppBarWidgetState extends State<CustAppBarWidget> {
  late CustAppBarModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CustAppBarModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 24.0, 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FlutterFlowIconButton(
            buttonSize: 40.0,
            icon: FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FlutterFlowIconButton(
                buttonSize: 40.0,
                icon: Icon(
                  widget.isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
                onPressed: () async {
                  if (widget.onBookmarkTap != null) {
                    await widget.onBookmarkTap!();
                  }
                },
              ),
              FlutterFlowIconButton(
                buttonSize: 40.0,
                icon: Icon(
                  Icons.share_rounded,
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 24.0,
                ),
                onPressed: () {
                  print('IconButton pressed ...');
                },
              ),
            ].divide(SizedBox(width: 16.0)),
          ),
        ],
      ),
    );
  }
}
