import 'package:architecture_mvvm/domain/usecase/store_details_usecase.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'usecase_mocks.dart';

void main() {
  late StoreDetailsUseCase storeDetailsUseCase;
  late MockRepository mockRepository;

  setUp(() {
    mockRepository = MockRepository();
    storeDetailsUseCase = StoreDetailsUseCase(mockRepository);
  });

  group('execute -', () {
    test(
      'verify _repository.getStoreDetails() is called',
      () async {
        // arrange

        // act
        await storeDetailsUseCase.execute(null);

        // assert
        verify(mockRepository.getStoreDetails());
        verifyNoMoreInteractions(mockRepository);
      },
    );
  });
}
