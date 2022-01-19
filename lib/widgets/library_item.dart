import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../colors.dart';

class LibraryItem extends StatelessWidget {
  final String name;
  final String? writer;
  final String? publisher;
  final int? number;

  const LibraryItem(
      {Key? key, required this.name, this.writer, this.publisher, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15,
        right: 25,
        left: 25,
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 170,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 145,
                decoration: BoxDecoration(
                  color: MyColors.foreground2,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: MyColors.text2.withOpacity(0.4),
                        blurRadius: 1,
                        spreadRadius: 1,
                        offset: const Offset(-10, 10)),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 33, left: 5, right: 5, bottom: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'نام کتاب:',
                            style:
                                TextStyle(color: MyColors.text2, fontSize: 18),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Container(
                              height: 30,
                              decoration: BoxDecoration(
                                color: MyColors.foreground1,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Text(
                                    name,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: MyColors.text1,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Row(
                          children: [
                            Text(
                              'نویسنده:',
                              style: TextStyle(
                                  color: MyColors.text2, fontSize: 18),
                            ),
                            const SizedBox(
                              width: 9,
                            ),
                            Expanded(
                              child: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  color: MyColors.foreground1,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Text(
                                      writer ?? '(مشخص نشده)',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: MyColors.text1,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Row(
                          children: [
                            Text(
                              'ناشر:',
                              style: TextStyle(
                                  color: MyColors.text2, fontSize: 18),
                            ),
                            const SizedBox(
                              width: 35,
                            ),
                            Expanded(
                              child: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                  color: MyColors.foreground1,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Text(
                                      publisher ?? '(مشخص نشده)',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: MyColors.text1,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: MyColors.foreground3,
                ),
                child: Center(
                  child: Text(
                    '$number'.toPersianDigit(),
                    style: TextStyle(
                      color: MyColors.text1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
