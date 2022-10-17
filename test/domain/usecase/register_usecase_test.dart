import 'package:architecture_mvvm/data/models/request/request.dart';
import 'package:architecture_mvvm/domain/usecase/register_usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'usecase_mocks.dart';

void main() {
  late RegisterUseCase registerUseCase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    registerUseCase = RegisterUseCase(mockRepository);
  });

  group('execute -', () {
    test(
      'verify repository.register() is called',
      () async {
        // arrange
        RegisterUseCaseInput registerUseCaseInput = RegisterUseCaseInput(
            'anyNumber',
            'anyCountryCode',
            'anyUserName',
            'any@email.com',
            'anyPassword',
            'anyProfilePicture');

        RegisterRequest registerRequest = RegisterRequest(
            registerUseCaseInput.countryMobileCode,
            registerUseCaseInput.userName,
            registerUseCaseInput.email,
            registerUseCaseInput.password,
            registerUseCaseInput.profilePicture,
            registerUseCaseInput.mobileNumber);
        // act
        await registerUseCase.execute(registerUseCaseInput);
        // assert

        verify(mockRepository.register(registerRequest));
        verifyNoMoreInteractions(mockRepository);
      },
    );
  });
}
