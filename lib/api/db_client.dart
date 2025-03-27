import 'package:flutter/services.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:yaml/yaml.dart';

import '../constants/assets.dart';
import '../models/schemas/quiz.dart';

class DbClientResponse {
  const DbClientResponse(this.success, this.message);

  final bool success;
  final String message;
}

class DbClientUnknownErrorResponse extends DbClientResponse {
  const DbClientUnknownErrorResponse() : super(false, 'Unknown error');
}

class DatabaseClient {
  static late final Db db;
  static late final String url;
  static late final String scoreCollection;

  static Future<void> init() async {
    final String config = await rootBundle.loadString(configPath);
    final YamlMap configMap = loadYaml(config) as YamlMap;

    final String cluster = configMap['database']['cluster'] as String;
    final String database = configMap['database']['database'] as String;
    final String username = configMap['database']['username'] as String;
    final String password = configMap['database']['password'] as String;

    url = 'mongodb+srv://$username:$password@$cluster.mongodb.net/$database';

    scoreCollection = configMap['database']['collections']['score'] as String;

    db = await Db.create(url);
  }

  static Future<DbClientResponse> insertScore(QuizSchema quiz) async {
    String? message;
    bool status = false;

    await db.open().catchError((Object e) {
      message = 'Could not connect to database: $e';
      return null;
    });

    if (!db.isConnected) {
      if (message == null) {
        return const DbClientUnknownErrorResponse();
      }

      return DbClientResponse(status, message!);
    }

    await db
        .collection(scoreCollection)
        .insertOne(quiz.toMap())
        .then((WriteResult result) {
          if (result.nInserted == 0) {
            throw Exception(result.writeError?.errmsg ?? 'Unknown error');
          }
          status = true;
          message = '';
        })
        .catchError((Object e) {
          status = false;
          message = e.toString();
        })
        .whenComplete(() => db.close());

    return DbClientResponse(status, message!);
  }
}
