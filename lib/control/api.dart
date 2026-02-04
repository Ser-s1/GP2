
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:final_projict/control/Disney.dart';

class Api {

  Future<List<Disney>> getData() async {

    String response = await rootBundle.loadString("assets/data/disney.json");
    var result = jsonDecode(response);

    List<Disney> disneyList = [];

    for (var item in result["products"]) {
      disneyList.add(Disney.fromJson(item));
    }

    return disneyList;
  }
}


