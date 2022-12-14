// Mocks generated by Mockito 5.3.0 from annotations
// in architecture_mvvm/test/data/repository/repository_impl_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:architecture_mvvm/core/network/network_info.dart' as _i7;
import 'package:architecture_mvvm/data/data_source/local_data_source.dart'
    as _i6;
import 'package:architecture_mvvm/data/data_source/remote_data_source.dart'
    as _i3;
import 'package:architecture_mvvm/data/models/request/request.dart' as _i5;
import 'package:architecture_mvvm/data/models/responses/responses.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeAuthenticationResponse_0 extends _i1.SmartFake
    implements _i2.AuthenticationResponse {
  _FakeAuthenticationResponse_0(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeForgotPasswordResponse_1 extends _i1.SmartFake
    implements _i2.ForgotPasswordResponse {
  _FakeForgotPasswordResponse_1(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeHomeResponse_2 extends _i1.SmartFake implements _i2.HomeResponse {
  _FakeHomeResponse_2(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

class _FakeStoreDetailsResponse_3 extends _i1.SmartFake
    implements _i2.StoreDetailsResponse {
  _FakeStoreDetailsResponse_3(Object parent, Invocation parentInvocation)
      : super(parent, parentInvocation);
}

/// A class which mocks [RemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoteDataSource extends _i1.Mock implements _i3.RemoteDataSource {
  @override
  _i4.Future<_i2.AuthenticationResponse> login(_i5.LoginRequest? loginRequest) =>
      (super.noSuchMethod(Invocation.method(#login, [loginRequest]),
              returnValue: _i4.Future<_i2.AuthenticationResponse>.value(
                  _FakeAuthenticationResponse_0(
                      this, Invocation.method(#login, [loginRequest]))),
              returnValueForMissingStub: _i4.Future<_i2.AuthenticationResponse>.value(
                  _FakeAuthenticationResponse_0(
                      this, Invocation.method(#login, [loginRequest]))))
          as _i4.Future<_i2.AuthenticationResponse>);
  @override
  _i4.Future<_i2.AuthenticationResponse> register(_i5.RegisterRequest? registerRequest) =>
      (super.noSuchMethod(Invocation.method(#register, [registerRequest]),
              returnValue: _i4.Future<_i2.AuthenticationResponse>.value(
                  _FakeAuthenticationResponse_0(
                      this, Invocation.method(#register, [registerRequest]))),
              returnValueForMissingStub: _i4.Future<_i2.AuthenticationResponse>.value(
                  _FakeAuthenticationResponse_0(
                      this, Invocation.method(#register, [registerRequest]))))
          as _i4.Future<_i2.AuthenticationResponse>);
  @override
  _i4.Future<_i2.ForgotPasswordResponse> forgotPassword(String? email) =>
      (super.noSuchMethod(Invocation.method(#forgotPassword, [email]),
              returnValue: _i4.Future<_i2.ForgotPasswordResponse>.value(
                  _FakeForgotPasswordResponse_1(
                      this, Invocation.method(#forgotPassword, [email]))),
              returnValueForMissingStub:
                  _i4.Future<_i2.ForgotPasswordResponse>.value(
                      _FakeForgotPasswordResponse_1(
                          this, Invocation.method(#forgotPassword, [email]))))
          as _i4.Future<_i2.ForgotPasswordResponse>);
  @override
  _i4.Future<_i2.HomeResponse> getHome() =>
      (super.noSuchMethod(Invocation.method(#getHome, []),
              returnValue: _i4.Future<_i2.HomeResponse>.value(
                  _FakeHomeResponse_2(this, Invocation.method(#getHome, []))),
              returnValueForMissingStub: _i4.Future<_i2.HomeResponse>.value(
                  _FakeHomeResponse_2(this, Invocation.method(#getHome, []))))
          as _i4.Future<_i2.HomeResponse>);
  @override
  _i4.Future<_i2.StoreDetailsResponse> getStoreDetails() => (super.noSuchMethod(
          Invocation.method(#getStoreDetails, []),
          returnValue: _i4.Future<_i2.StoreDetailsResponse>.value(
              _FakeStoreDetailsResponse_3(
                  this, Invocation.method(#getStoreDetails, []))),
          returnValueForMissingStub: _i4.Future<_i2.StoreDetailsResponse>.value(
              _FakeStoreDetailsResponse_3(
                  this, Invocation.method(#getStoreDetails, []))))
      as _i4.Future<_i2.StoreDetailsResponse>);
}

/// A class which mocks [LocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalDataSource extends _i1.Mock implements _i6.LocalDataSource {
  @override
  _i4.Future<_i2.HomeResponse> getHome() =>
      (super.noSuchMethod(Invocation.method(#getHome, []),
              returnValue: _i4.Future<_i2.HomeResponse>.value(
                  _FakeHomeResponse_2(this, Invocation.method(#getHome, []))),
              returnValueForMissingStub: _i4.Future<_i2.HomeResponse>.value(
                  _FakeHomeResponse_2(this, Invocation.method(#getHome, []))))
          as _i4.Future<_i2.HomeResponse>);
  @override
  _i4.Future<void> saveHomeToCache(_i2.HomeResponse? homeResponse) =>
      (super.noSuchMethod(Invocation.method(#saveHomeToCache, [homeResponse]),
              returnValue: _i4.Future<void>.value(),
              returnValueForMissingStub: _i4.Future<void>.value())
          as _i4.Future<void>);
  @override
  void clearCache() => super.noSuchMethod(Invocation.method(#clearCache, []),
      returnValueForMissingStub: null);
  @override
  void removeFromCache(String? key) =>
      super.noSuchMethod(Invocation.method(#removeFromCache, [key]),
          returnValueForMissingStub: null);
  @override
  _i4.Future<_i2.StoreDetailsResponse> getStoreDetails() => (super.noSuchMethod(
          Invocation.method(#getStoreDetails, []),
          returnValue: _i4.Future<_i2.StoreDetailsResponse>.value(
              _FakeStoreDetailsResponse_3(
                  this, Invocation.method(#getStoreDetails, []))),
          returnValueForMissingStub: _i4.Future<_i2.StoreDetailsResponse>.value(
              _FakeStoreDetailsResponse_3(
                  this, Invocation.method(#getStoreDetails, []))))
      as _i4.Future<_i2.StoreDetailsResponse>);
  @override
  _i4.Future<void> saveStoreDetailsToCache(
          _i2.StoreDetailsResponse? response) =>
      (super.noSuchMethod(
              Invocation.method(#saveStoreDetailsToCache, [response]),
              returnValue: _i4.Future<void>.value(),
              returnValueForMissingStub: _i4.Future<void>.value())
          as _i4.Future<void>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i7.NetworkInfo {
  @override
  _i4.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
              returnValue: _i4.Future<bool>.value(false),
              returnValueForMissingStub: _i4.Future<bool>.value(false))
          as _i4.Future<bool>);
}
