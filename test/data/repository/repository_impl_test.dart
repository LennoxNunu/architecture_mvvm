import 'package:architecture_mvvm/core/network/failure.dart';
import 'package:architecture_mvvm/core/network/network_info.dart';
import 'package:architecture_mvvm/data/data_source/local_data_source.dart';
import 'package:architecture_mvvm/data/data_source/remote_data_source.dart';
import 'package:architecture_mvvm/data/models/request/request.dart';
import 'package:architecture_mvvm/data/models/responses/responses.dart';
import 'package:architecture_mvvm/data/repository/repository_impl.dart';
import 'package:architecture_mvvm/domain/model/model.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<RemoteDataSource>(),
  MockSpec<LocalDataSource>(),
  MockSpec<NetworkInfo>()
])
void main() {
  late RepositoryImpl repositoryImpl;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repositoryImpl = RepositoryImpl(
        localDataSource: mockLocalDataSource,
        networkInfo: mockNetworkInfo,
        remoteDataSource: mockRemoteDataSource);
  });

  group('login -', () {
    const LoginRequest loginRequest = LoginRequest(
        'any@email.com', 'anyPassword', 'anyImei', 'anyDeviceType');

    test(
      'verify networkInfo.isConnected is called',
      () async {
        // arrange

        // act
        await repositoryImpl.login(loginRequest);

        // assert
        verify(mockNetworkInfo.isConnected).called(1);
      },
    );

    test(
      'when device is connected, verify remoteDataSource.login(loginRequest) is called',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        await repositoryImpl.login(loginRequest);

        // assert
        verify(mockRemoteDataSource.login(loginRequest)).called(1);
      },
    );

    test(
      'when device is connected and remoteDataSource.login(loginRequest) is called, return Authentication ',
      () async {
        CustomerResponse customerResponse = CustomerResponse('', '', 0);
        ContactsResponse contactsResponse = ContactsResponse('', '', '');
        AuthenticationResponse authenticationResponse =
            AuthenticationResponse(customerResponse, contactsResponse)
              ..status = 0;

        const Customer customer = Customer('', '', 0);
        const Contacts contacts = Contacts('', '', '');
        const Authentication authentication =
            Authentication(customer, contacts);

        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.login(loginRequest))
            .thenAnswer((_) async => authenticationResponse);

        // act
        var result = await repositoryImpl.login(loginRequest);

        // assert
        expect(result, const Right(authentication));
      },
    );

    test(
      'when device is connected and remoteDataSource.login(loginRequest) is called, return Failure in the Authentication model',
      () async {
        CustomerResponse customerResponse = CustomerResponse('', '', 0);
        ContactsResponse contactsResponse = ContactsResponse('', '', '');
        AuthenticationResponse authenticationResponse =
            AuthenticationResponse(customerResponse, contactsResponse)
              ..status = 1;

        const Failure failure = Failure(1, 'default_error');
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.login(loginRequest))
            .thenAnswer((_) async => authenticationResponse);

        // act
        var result = await repositoryImpl.login(loginRequest);

        // assert
        expect(result, const Left(failure));
      },
    );

    test(
      'when device is connected and remoteDataSource.login(loginRequest) is called, return Failure from server',
      () async {
        const Failure failure = Failure(-1, 'default_error');
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.login(loginRequest)).thenThrow(Object());

        // act
        var result = await repositoryImpl.login(loginRequest);

        // assert
        expect(result, const Left(failure));
      },
    );

    test(
      'when device is disconnected, return Failure ',
      () async {
        const Failure failure = Failure(-7, 'no_internet_error');
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(mockRemoteDataSource.login(loginRequest)).thenThrow(Object());

        // act
        var result = await repositoryImpl.login(loginRequest);

        // assert
        expect(result, const Left(failure));
      },
    );
  });

  group('forgotPassword -', () {
    const String email = 'any@gmail.com';
    test(
      'verify networkInfo.isConnected is called',
      () async {
        // arrange

        // act
        await repositoryImpl.forgotPassword(email);

        // assert
        verify(mockNetworkInfo.isConnected).called(1);
      },
    );

    test(
      'when device is connected, verify remoteDataSource.forgotPassword(email) is called',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        await repositoryImpl.forgotPassword(email);

        // assert
        verify(mockRemoteDataSource.forgotPassword(email)).called(1);
      },
    );

    test(
      'when device is connected and remoteDataSource.forgotPassword(email) is called, return String ',
      () async {
        ForgotPasswordResponse forgotPasswordResponse =
            ForgotPasswordResponse('')..status = 0;

        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.forgotPassword(email))
            .thenAnswer((_) async => forgotPasswordResponse);

        // act
        var result = await repositoryImpl.forgotPassword(email);

        // assert
        expect(result, const Right(''));
      },
    );

    test(
      'when device is connected and remoteDataSource.forgotPassword(email) is called, return Failure in the String model',
      () async {
        ForgotPasswordResponse forgotPasswordResponse =
            ForgotPasswordResponse('')..status = 1;

        const Failure failure = Failure(1, 'default_error');

        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.forgotPassword(email))
            .thenAnswer((_) async => forgotPasswordResponse);

        // act
        var result = await repositoryImpl.forgotPassword(email);

        // assert
        expect(result, const Left(failure));
      },
    );

    test(
      'when device is connected and remoteDataSource.forgotPassword(email) is called, return Failure from server',
      () async {
        const Failure failure = Failure(-1, 'default_error');

        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.forgotPassword(email)).thenThrow(Object());

        // act
        var result = await repositoryImpl.forgotPassword(email);

        // assert
        expect(result, const Left(failure));
      },
    );

    test(
      'when device is disconnected, return Failure ',
      () async {
        const Failure failure = Failure(-7, 'no_internet_error');
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(mockRemoteDataSource.forgotPassword(email)).thenThrow(Object());

        // act
        var result = await repositoryImpl.forgotPassword(email);

        // assert
        expect(result, const Left(failure));
      },
    );
  });

  group('register -', () {
    const RegisterRequest registerRequest = RegisterRequest(
        'anyCountryMobileCode',
        'anyUserName',
        'anyEmail',
        'anyPassword',
        'anyProfilePicture',
        'anyMobileNumber');
    test(
      'verify networkInfo.isConnected is called',
      () async {
        // arrange

        // act
        await repositoryImpl.register(registerRequest);

        // assert
        verify(mockNetworkInfo.isConnected).called(1);
      },
    );

    test(
      'when device is connected, verify remoteDataSource.register(registerRequest) is called',
      () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        // act
        await repositoryImpl.register(registerRequest);

        // assert
        verify(mockRemoteDataSource.register(registerRequest)).called(1);
      },
    );

    test(
      'when device is connected and remoteDataSource.register(registerRequest) is called, return Authentication ',
      () async {
        CustomerResponse customerResponse = CustomerResponse('', '', 0);
        ContactsResponse contactsResponse = ContactsResponse('', '', '');
        AuthenticationResponse authenticationResponse =
            AuthenticationResponse(customerResponse, contactsResponse)
              ..status = 0;

        const Customer customer = Customer('', '', 0);
        const Contacts contacts = Contacts('', '', '');
        const Authentication authentication =
            Authentication(customer, contacts);

        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.register(registerRequest))
            .thenAnswer((_) async => authenticationResponse);

        // act
        var result = await repositoryImpl.register(registerRequest);

        // assert
        expect(result, const Right(authentication));
      },
    );

    test(
      'when device is connected and remoteDataSource.register(registerRequest) is called, return Failure in the Authentication model',
      () async {
        CustomerResponse customerResponse = CustomerResponse('', '', 0);
        ContactsResponse contactsResponse = ContactsResponse('', '', '');
        AuthenticationResponse authenticationResponse =
            AuthenticationResponse(customerResponse, contactsResponse)
              ..status = 1;

        const Failure failure = Failure(1, 'default_error');
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.register(registerRequest))
            .thenAnswer((_) async => authenticationResponse);

        // act
        var result = await repositoryImpl.register(registerRequest);

        // assert
        expect(result, const Left(failure));
      },
    );

    test(
      'when device is connected and remoteDataSource.register(registerRequest) is called, return Failure from server',
      () async {
        const Failure failure = Failure(-1, 'default_error');
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.register(registerRequest))
            .thenThrow(Object());

        // act
        var result = await repositoryImpl.register(registerRequest);

        // assert
        expect(result, const Left(failure));
      },
    );

    test(
      'when device is disconnected, return Failure ',
      () async {
        const Failure failure = Failure(-7, 'no_internet_error');
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
        when(mockRemoteDataSource.register(registerRequest))
            .thenThrow(Object());

        // act
        var result = await repositoryImpl.register(registerRequest);

        // assert
        expect(result, const Left(failure));
      },
    );
  });

  group('getHome -', () {
    test(
      'verify LocalDataSource.getHome() is called',
      () async {
        // arrange

        // act
        await repositoryImpl.getHome();

        // assert
        verify(mockLocalDataSource.getHome()).called(1);
      },
    );

    test(
      'when LocalDataSource.getHome() is called, return HomeResponse',
      () async {
        const HomeDataResponse homeDataResponse = HomeDataResponse(
            <ServiceResponse>[], <StoreResponse>[], <BannerResponse>[]);

        HomeResponse homeResponse = HomeResponse(homeDataResponse);

        const HomeData homeData =
            HomeData(<Service>[], <Store>[], <BannerAd>[]);

        const HomeObject homeObject = HomeObject(homeData);

        // arrange
        when(mockLocalDataSource.getHome())
            .thenAnswer((_) async => homeResponse);
        // act
        var result = await repositoryImpl.getHome();

        // assert
        expect(result, const Right(homeObject));
      },
    );

    test(
      'when LocalDataSource.getHome() throws error, verify NetworkInfo.isConnected is called ',
      () async {
        // arrange
        when(mockLocalDataSource.getHome()).thenThrow(Object());
        // act
        await repositoryImpl.getHome();

        // assert
        verify(mockNetworkInfo.isConnected).called(1);
      },
    );

    test(
      'when LocalDataSource.getHome() throws error and NetworkInfo.isConnected is true, verify remoteDataSource.getHome() is called ',
      () async {
        // arrange
        when(mockLocalDataSource.getHome()).thenThrow(Object());
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        // act
        await repositoryImpl.getHome();

        // assert
        verify(mockRemoteDataSource.getHome()).called(1);
      },
    );

    test(
      'when LocalDataSource.getHome() throws error and NetworkInfo.isConnected is true, when remoteDataSource.getHome() is called, return HomeResponse',
      () async {
        // arrange
        when(mockLocalDataSource.getHome()).thenThrow(Object());
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        // act
        await repositoryImpl.getHome();

        // assert
        verify(mockRemoteDataSource.getHome()).called(1);
      },
    );

    test(
      'when LocalDataSource.getHome() throws error and NetworkInfo.isConnected is true, and remoteDataSource.getHome() is HomeResponse, verify localDataSource.saveHomeToCache(response) is called',
      () async {
        const HomeDataResponse homeDataResponse = HomeDataResponse(
            <ServiceResponse>[], <StoreResponse>[], <BannerResponse>[]);

        HomeResponse homeResponse = HomeResponse(homeDataResponse)..status = 0;

        // arrange
        when(mockLocalDataSource.getHome()).thenThrow(Object());
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.getHome())
            .thenAnswer((_) async => homeResponse);
        // act
        await repositoryImpl.getHome();

        // assert
        verify(mockLocalDataSource.saveHomeToCache(homeResponse)).called(1);
      },
    );

    test(
      'when LocalDataSource.getHome() throws error and NetworkInfo.isConnected is true, and remoteDataSource.getHome() is HomeResponse, return HomeObject',
      () async {
        const HomeDataResponse homeDataResponse = HomeDataResponse(
            <ServiceResponse>[], <StoreResponse>[], <BannerResponse>[]);

        HomeResponse homeResponse = HomeResponse(homeDataResponse)..status = 0;

        const HomeData homeData =
            HomeData(<Service>[], <Store>[], <BannerAd>[]);

        const HomeObject homeObject = HomeObject(homeData);

        // arrange
        when(mockLocalDataSource.getHome()).thenThrow(Object());
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.getHome())
            .thenAnswer((_) async => homeResponse);
        // act
        var result = await repositoryImpl.getHome();

        // assert
        expect(result, const Right(homeObject));
      },
    );

    test(
      'when LocalDataSource.getHome() throws error and NetworkInfo.isConnected is true, and remoteDataSource.getHome() is HomeResponse, return HomeObject with failure',
      () async {
        const HomeDataResponse homeDataResponse = HomeDataResponse(
            <ServiceResponse>[], <StoreResponse>[], <BannerResponse>[]);

        HomeResponse homeResponse = HomeResponse(homeDataResponse)..status = 1;

        const Failure failure = Failure(1, 'default_error');

        // arrange
        when(mockLocalDataSource.getHome()).thenThrow(Object());
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.getHome())
            .thenAnswer((_) async => homeResponse);
        // act
        var result = await repositoryImpl.getHome();

        // assert
        expect(result, const Left(failure));
      },
    );

    test(
      'when LocalDataSource.getHome() throws error and NetworkInfo.isConnected is true, and remoteDataSource.getHome() throws error , return Failure',
      () async {
        const Failure failure = Failure(-1, 'default_error');

        // arrange
        when(mockLocalDataSource.getHome()).thenThrow(Object());
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.getHome()).thenThrow(failure);
        // act
        var result = await repositoryImpl.getHome();

        // assert
        expect(result, const Left(failure));
      },
    );

    test(
      'when LocalDataSource.getHome() throws error and NetworkInfo.isConnected is false, return Failure',
      () async {
        const Failure failure = Failure(-7, 'no_internet_error');

        // arrange
        when(mockLocalDataSource.getHome()).thenThrow(Object());
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

        // act
        var result = await repositoryImpl.getHome();

        // assert
        expect(result, const Left(failure));
      },
    );
  });

  group('getStoreDetails -', () {
    test(
      'verify LocalDataSource.getStoreDetails() is called',
      () async {
        // arrange

        // act
        await repositoryImpl.getStoreDetails();

        // assert
        verify(mockLocalDataSource.getStoreDetails()).called(1);
      },
    );

    test(
      'when LocalDataSource.getStoreDetails() is called, return StoreDetailsResponse',
      () async {
        StoreDetailsResponse storeDetailsResponse = StoreDetailsResponse(
            0, 'anyTitle', 'anyImage', 'anyDetails', 'anyService', 'anyAbout');

        StoreDetails storeDetails = StoreDetails(
            0, 'anyTitle', 'anyImage', 'anyDetails', 'anyService', 'anyAbout');

        // arrange
        when(mockLocalDataSource.getStoreDetails())
            .thenAnswer((_) async => storeDetailsResponse);
        // act
        var result = await repositoryImpl.getStoreDetails();

        // assert
        expect(result, Right(storeDetails));
      },
    );

    test(
      'when LocalDataSource.getStoreDetails() throws error, verify NetworkInfo.isConnected is called ',
      () async {
        // arrange
        when(mockLocalDataSource.getStoreDetails()).thenThrow(Object());
        // act
        await repositoryImpl.getStoreDetails();

        // assert
        verify(mockNetworkInfo.isConnected).called(1);
      },
    );

    test(
      'when LocalDataSource.getStoreDetails() throws error and NetworkInfo.isConnected is true, verify remoteDataSource.getStoreDetails() is called ',
      () async {
        // arrange
        when(mockLocalDataSource.getStoreDetails()).thenThrow(Object());
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        // act
        await repositoryImpl.getStoreDetails();

        // assert
        verify(mockRemoteDataSource.getStoreDetails()).called(1);
      },
    );

    test(
      'when LocalDataSource.getStoreDetails() throws error and NetworkInfo.isConnected is true, when remoteDataSource.getStoreDetails() is called, return HomeResponse',
      () async {
        // arrange
        when(mockLocalDataSource.getStoreDetails()).thenThrow(Object());
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

        // act
        await repositoryImpl.getStoreDetails();

        // assert
        verify(mockRemoteDataSource.getStoreDetails()).called(1);
      },
    );

    test(
      'when LocalDataSource.getStoreDetails() throws error and NetworkInfo.isConnected is true, and remoteDataSource.getStoreDetails() is HomeResponse, verify localDataSource.saveHomeToCache(response) is called',
      () async {
        StoreDetailsResponse storeDetailsResponse = StoreDetailsResponse(
            0, 'anyTitle', 'anyImage', 'anyDetails', 'anyService', 'anyAbout')
          ..status = 0;

        // arrange
        when(mockLocalDataSource.getStoreDetails()).thenThrow(Object());
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.getStoreDetails())
            .thenAnswer((_) async => storeDetailsResponse);
        // act
        await repositoryImpl.getStoreDetails();

        // assert
        verify(mockLocalDataSource
                .saveStoreDetailsToCache(storeDetailsResponse))
            .called(1);
      },
    );

    test(
      'when LocalDataSource.getStoreDetails() throws error and NetworkInfo.isConnected is true, and remoteDataSource.getStoreDetails() is HomeResponse, return HomeObject',
      () async {
        StoreDetailsResponse storeDetailsResponse = StoreDetailsResponse(
            0, 'anyTitle', 'anyImage', 'anyDetails', 'anyService', 'anyAbout')
          ..status = 0;

        StoreDetails storeDetails = StoreDetails(
            0, 'anyTitle', 'anyImage', 'anyDetails', 'anyService', 'anyAbout');

        // arrange
        when(mockLocalDataSource.getStoreDetails()).thenThrow(Object());
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.getStoreDetails())
            .thenAnswer((_) async => storeDetailsResponse);
        // act
        var result = await repositoryImpl.getStoreDetails();

        // assert
        expect(result, Right(storeDetails));
      },
    );

    test(
      'when LocalDataSource.getStoreDetails() throws error and NetworkInfo.isConnected is true, and remoteDataSource.getStoreDetails() is StoreDetailsResponse, return StoreDetails with failure',
      () async {
        StoreDetailsResponse storeDetailsResponse = StoreDetailsResponse(
            0, 'anyTitle', 'anyImage', 'anyDetails', 'anyService', 'anyAbout')
          ..status = 1;

        const Failure failure = Failure(1, 'default_error');

        // arrange
        when(mockLocalDataSource.getStoreDetails()).thenThrow(Object());
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.getStoreDetails())
            .thenAnswer((_) async => storeDetailsResponse);
        // act
        var result = await repositoryImpl.getStoreDetails();

        // assert
        expect(result, const Left(failure));
      },
    );

    test(
      'when LocalDataSource.getStoreDetails() throws error and NetworkInfo.isConnected is true, and remoteDataSource.getStoreDetails() throws error , return Failure',
      () async {
        const Failure failure = Failure(-1, 'default_error');

        // arrange
        when(mockLocalDataSource.getStoreDetails()).thenThrow(Object());
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.getStoreDetails()).thenThrow(failure);
        // act
        var result = await repositoryImpl.getStoreDetails();

        // assert
        expect(result, const Left(failure));
      },
    );

    test(
      'when LocalDataSource.getStoreDetails() throws error and NetworkInfo.isConnected is false, return Failure',
      () async {
        const Failure failure = Failure(-7, 'no_internet_error');

        // arrange
        when(mockLocalDataSource.getStoreDetails()).thenThrow(Object());
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

        // act
        var result = await repositoryImpl.getStoreDetails();

        // assert
        expect(result, const Left(failure));
      },
    );
  });
}
