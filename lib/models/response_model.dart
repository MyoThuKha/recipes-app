class ResponseModel {
  int code = 0;
  ResponseModel({required this.code});
}


class SuccessResponseModel extends ResponseModel{
  Object data;
  SuccessResponseModel({required super.code, required this.data});
}

class ErrorResponseModel extends ResponseModel{
  String? message;

  ErrorResponseModel({required super.code, required this.message});
}