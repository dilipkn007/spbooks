import '/components/book_card2_widget.dart';
import '/components/bookmark_tab_widget.dart';
import '/components/page_mark_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'bookmarks_widget.dart' show BookmarksWidget;
import 'package:flutter/material.dart';

class BookmarksModel extends FlutterFlowModel<BookmarksWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for bookmark_tab component.
  late BookmarkTabModel bookmarkTabModel1;
  // Model for bookmark_tab component.
  late BookmarkTabModel bookmarkTabModel2;
  // Model for book_card2 component.
  late BookCard2Model bookCard2Model1;
  // Model for book_card2 component.
  late BookCard2Model bookCard2Model2;
  // Model for book_card2 component.
  late BookCard2Model bookCard2Model3;
  // Model for page_mark component.
  late PageMarkModel pageMarkModel1;
  // Model for page_mark component.
  late PageMarkModel pageMarkModel2;

  @override
  void initState(BuildContext context) {
    bookmarkTabModel1 = createModel(context, () => BookmarkTabModel());
    bookmarkTabModel2 = createModel(context, () => BookmarkTabModel());
    bookCard2Model1 = createModel(context, () => BookCard2Model());
    bookCard2Model2 = createModel(context, () => BookCard2Model());
    bookCard2Model3 = createModel(context, () => BookCard2Model());
    pageMarkModel1 = createModel(context, () => PageMarkModel());
    pageMarkModel2 = createModel(context, () => PageMarkModel());
  }

  @override
  void dispose() {
    bookmarkTabModel1.dispose();
    bookmarkTabModel2.dispose();
    bookCard2Model1.dispose();
    bookCard2Model2.dispose();
    bookCard2Model3.dispose();
    pageMarkModel1.dispose();
    pageMarkModel2.dispose();
  }
}
