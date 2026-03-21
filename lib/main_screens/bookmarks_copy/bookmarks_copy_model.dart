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
  late BookCard2Model bookCard2Model1;
  // Model for book_card2 component.
  late BookCard2Model bookCard2Model2;
  // Model for book_card2 component.
  late BookCard2Model bookCard2Model3;
  // Model for book_card2 component.
  late BookCard2Model bookCard2Model4;
  // Model for book_card2 component.
  late BookCard2Model bookCard2Model5;
  // Model for book_card2 component.
  late BookCard2Model bookCard2Model6;
  // Model for page_card2 component.
  late PageCard2Model pageCard2Model;

  @override
  void initState(BuildContext context) {
    bookCard2Model1 = createModel(context, () => BookCard2Model());
    bookCard2Model2 = createModel(context, () => BookCard2Model());
    bookCard2Model3 = createModel(context, () => BookCard2Model());
    bookCard2Model4 = createModel(context, () => BookCard2Model());
    bookCard2Model5 = createModel(context, () => BookCard2Model());
    bookCard2Model6 = createModel(context, () => BookCard2Model());
    pageCard2Model = createModel(context, () => PageCard2Model());
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    bookCard2Model1.dispose();
    bookCard2Model2.dispose();
    bookCard2Model3.dispose();
    bookCard2Model4.dispose();
    bookCard2Model5.dispose();
    bookCard2Model6.dispose();
    pageCard2Model.dispose();
  }
}
