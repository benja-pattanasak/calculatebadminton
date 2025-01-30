import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  setDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_calculatebadminton');
    var database =
        await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);
    return database;
  }

  _onCreatingDatabase(Database database, int version) async {
    await database
        .execute("CREATE TABLE player(id INTEGER PRIMARY KEY,name TEXT)");
    await database.execute(
        "CREATE TABLE game(id INTEGER PRIMARY KEY,team1ID TEXT,team1Name TEXT,team2ID TEXT,team2Name TEXT,typeCostShuttlecock TEXT,numberShuttleCock INTEGER,results TEXT)");
    await database.execute(
        "CREATE TABLE betdetail(id INTEGER PRIMARY KEY,gameID TEXT,betPlayerID TEXT,betPlayerName TEXT,betValue INTEGER,betTeamID TEXT,betTeamName TEXT)");
    await database.execute(
        "CREATE TABLE setting(id INTEGER PRIMARY KEY,costCort INTEGER,costShuttleCock INTEGER)");
  }
}
