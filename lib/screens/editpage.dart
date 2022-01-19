import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../colors.dart';
import '../database.dart';
import '../models/book.dart';
import '../widgets/text_field.dart';

class EditPage extends StatefulWidget {
  final Book? book;

  const EditPage({Key? key, required this.book}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final MyDatabase _db = MyDatabase();
  int? _bookId = 0;
  bool view = false;

  String bookName = '';
  bool bookRead = false;
  String? bookWriter = '';
  String? bookPublisher = '';
  String? bookTranslator = '';
  double bookRating = 0;
  String? bookComment = '';

  late FocusNode _nameFocus;
  late FocusNode _writerFocus;
  late FocusNode _publisherFocus;
  late FocusNode _translatorFocus;
  late FocusNode _commentFocus;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _writerController = TextEditingController();
  final TextEditingController _publisherController = TextEditingController();
  final TextEditingController _translatorController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  bool _nameCheck = false;
  final bool _writerCheck = false;
  final bool _publisherCheck = false;
  final bool _translatorCheck = false;
  final bool _commentCheck = false;

  @override
  void initState() {
    if (widget.book != null) {
      view = true;
      bookName = widget.book!.name;
      bookRead = widget.book!.read!;
      bookWriter = widget.book!.writer;
      bookPublisher = widget.book!.publisher;
      bookTranslator = widget.book!.translator;
      bookRating = widget.book!.rating;
      bookComment = widget.book!.comment;
      _bookId = widget.book!.id;
    }

    _nameFocus = FocusNode();
    _writerFocus = FocusNode();
    _publisherFocus = FocusNode();
    _translatorFocus = FocusNode();
    _commentFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _nameFocus.dispose();
    _writerFocus.dispose();
    _publisherFocus.dispose();
    _translatorFocus.dispose();
    _commentFocus.dispose();

    super.dispose();
  }

  Future<void> updateAll() async {
    if (_nameCheck == false && _nameController.text != '') {
      await _db.updateName(_bookId!, _nameController.text);
      bookName = _nameController.text;
    }
    _db.updateRead(_bookId!, bookRead == true ? 'true' : 'false');
    if (_writerCheck == false && _writerController.text != '') {
      await _db.updateWriter(_bookId!, _writerController.text);
      bookWriter = _writerController.text;
    }
    if (_publisherCheck == false && _publisherController.text != '') {
      await _db.updatePublisher(_bookId!, _publisherController.text);
      bookPublisher = _publisherController.text;
    }
    if (_translatorCheck == false && _translatorController.text != '') {
      await _db.updateTranslator(_bookId!, _translatorController.text);
      bookTranslator = _translatorController.text;
    }
    if (_commentCheck == false && _commentController.text != '') {
      await _db.updateComment(_bookId!, _commentController.text);
      bookComment = _commentController.text;
    }
  }

  Future<bool> _onWillPop() async {
    updateAll();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        right: 10,
                        left: 10,
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              updateAll();
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              size: 30,
                              color: MyColors.text1,
                            ),
                          ),
                          const Spacer(),
                          AnimatedOpacity(
                            duration: const Duration(seconds: 1),
                            opacity: view ? 1 : 0,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (bookRead) {
                                    bookRead = false;
                                  } else {
                                    bookRead = true;
                                  }
                                  updateAll();
                                });
                              },
                              child: AnimatedCrossFade(
                                crossFadeState: bookRead
                                    ? CrossFadeState.showFirst
                                    : CrossFadeState.showSecond,
                                duration: const Duration(milliseconds: 750),
                                firstChild: Container(
                                  width: 94,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: MyColors.text1,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                    color: MyColors.foreground1,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'خوانده شده',
                                      style: TextStyle(color: MyColors.text1),
                                    ),
                                  ),
                                ),
                                secondChild: Container(
                                  width: 94,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: MyColors.text1.withOpacity(0.8),
                                      width: 2,
                                    ),
                                    color: Colors.blueGrey,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        'خوانده نشده',
                                        style: TextStyle(
                                          color: MyColors.text1.withOpacity(0.8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 25, left: 25, top: 5),
                        child: ListView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(top: 20),
                          shrinkWrap: true,
                          children: [
                            MyTextField(
                              focusNode: _nameFocus,
                              myLableText: 'نام کتاب',
                              myOnSubmit: (value) async {
                                if (value != '') {
                                  if (widget.book == null) {
                                    Book _newBook =
                                        Book(name: value, read: bookRead);
                                    _bookId = await _db.insertBook(_newBook);
                                    view = true;
                                    bookName = value;
                                    _nameCheck = true;
                                  } else {
                                    updateAll();
                                  }
                                  setState(() {});
                                }
                                _writerFocus.requestFocus();
                              },
                              changeText: _nameController..text = bookName,
                            ),
                            AnimatedOpacity(
                              duration: const Duration(seconds: 1),
                              opacity: view ? 1 : 0,
                              child: Column(
                                children: [
                                  MyTextField(
                                    focusNode: _writerFocus,
                                    myLableText: 'نویسنده',
                                    myOnSubmit: (value) {
                                      updateAll();
                                      _publisherFocus.requestFocus();
                                    },
                                    changeText: _writerController
                                      ..text = bookWriter ?? '',
                                  ),
                                  MyTextField(
                                    focusNode: _publisherFocus,
                                    myLableText: 'ناشر',
                                    myOnSubmit: (value) {
                                      updateAll();
                                      _translatorFocus.requestFocus();
                                    },
                                    changeText: _publisherController
                                      ..text = bookPublisher ?? '',
                                  ),
                                  MyTextField(
                                    focusNode: _translatorFocus,
                                    myLableText: 'مترجم',
                                    myOnSubmit: (value) {
                                      updateAll();
                                      _commentFocus.requestFocus();
                                    },
                                    changeText: _translatorController
                                      ..text = bookTranslator ?? '',
                                  ),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: RatingBar.builder(
                                          initialRating: bookRating,
                                          glow: false,
                                          allowHalfRating: true,
                                          itemBuilder: (context, _) => Icon(
                                            Icons.favorite,
                                            color: MyColors.foreground3,
                                          ),
                                          onRatingUpdate: (rating) async {
                                            await _db.updateRating(
                                                _bookId!, rating);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  MyTextField(
                                    focusNode: _commentFocus,
                                    myLableText: 'نظر',
                                    txtAlign: TextAlign.start,
                                    myOnSubmit: (value) {
                                      updateAll();
                                    },
                                    changeText: _commentController
                                      ..text = bookComment ?? '',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () async {
                      await _db.deleteBook(_bookId!);
                      Navigator.pop(context);
                    },
                    child: AnimatedOpacity(
                      duration: const Duration(seconds: 1),
                      opacity: view ? 1 : 0,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: MyColors.foreground3,
                        ),
                        child: Icon(
                          Icons.delete,
                          color: MyColors.text1,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
