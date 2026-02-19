import '/components/deep_search_result_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'power_search_widget.dart' show PowerSearchWidget;
import 'package:flutter/material.dart';

class PowerSearchModel extends FlutterFlowModel<PowerSearchWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // State field(s) for Switch widget.
  bool? switchValue;
  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;
  // Model for deep_search_result component.
  late DeepSearchResultModel deepSearchResultModel1;
  // Model for deep_search_result component.
  late DeepSearchResultModel deepSearchResultModel2;
  // Model for deep_search_result component.
  late DeepSearchResultModel deepSearchResultModel3;

  @override
  void initState(BuildContext context) {
    deepSearchResultModel1 =
        createModel(context, () => DeepSearchResultModel());
    deepSearchResultModel2 =
        createModel(context, () => DeepSearchResultModel());
    deepSearchResultModel3 =
        createModel(context, () => DeepSearchResultModel());
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();

    deepSearchResultModel1.dispose();
    deepSearchResultModel2.dispose();
    deepSearchResultModel3.dispose();
  }
}
