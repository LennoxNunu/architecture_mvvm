import 'package:dartz/dartz.dart';

import '../../core/network/failure.dart';
import '../../data/models/request/request.dart';

import '../model/model.dart';

abstract class Repository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);
  Future<Either<Failure, String>> forgotPassword(String email);
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest);
  Future<Either<Failure, HomeObject>> getHome();
  Future<Either<Failure, StoreDetails>> getStoreDetails();
}
