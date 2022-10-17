import 'package:equatable/equatable.dart';

import 'error_handler.dart';

class Failure extends Equatable {
  final int code; // 200 or 400
  final String message; // error or success

  const Failure(this.code, this.message);

  @override
  List<Object?> get props => [code, message];
}

class DefaultFailure extends Failure {
  const DefaultFailure() : super(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
}
