import '/components/book_card_widget.dart';
import '/components/bookmark_item_widget.dart';
import '/components/category_chip_widget.dart';
import '/components/section_header_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'books_library_widget.dart' show BooksLibraryWidget;
import 'package:flutter/material.dart';

class BooksLibraryModel extends FlutterFlowModel<BooksLibraryWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for category_chip component.
  late CategoryChipModel categoryChipModel1;
  // Model for category_chip component.
  late CategoryChipModel categoryChipModel2;
  // Model for category_chip component.
  late CategoryChipModel categoryChipModel3;
  // Model for category_chip component.
  late CategoryChipModel categoryChipModel4;
  // Model for section_header component.
  late SectionHeaderModel sectionHeaderModel1;
  // Model for section_header component.
  late SectionHeaderModel sectionHeaderModel2;
  // Models for book_card dynamic component.
  late FlutterFlowDynamicModels<BookCardModel> bookCardModels;
  // Model for section_header component.
  late SectionHeaderModel sectionHeaderModel3;
  // Model for bookmark_item component.
  late BookmarkItemModel bookmarkItemModel1;
  // Model for bookmark_item component.
  late BookmarkItemModel bookmarkItemModel2;
  // Model for bookmark_item component.
  late BookmarkItemModel bookmarkItemModel3;

  @override
  void initState(BuildContext context) {
    categoryChipModel1 = createModel(context, () => CategoryChipModel());
    categoryChipModel2 = createModel(context, () => CategoryChipModel());
    categoryChipModel3 = createModel(context, () => CategoryChipModel());
    categoryChipModel4 = createModel(context, () => CategoryChipModel());
    sectionHeaderModel1 = createModel(context, () => SectionHeaderModel());
    sectionHeaderModel2 = createModel(context, () => SectionHeaderModel());
    bookCardModels = FlutterFlowDynamicModels(() => BookCardModel());
    sectionHeaderModel3 = createModel(context, () => SectionHeaderModel());
    bookmarkItemModel1 = createModel(context, () => BookmarkItemModel());
    bookmarkItemModel2 = createModel(context, () => BookmarkItemModel());
    bookmarkItemModel3 = createModel(context, () => BookmarkItemModel());
  }

  @override
  void dispose() {
    categoryChipModel1.dispose();
    categoryChipModel2.dispose();
    categoryChipModel3.dispose();
    categoryChipModel4.dispose();
    sectionHeaderModel1.dispose();
    sectionHeaderModel2.dispose();
    bookCardModels.dispose();
    sectionHeaderModel3.dispose();
    bookmarkItemModel1.dispose();
    bookmarkItemModel2.dispose();
    bookmarkItemModel3.dispose();
  }
}
