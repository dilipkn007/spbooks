import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'toggle_action_model.dart';
export 'toggle_action_model.dart';

class ToggleActionWidget extends StatefulWidget {
  const ToggleActionWidget({
    super.key,
    this.value,
  });

  final String? value;

  @override
  State<ToggleActionWidget> createState() => _ToggleActionWidgetState();
}

class _ToggleActionWidgetState extends State<ToggleActionWidget> {
  late ToggleActionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ToggleActionModel());

    _model.switchValue = false;
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _model.switchValue!,
      onChanged: (newValue) async {
        safeSetState(() => _model.switchValue = newValue);
      },
      activeThumbColor: FlutterFlowTheme.of(context).primary,
      activeTrackColor: FlutterFlowTheme.of(context).accent1,
      inactiveTrackColor: FlutterFlowTheme.of(context).secondaryBackground,
      inactiveThumbColor: FlutterFlowTheme.of(context).secondaryText,
    );
  }
}
