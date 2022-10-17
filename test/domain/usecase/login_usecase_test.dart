import 'package:architecture_mvvm/core/devicedetails/device_details.dart';
import 'package:architecture_mvvm/data/models/request/request.dart';
import 'package:architecture_mvvm/domain/model/model.dart';
import 'package:architecture_mvvm/domain/usecase/login_usecase.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'login_usecase_test.mocks.dart';
import 'usecase_mocks.dart';

@GenerateNiceMocks([MockSpec<DeviceDetails>()])
void main() {
  late LoginUseCase loginUseCase;
  late MockRepository mockRepository;
  late MockDeviceDetails mockDeviceDetails;

  setUp(() {
    mockDeviceDetails = MockDeviceDetails();
    mockRepository = MockRepository();
    loginUseCase = LoginUseCase(
        repository: mockRepository, deviceDetails: mockDeviceDetails);
  });

  group('execute -', () {
    test(
      'verify deviceDetails.getDeviceDetails() is called',
      () async {
        // arrange
        const DeviceInfo deviceInfo =
            DeviceInfo('unknown', 'unknown', 'unknown');

        LoginUseCaseInput loginUseCaseInput =
            LoginUseCaseInput('any@email.com', 'anypassword');

        when(mockDeviceDetails.getDeviceDetails())
            .thenAnswer((_) async => deviceInfo);

        // act
        await loginUseCase.execute(loginUseCaseInput);
        // assert

        verify(mockDeviceDetails.getDeviceDetails());
      },
    );

    test(
      'verify repository.login() is called',
      () async {
        // arrange
        const DeviceInfo deviceInfo =
            DeviceInfo('unknown', 'unknown', 'unknown');

        LoginUseCaseInput loginUseCaseInput =
            LoginUseCaseInput('any@email.com', 'anypassword');

        LoginRequest loginRequest = LoginRequest(loginUseCaseInput.email,
            loginUseCaseInput.password, deviceInfo.identifier, deviceInfo.name);

        when(mockDeviceDetails.getDeviceDetails())
            .thenAnswer((_) async => deviceInfo);

        // act
        await loginUseCase.execute(loginUseCaseInput);
        // assert

        verify(mockRepository.login(loginRequest));
        verifyNoMoreInteractions(mockRepository);
      },
    );
  });
}
