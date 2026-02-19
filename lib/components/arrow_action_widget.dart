import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'arrow_action_model.dart';
export 'arrow_action_model.dart';

class ArrowActionWidget extends StatefulWidget {
  const ArrowActionWidget({super.key});

  @override
  State<ArrowActionWidget> createState() => _ArrowActionWidgetState();
}

class _ArrowActionWidgetState extends State<ArrowActionWidget> {
  late ArrowActionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ArrowActionModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.chevron_right_rounded,
      color: FlutterFlowTheme.of(context).tertiary,
      size: 20.0,
    );
  }
}
