class ErrorModel {
  final String status;
  final String errorMessage;
  final int code;

  ErrorModel({
    required this.status,
    required this.errorMessage,
    required this.code,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    return ErrorModel(
      status: jsonData["status"] ?? "Unknown",
      errorMessage: jsonData["error"] ?? "An unexpected error occurred",
      code: jsonData["code"] ?? 0,
    );
  }
}
