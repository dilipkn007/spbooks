import '/components/action_chip_widget.dart';
import '/components/stat_item_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'book_details_widget.dart' show BookDetailsWidget;
import 'package:flutter/material.dart';

class BookDetailsModel extends FlutterFlowModel<BookDetailsWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for stat_item component.
  late StatItemModel statItemModel1;
  // Model for stat_item component.
  late StatItemModel statItemModel2;
  // Model for stat_item component.
  late StatItemModel statItemModel3;
  // Model for action_chip component.
  late ActionChipModel actionChipModel1;
  // Model for action_chip component.
  late ActionChipModel actionChipModel2;
  // Model for action_chip component.
  late ActionChipModel actionChipModel3;

  @override
  void initState(BuildContext context) {
    statItemModel1 = createModel(context, () => StatItemModel());
    statItemModel2 = createModel(context, () => StatItemModel());
    statItemModel3 = createModel(context, () => StatItemModel());
    actionChipModel1 = createModel(context, () => ActionChipModel());
    actionChipModel2 = createModel(context, () => ActionChipModel());
    actionChipModel3 = createModel(context, () => ActionChipModel());
  }

  @override
  void dispose() {
    statItemModel1.dispose();
    statItemModel2.dispose();
    statItemModel3.dispose();
    actionChipModel1.dispose();
    actionChipModel2.dispose();
    actionChipModel3.dispose();
  }
}
