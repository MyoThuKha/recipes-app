enum Status { success, error }

sealed class StatusModel {
  final Status status;
  final String message;

  StatusModel({required this.status, required this.message});
}

class SuccessModel extends StatusModel {
  SuccessModel({required super.status, super.message = ""});
}

class ErrorModel extends StatusModel {
  ErrorModel({required super.status, required super.message});
}
