import 'package:architecture_mvvm/core/devicedetails/device_details.dart';
import 'package:architecture_mvvm/domain/model/model.dart';
import 'package:flutter/services.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:device_info/device_info.dart';
import 'package:platform/platform.dart';

import 'device_details_test.mocks.dart';

class MyPlatformException extends PlatformException {
  MyPlatformException({required super.code});
}

@GenerateNiceMocks([MockSpec<DeviceInfoPlugin>(), MockSpec<LocalPlatform>()])
void main() {
  late DeviceDetailsImplementer deviceDetailsImplementer;
  late MockDeviceInfoPlugin mockDeviceInfoPlugin;
  late MockLocalPlatform mockLocalPlatform;

  setUp(() {
    mockLocalPlatform = MockLocalPlatform();
    mockDeviceInfoPlugin = MockDeviceInfoPlugin();
    deviceDetailsImplementer = DeviceDetailsImplementer(
        deviceInfoPlugin: mockDeviceInfoPlugin,
        localPlatform: mockLocalPlatform);
  });

  group('getDeviceDetails -', () {
    test(
      'when Platform is Android , verify deviceInfoPlugin.androidInfo is called',
      () async {
        //arrange
        when(mockLocalPlatform.isAndroid).thenReturn(true);
        //act
        await deviceDetailsImplementer.getDeviceDetails();
        //await mockdeviceInfoPlugin.androidInfo;
        //asset
        verify(mockDeviceInfoPlugin.androidInfo).called(1);
      },
    );

    test(
      'when Platform is IOS , verify deviceInfoPlugin.iosInfo is called',
      () async {
        //arrange
        when(mockLocalPlatform.isIOS).thenReturn(true);
        //act
        await deviceDetailsImplementer.getDeviceDetails();
        //await mockdeviceInfoPlugin.androidInfo;
        //asset
        verify(mockDeviceInfoPlugin.iosInfo).called(1);
      },
    );

    test(
      'when errors occurs on Android , return DeviceInfo("Unknown", "Unknown", "Unknown")',
      () async {
        //arrange
        DeviceInfo deviceinfo =
            const DeviceInfo("Unknown", "Unknown", "Unknown");
        when(mockLocalPlatform.isAndroid).thenReturn(true);
        when(mockDeviceInfoPlugin.androidInfo)
            .thenThrow(MyPlatformException(code: ''));
        //act
        var result = await deviceDetailsImplementer.getDeviceDetails();

        //asset

        expect(result, deviceinfo);
      },
    );

    test(
      'when errors occurs on IOS, return DeviceInfo("Unknown", "Unknown", "Unknown")',
      () async {
        //arrange
        DeviceInfo deviceinfo =
            const DeviceInfo("Unknown", "Unknown", "Unknown");
        when(mockLocalPlatform.isAndroid).thenReturn(true);
        when(mockDeviceInfoPlugin.androidInfo)
            .thenThrow(MyPlatformException(code: ''));
        //act
        var result = await deviceDetailsImplementer.getDeviceDetails();

        //asset

        expect(result, deviceinfo);
      },
    );

    test(
      'when Platform is not android or ios , return DeviceInfo("Unknown", "Unknown", "Unknown")',
      () async {
        //arrange
        DeviceInfo deviceinfo =
            const DeviceInfo("Unknown", "Unknown", "Unknown");

        when(mockLocalPlatform.isAndroid).thenReturn(false);
        when(mockLocalPlatform.isIOS).thenReturn(false);
        //act
        var result = await deviceDetailsImplementer.getDeviceDetails();

        //asset

        verifyNever(mockDeviceInfoPlugin.androidInfo);
        verifyNever(mockDeviceInfoPlugin.iosInfo);
        expect(result, deviceinfo);
      },
    );
  });
}
