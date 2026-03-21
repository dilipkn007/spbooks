import '/backend/sqlite/sqlite_manager.dart';
import '/components/cust_app_bar_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'sub_chapter_list_widget.dart' show SubChapterListWidget;
import 'package:flutter/material.dart';

class SubChapterListModel extends FlutterFlowModel<SubChapterListWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for custAppBar component.
  late CustAppBarModel custAppBarModel;
  // Stores action output result for [Backend Call - SQLite (fetchSubChapters)] action in Row widget.
  List<FetchSubChaptersRow>? subChapters;

  @override
  void initState(BuildContext context) {
    custAppBarModel = createModel(context, () => CustAppBarModel());
  }

  @override
  void dispose() {
    custAppBarModel.dispose();
  }
}
