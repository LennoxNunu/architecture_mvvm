import 'package:dartz/dartz.dart';

import '../../core/mapper/mapper.dart';
import '../../core/network/error_handler.dart';
import '../../core/network/failure.dart';
import '../../core/network/network_info.dart';
import '../../domain/model/model.dart';
import '../../domain/repository/repository.dart';
import '../data_source/local_data_source.dart';
import '../data_source/remote_data_source.dart';
import '../models/request/request.dart';
import '../models/responses/responses.dart';

class RepositoryImpl extends Repository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  RepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        // its safe to call the API
        final AuthenticationResponse response =
            await remoteDataSource.login(loginRequest);

        if (response.status == ApiInternalStatus.SUCCESS) // success
        {
          // return data (success)
          // return right
          return Right(response.toDomain());
        } else {
          // return biz logic error
          // return left
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return (Left(ErrorHandler.handle(error).failure));
      }
    } else {
      // return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        // its safe to call API
        final ForgotPasswordResponse response =
            await remoteDataSource.forgotPassword(email);

        if (response.status == ApiInternalStatus.SUCCESS) {
          // success
          // return right
          return Right(response.toDomain());
        } else {
          // failure
          // return left
          return Left(Failure(response.status ?? ResponseCode.DEFAULT,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return network connection error
      // return left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        // its safe to call the API
        final AuthenticationResponse response =
            await remoteDataSource.register(registerRequest);

        if (response.status == ApiInternalStatus.SUCCESS) // success
        {
          // return data (success)
          // return right
          return Right(response.toDomain());
        } else {
          // return biz logic error
          // return left
          return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return (Left(ErrorHandler.handle(error).failure));
      }
    } else {
      // return connection error
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeObject>> getHome() async {
    try {
      // get from cache
      final HomeResponse response = await localDataSource.getHome();
      return Right(response.toDomain());
    } catch (cacheError) {
      // we have cache error so we should call API

      bool isConnected = await networkInfo.isConnected;
      if (isConnected) {
        try {
          // its safe to call the API
          final HomeResponse response = await remoteDataSource.getHome();

          if (response.status == ApiInternalStatus.SUCCESS) // success
          {
            // return data (success)
            // return right
            // save response to local data source

            await localDataSource.saveHomeToCache(response);

            return Right(response.toDomain());
          } else {
            // return biz logic error
            // return left
            return Left(Failure(response.status ?? ApiInternalStatus.FAILURE,
                response.message ?? ResponseMessage.DEFAULT));
          }
        } catch (error) {
          return (Left(ErrorHandler.handle(error).failure));
        }
      } else {
        // return connection error
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }

  @override
  Future<Either<Failure, StoreDetails>> getStoreDetails() async {
    try {
      // get data from cache

      final StoreDetailsResponse response =
          await localDataSource.getStoreDetails();
      return Right(response.toDomain());
    } catch (cacheError) {
      bool isConnected = await networkInfo.isConnected;
      if (isConnected) {
        try {
          final response = await remoteDataSource.getStoreDetails();
          if (response.status == ApiInternalStatus.SUCCESS) {
            localDataSource.saveStoreDetailsToCache(response);
            return Right(response.toDomain());
          } else {
            return Left(Failure(response.status ?? ResponseCode.DEFAULT,
                response.message ?? ResponseMessage.DEFAULT));
          }
        } catch (error) {
          return Left(ErrorHandler.handle(error).failure);
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    }
  }
}
