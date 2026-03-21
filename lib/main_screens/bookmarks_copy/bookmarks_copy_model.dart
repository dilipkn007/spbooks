import '/components/book_card2_widget.dart';
import '/components/page_card2_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'bookmarks_copy_widget.dart' show BookmarksCopyWidget;
import 'package:flutter/material.dart';

class BookmarksCopyModel extends FlutterFlowModel<BookmarksCopyWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Model for book_card2 component.
  late BookCard2Model bookCard2Model;
  // Model for page_card2 component.
  late PageCard2Model pageCard2Model;

  @override
  void initState(BuildContext context) {
    bookCard2Model = createModel(context, () => BookCard2Model());
    pageCard2Model = createModel(context, () => PageCard2Model());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    bookCard2Model.dispose();
    pageCard2Model.dispose();
  }
}
