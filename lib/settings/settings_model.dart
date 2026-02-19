import '/components/arrow_action_widget.dart';
import '/components/toggle_action_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'settings_widget.dart' show SettingsWidget;
import 'package:flutter/material.dart';

class SettingsModel extends FlutterFlowModel<SettingsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for toggle_action component.
  late ToggleActionModel toggleActionModel1;
  // Model for arrow_action component.
  late ArrowActionModel arrowActionModel1;
  // Model for arrow_action component.
  late ArrowActionModel arrowActionModel2;
  // Model for toggle_action component.
  late ToggleActionModel toggleActionModel2;
  // Model for arrow_action component.
  late ArrowActionModel arrowActionModel3;
  // Model for arrow_action component.
  late ArrowActionModel arrowActionModel4;

  @override
  void initState(BuildContext context) {
    toggleActionModel1 = createModel(context, () => ToggleActionModel());
    arrowActionModel1 = createModel(context, () => ArrowActionModel());
    arrowActionModel2 = createModel(context, () => ArrowActionModel());
    toggleActionModel2 = createModel(context, () => ToggleActionModel());
    arrowActionModel3 = createModel(context, () => ArrowActionModel());
    arrowActionModel4 = createModel(context, () => ArrowActionModel());
  }

  @override
  void dispose() {
    toggleActionModel1.dispose();
    arrowActionModel1.dispose();
    arrowActionModel2.dispose();
    toggleActionModel2.dispose();
    arrowActionModel3.dispose();
    arrowActionModel4.dispose();
  }
}
