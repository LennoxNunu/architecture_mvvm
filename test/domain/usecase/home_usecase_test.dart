import 'package:architecture_mvvm/domain/usecase/home_usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'usecase_mocks.dart';

void main() {
  late HomeUseCase homeUseCase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    homeUseCase = HomeUseCase(mockRepository);
  });

  group('execute -', () {
    test(
      'verify _repository.getHome() is called',
      () async {
        // arrange

        // act
        await homeUseCase.execute(null);

        // assert
        verify(mockRepository.getHome());
        verifyNoMoreInteractions(mockRepository);
      },
    );
  });
}
