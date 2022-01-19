import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../colors.dart';
import '../database.dart';
import '../models/book.dart';
import 'editpage.dart';
import 'search.dart';
import '../widgets/library_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MyDatabase _db = MyDatabase();
  ScrollController listScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).padding.top + 135.0,
                decoration: BoxDecoration(
                  color: MyColors.foreground1,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'کتابخانه',
                      style: TextStyle(
                        color: MyColors.text1,
                        fontSize: 36.0,
                      ),
                    ),
                    VerticalDivider(
                      color: MyColors.foreground2,
                      width: 20,
                      thickness: 1,
                      indent: 50,
                      endIndent: 50,
                    ),
                    Icon(
                      Icons.book,
                      color: MyColors.foreground3,
                      size: 36,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: FutureBuilder<List<Book>>(
                  initialData: const [],
                  future: _db.getBooks(),
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
        ],
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
              child: const Icon(Icons.add),
              backgroundColor: MyColors.text1,
              foregroundColor: MyColors.text2,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const EditPage(
                          book: null,
                        )));
              }),
          SpeedDialChild(
            child: const Icon(Icons.search),
            backgroundColor: MyColors.text1,
            foregroundColor: MyColors.text2,
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SearchPage()));
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.arrow_downward),
            backgroundColor: MyColors.text1,
            foregroundColor: MyColors.text2,
            onTap: () {
              if (listScrollController.hasClients) {
                final position =
                    listScrollController.position.maxScrollExtent;
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
                final position =
                    listScrollController.position.minScrollExtent;
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
