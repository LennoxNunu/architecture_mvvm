import 'package:architecture_mvvm/domain/usecase/forgot_password_usecase.dart';

import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'usecase_mocks.dart';

void main() {
  late ForgotPasswordUseCase forgotPasswordUseCase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    forgotPasswordUseCase = ForgotPasswordUseCase(mockRepository);
  });

  group('execute -', () {
    test(
      'verify _repository.forgotPassword(input) is called',
      () async {
        const String email = 'any@gmail.com';
        // arrange

        // act
        await forgotPasswordUseCase.execute(email);
        // assert

        verify(mockRepository.forgotPassword(any));
        verifyNoMoreInteractions(mockRepository);
      },
    );
  });
}
