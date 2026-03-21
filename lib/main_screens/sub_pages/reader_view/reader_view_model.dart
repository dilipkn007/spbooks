import '/components/control_chip_widget.dart';
import '/components/cust_app_bar_widget.dart';
import '/components/font_size_button_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'reader_view_widget.dart' show ReaderViewWidget;
import 'package:flutter/material.dart';

class ReaderViewModel extends FlutterFlowModel<ReaderViewWidget> {
  ///  Local state fields for this page.

  bool utilityFlag = true;

  double scrollProgress = 0.0;

  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Model for custAppBar component.
  late CustAppBarModel custAppBarModel;
  // Model for control_chip component.
  late ControlChipModel controlChipModel1;
  // Model for control_chip component.
  late ControlChipModel controlChipModel2;
  // Model for control_chip component.
  late ControlChipModel controlChipModel3;
  // Model for control_chip component.
  late ControlChipModel controlChipModel4;
  // Model for font_size_button component.
  late FontSizeButtonModel fontSizeButtonModel1;
  // Model for font_size_button component.
  late FontSizeButtonModel fontSizeButtonModel2;

  @override
  void initState(BuildContext context) {
    custAppBarModel = createModel(context, () => CustAppBarModel());
    controlChipModel1 = createModel(context, () => ControlChipModel());
    controlChipModel2 = createModel(context, () => ControlChipModel());
    controlChipModel3 = createModel(context, () => ControlChipModel());
    controlChipModel4 = createModel(context, () => ControlChipModel());
    fontSizeButtonModel1 = createModel(context, () => FontSizeButtonModel());
    fontSizeButtonModel2 = createModel(context, () => FontSizeButtonModel());
  }

  @override
  void dispose() {
    custAppBarModel.dispose();
    controlChipModel1.dispose();
    controlChipModel2.dispose();
    controlChipModel3.dispose();
    controlChipModel4.dispose();
    fontSizeButtonModel1.dispose();
    fontSizeButtonModel2.dispose();
  }
}
