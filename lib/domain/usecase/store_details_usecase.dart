import 'package:dartz/dartz.dart';

import '../../core/network/failure.dart';
import '../model/model.dart';
import '../repository/repository.dart';
import '../../core/usecase/base_usecase.dart';

class StoreDetailsUseCase extends BaseUseCase<void, StoreDetails> {
  Repository repository;

  StoreDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, StoreDetails>> execute(void input) {
    return repository.getStoreDetails();
  }
}
