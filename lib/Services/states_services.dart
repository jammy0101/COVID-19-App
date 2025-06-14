import 'dart:convert';

import 'package:covid_tracker/Model/WorldStateModel.dart';
import 'package:covid_tracker/Services/Utilities/app_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class StatesServices {

  Future<WorldStateModel>  fetchWorldStatesRecords()async{

    final response = await http.get(Uri.parse(AppUrl.baseUrl));
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      return WorldStateModel.fromJson(data);
    }else{
      throw Exception('Error');
    }
  }

}