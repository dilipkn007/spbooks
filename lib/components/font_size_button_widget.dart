import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'font_size_button_model.dart';
export 'font_size_button_model.dart';

class FontSizeButtonWidget extends StatefulWidget {
  const FontSizeButtonWidget({
    super.key,
    this.icon,
    this.size,
  });

  final String? icon;
  final double? size;

  @override
  State<FontSizeButtonWidget> createState() => _FontSizeButtonWidgetState();
}

class _FontSizeButtonWidgetState extends State<FontSizeButtonWidget> {
  late FontSizeButtonModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FontSizeButtonModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1.0,
        ),
      ),
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Icon(
        Icons.text_fields_rounded,
        color: FlutterFlowTheme.of(context).primaryText,
        size: valueOrDefault<double>(
          widget.size,
          16.0,
        ),
      ),
    );
  }
}
