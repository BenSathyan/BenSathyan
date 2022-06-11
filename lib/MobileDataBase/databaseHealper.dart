import 'dart:io' show Directory;
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;

class DatabaseHelper {
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  static final table = 'category_table';
  static final columnId = '_id';
  static final category = 'category';

  static final materialTable = 'materialTable';
  static final materialId = '_id';
  static final materialCategory = 'materialCategory';
  static final material = 'material';
  static final cost = 'cost';
  static final unitperPrice = 'unitperPrice';

  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $category TEXT NOT NULL
          )
          ''');
    await db.execute('''
          CREATE TABLE $materialTable (
            $materialId INTEGER PRIMARY KEY,
            $materialCategory TEXT NOT NULL,
            $material TEXT NOT NULL,
            $cost TEXT NOT NULL,
            $unitperPrice TEXT NOT NULL

          )
          ''');

    await db.rawInsert('INSERT INTO $table ($category) VALUES("Brick")');
    await db.rawInsert('INSERT INTO $table ($category) VALUES("Binding wire")');
    await db.rawInsert('INSERT INTO $table ($category) VALUES("TMT Rebar")');
    await db.rawInsert('INSERT INTO $table ($category) VALUES("Sand")');
    await db.rawInsert('INSERT INTO $table ($category) VALUES("Metal")');
    await db.rawInsert('INSERT INTO $table ($category) VALUES("Cement")');
    await db.rawInsert('INSERT INTO $table ($category) VALUES("Flooring")');
    await db.rawInsert('INSERT INTO $table ($category) VALUES("Flooring-Sub Items")');



    //Bricks
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Brick", "Burned(RED BRICKS)","13.00","Piece")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Brick", "Wire cut(9-4-3)","33.00","Piece")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Brick", "Wire cut(9-4.5-3)","33.00","Piece")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Brick", "Hollow Wirecut(12-6-4)","33.00","Piece")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Brick", "Hollow Wirecut(16-8-4)","33.00","Piece")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Brick", "Hollow Wirecut(14-7-6)","56.55","Piece")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Brick", "Hollow Hourdi 1.5 feet(18-19-3)","80.60","Piece")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Brick", "Hollow Hourdi 2.5 feet(24-19-3)","94.78","Piece")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Brick", "Hollow Hourdi 2.5 feet(30-19-3)","104.23","Piece")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Brick", "Fly Ash Bricks(9-41/4-3)","8.30","Piece")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Brick", "ACC 4","70.00","Piece")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Brick", "ACC 6","102.00","Piece")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Brick", "ACC 8","135.00","Piece")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Brick", "ACC Magicrete(60cm-20cm-10cm)","90.30","Piece")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Brick", "ACC Magicrete(60cm-20cm-15cm)","132.60","Piece")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Brick", "ACC Magicrete(60cm-20cm-20cm)","164.85","Piece")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Brick", "ACC Ultratech xtralite(60cm-20cm-10cm)","86.10","Piece")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Brick", "ACC Ultratech xtralite(60cm-20cm-15cm)","119.70","Piece")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Brick", "ACC Ultratech xtralite(60cm-20cm-20cm)","152.10","Piece")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Brick", "Solid concrete (12-8-4)","19.50","Piece")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Brick", "Solid concrete (12-8-6)","24.50","Piece")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Brick", "Solid concrete (16-8-4)","28.00","Piece")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Brick", "Solid concrete (16-8-6)","32.96","Piece")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Brick", "Hollow Concrete Single Hole(16-8-4)","28.00","Piece")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Brick", "Hollow Concrete Double Hole(16-8-8)","28.00","Piece")');

    //Binding wire
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Binding wire", "16 Gauge","65.00","Kg")');

    //TMT Rebar

    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("TMT Rebar", "Agni Steel","50.00","Kg")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("TMT Rebar", "Apex Steel","45.00","Kg")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("TMT Rebar", "ARS Steel","45.00","Kg")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("TMT Rebar", "Indrol","39.50.00","Kg")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("TMT Rebar", "I Steel","45.50.00","Kg")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("TMT Rebar", "Kairali","50.00","Kg")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("TMT Rebar", "Kalliyath","50.00","Kg")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("TMT Rebar", "Kamachi","50.00","Kg")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("TMT Rebar", "Kamdhenu","45.00","Kg")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("TMT Rebar", "O gun","45.00","Kg")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("TMT Rebar", "Peekay Steel","45.00","Kg")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("TMT Rebar", "Prime Gold","50.00","Kg")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("TMT Rebar", "Prince","42.30","Kg")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("TMT Rebar", "Sastha","41.00","Kg")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("TMT Rebar", "Sun","37.25","Kg")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("TMT Rebar", "Suryadev","50.00","Kg")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("TMT Rebar", "Tata Tiscon","50.00","Kg")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("TMT Rebar", "Vizag","50.00","Kg")');

    //Sand

    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Sand", "Filling Sand(165/350)","18.00","CFT")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Sand", "M-Sand","52.00","CFT")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Sand", "M-Sand Washed","44.00","CFT")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Sand", "Plastering-Sand","70.00","CFT")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Sand", "Boulders","28.00","CFT")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Sand", "Metal Dust","43.00","CFT")');

    //Metal

    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Metal", "4mm","51.00","CFT")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Metal", "6mm","35.00","CFT")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Metal", "10mm","38.00","CFT")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Metal", "12mm","38.00","CFT")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Metal", "20mm","40.00","CFT")');

    //Cement

    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","ACC Laminated Bag","398.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","ACC Gold Laminated Bag","398.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Ambuja Laminated Bag","385.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Arasu Paper Bag","398.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Bagalkot Supreme Polythene Bag","358.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Bagalkot Shakti Paper Bag","358.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Bharathi Paper Bag","380.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Bharathi Laminated Bag","382.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Bharathi HDP Bag","382.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Bharathi Paper Bag","380.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Birla Gold Hdp Bag","380.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Birla Gold Laminated Bag","380.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Birla A1 Premium","450.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Birla A1 Paper Bag","450.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Dalmia HDP Bag","398.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Dalmia Paper Bag","370.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Chettinad Laminated Bag","360.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Coromandel king Polythene Bag","398.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Indiana Paper Bag","380.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Jaypee HDP Bag","380.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","J.k Super Paper Bag","385.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","J.k Laminated Bag","380.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","J.k HDP Bag","380.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","J.k Paper Bag","385.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","J.k Polythene Bag","385.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","JSW Concreel HD Laminated Bag","398.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Maha Laminated Bag","450.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Maha Sakthi Laminated Bag","394.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Maha Paper Bag","450.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Malabar Aiswarya Paper Bag","398.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Malabar Super HDPE Bag","398.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","MyCem Laminated Bag","398.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Penna Suraksha Laminated Bag","398.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Ramco Super Paper Bag","398.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Ramco Super Laminated Bag","370.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Sankar Polythene Bag","370.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Sankar Paper Bag","390.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Siddhee Polythene Bag","340.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Ultratech Laminated Bag","385.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Zuari Laminated Bag","357.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Zuari PRO Polythene Bag","390.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Zuari i Work High Power Polythene Bag","390.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Zuari i Work High Power HDP Bag","382.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Zuari i Work High Power Laminated Bag","380.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","Zuari i Work High Power Paper Bag","358.00","Bag")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Cement","White Cement","800.00","Bag")');

    //Flooring

    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Flooring","Granite Black Galaxy","240.00","sqft")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Flooring","Granite Milky White","500.00","sqft")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Flooring","Vitrified Tiles(60cm-60cm)","50.00","sqft")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Flooring","Vitrified Tiles(120cm-60cm)","130.00","sqft")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Flooring","Vitrified Tiles(80cm-60cm)","90.00","sqft")');

    // Flooring-Sub Items

    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Flooring-Sub Items","Joint filler Powder","75.00","kg")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Flooring-Sub Items","Hardener Liquid(70Gms)","55.00","Gms")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Flooring-Sub Items","Epoxy Joint Filler","700.00","kg")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Flooring-Sub Items","Glass Bond Epoxy","3000.00","kg")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Flooring-Sub Items","Tile Adhesives(GUM-20kg)","570.00","kg")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Flooring-Sub Items","Tile Trims(Corner beading)","130.00","length")');
    await db.rawInsert('INSERT INTO $materialTable ($materialCategory,$material, $cost,$unitperPrice) VALUES("Flooring-Sub Items","Tenax(Cera Fluid)","170.00","Liter")');




















































































































    // prepopulate a few rows (consider using a transaction)
  }

  static Future<void> deleteCategoryTable(Database db) async {
    await db.delete(table);
  }

  static Future<void> deleteMaterialTable(Database db) async {
    await db.delete(materialTable);
  }
}
