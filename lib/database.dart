import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'models/book.dart';

class MyDatabase {
  Future<Database> database() async {
    WidgetsFlutterBinding.ensureInitialized();
    return openDatabase(
      join(await getDatabasesPath(), 'book'),
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE books(name TEXT, read TEXT, writer TEXT, publisher TEXT, translator TEXT, rating REAL, comment TEXT, id INTEGER PRIMARY KEY)');
      },
      version: 1,
    );
  }

  Future<int> insertBook(Book book) async {
    Database _db = await database();
    return await _db.insert(
      'books',
      book.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteBook(int id) async {
    Database _db = await database();
    await _db.delete(
      'books',
      where: 'id = $id',
    );
  }

  Future<List<Book>> getBooks() async {
    Database _db = await database();
    final List<Map<String, dynamic>> maps = await _db.query('books');
    return List.generate(maps.length, (index) {
      return Book(
        name: maps[index]['name'],
        read: maps[index]['read'] == 'true' ? true : false,
        writer: maps[index]['writer'],
        publisher: maps[index]['publisher'],
        translator: maps[index]['translator'],
        rating: maps[index]['rating'],
        comment: maps[index]['comment'],
        id: maps[index]['id'],
      );
    });
  }

  Future<List<Book>> searchBooks(
      String? keyword, bool active1, bool active2) async {
    Database _db = await database();
    final List<Map<String, dynamic>> maps;
    if (active1 && active2) {
      maps = await _db.query('books',
          where:
              "name LIKE ? OR writer LIKE ? OR publisher LIKE ? OR translator LIKE ? ",
          whereArgs: ['%$keyword%', '%$keyword%', '%$keyword%', '%$keyword%']);
    } else if (active1 && !active2) {
      maps = await _db.query('books',
          where:
              "(name LIKE ? OR writer LIKE ? OR publisher LIKE ? OR translator LIKE ?) AND read = 'true'",
          whereArgs: ['%$keyword%', '%$keyword%', '%$keyword%', '%$keyword%']);
    } else if (!active1 && active2) {
      maps = await _db.query('books',
          where:
              "(name LIKE ? OR writer LIKE ? OR publisher LIKE ? OR translator LIKE ?) AND read = 'false'",
          whereArgs: ['%$keyword%', '%$keyword%', '%$keyword%', '%$keyword%']);
    } else {
      maps = [];
    }
    return List.generate(maps.length, (index) {
      return Book(
        name: maps[index]['name'],
        read: maps[index]['read'] == 'true' ? true : false,
        writer: maps[index]['writer'],
        publisher: maps[index]['publisher'],
        translator: maps[index]['translator'],
        rating: maps[index]['rating'],
        comment: maps[index]['comment'],
        id: maps[index]['id'],
      );
    });
  }

  Future<void> updateName(int id, String name) async {
    Database _db = await database();
    _db.update('books', {'name': name}, where: 'id = $id');
  }

  Future<void> updateRead(int id, String read) async {
    Database _db = await database();
    _db.update('books', {'read': read}, where: 'id = $id');
  }

  Future<void> updateWriter(int id, String writer) async {
    Database _db = await database();
    _db.update('books', {'writer': writer}, where: 'id = $id');
  }

  Future<void> updatePublisher(int id, String publisher) async {
    Database _db = await database();
    _db.update('books', {'publisher': publisher}, where: 'id = $id');
  }

  Future<void> updateTranslator(int id, String translator) async {
    Database _db = await database();
    _db.update('books', {'translator': translator}, where: 'id = $id');
  }

  Future<void> updateRating(int id, double rating) async {
    Database _db = await database();
    _db.update('books', {'rating': rating}, where: 'id = $id');
  }

  Future<void> updateComment(int id, String comment) async {
    Database _db = await database();
    _db.update('books', {'comment': comment}, where: 'id = $id');
  }
}
