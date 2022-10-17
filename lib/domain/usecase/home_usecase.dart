import 'package:dartz/dartz.dart';

import '../../core/network/failure.dart';
import '../model/model.dart';
import '../repository/repository.dart';
import '../../core/usecase/base_usecase.dart';

class HomeUseCase extends BaseUseCase<void, HomeObject> {
  final Repository _repository;

  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, HomeObject>> execute(void input) async {
    return await _repository.getHome();
  }
}
