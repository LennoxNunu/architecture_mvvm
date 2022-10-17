import 'package:dartz/dartz.dart';

import '../../core/devicedetails/device_details.dart';
import '../../core/network/failure.dart';
import '../../data/models/request/request.dart';
import '../model/model.dart';
import '../repository/repository.dart';
import '../../core/usecase/base_usecase.dart';

class LoginUseCase implements BaseUseCase<LoginUseCaseInput, Authentication> {
  final Repository repository;
  final DeviceDetails deviceDetails;

  LoginUseCase({required this.repository, required this.deviceDetails});

  @override
  Future<Either<Failure, Authentication>> execute(
      LoginUseCaseInput input) async {
    DeviceInfo deviceInfo = await deviceDetails.getDeviceDetails();
    return await repository.login(LoginRequest(
        input.email, input.password, deviceInfo.identifier, deviceInfo.name));
  }
}

class LoginUseCaseInput {
  String email;
  String password;

  LoginUseCaseInput(this.email, this.password);
}
