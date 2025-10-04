import 'package:flutter/material.dart';
import 'package:recipes/models/response_model.dart';

class BaseProvider extends ChangeNotifier{

  void failureCase(ResponseModel result) {
      // final res = result as ErrorResponseModel;
  }
}