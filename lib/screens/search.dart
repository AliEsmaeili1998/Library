import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../colors.dart';
import '../database.dart';
import '../models/book.dart';
import 'editpage.dart';
import '../widgets/library_item.dart';
import '../widgets/text_field.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final MyDatabase _db = MyDatabase();
  String? keyword = '';
  bool active1 = true;
  bool active2 = true;
  ScrollController listScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                right: 10,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: MyColors.text1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 25, left: 25, top: 5),
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: MyTextField(
                  myLableText: 'کلمه کلیدی',
                  myOnChange: (value) {
                    keyword = value;
                    setState(() {});
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 6.0, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (active1) {
                          active1 = false;
                        } else {
                          active1 = true;
                        }
                      });
                    },
                    child: active1
                        ? Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: MyColors.text1,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(5),
                              color: MyColors.foreground1,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'خوانده شده',
                                style: TextStyle(
                                  color: MyColors.text1,
                                ),
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: MyColors.text1.withOpacity(0.8),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.blueGrey,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'خوانده شده',
                                style: TextStyle(
                                  color: MyColors.text1.withOpacity(0.8),
                                ),
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (active2) {
                          active2 = false;
                        } else {
                          active2 = true;
                        }
                      });
                    },
                    child: active2
                        ? Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: MyColors.text1,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(5),
                              color: MyColors.foreground1,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'خوانده نشده',
                                style: TextStyle(
                                  color: MyColors.text1,
                                ),
                              ),
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: MyColors.text1.withOpacity(0.8),
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.blueGrey,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                'خوانده نشده',
                                style: TextStyle(
                                  color: MyColors.text1.withOpacity(0.8),
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Book>>(
                initialData: const [],
                future: _db.searchBooks(keyword, active1, active2),
                builder: (context, snapshot) {
                  return ListView.builder(
                    controller: listScrollController,
                    physics: const BouncingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  EditPage(book: snapshot.data![index]),
                            ),
                          ).then((value) {
                            setState(() {});
                          });
                        },
                        child: LibraryItem(
                          name: snapshot.data![index].name,
                          writer: snapshot.data![index].writer,
                          publisher: snapshot.data![index].publisher,
                          number: index + 1,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: SpeedDial(
        backgroundColor: MyColors.foreground3,
        switchLabelPosition: true,
        foregroundColor: MyColors.text1,
        overlayColor: MyColors.text2,
        overlayOpacity: 0.4,
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.arrow_downward),
            backgroundColor: MyColors.text1,
            foregroundColor: MyColors.text2,
            onTap: () {
              if (listScrollController.hasClients) {
                final position = listScrollController.position.maxScrollExtent;
                listScrollController.animateTo(
                  position,
                  duration: const Duration(seconds: 3),
                  curve: Curves.easeOut,
                );
              }
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.arrow_upward),
            backgroundColor: MyColors.text1,
            foregroundColor: MyColors.text2,
            onTap: () {
              if (listScrollController.hasClients) {
                final position = listScrollController.position.minScrollExtent;
                listScrollController.animateTo(
                  position,
                  duration: const Duration(seconds: 3),
                  curve: Curves.easeOut,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
