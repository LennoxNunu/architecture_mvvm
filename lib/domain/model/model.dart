import 'package:equatable/equatable.dart';

class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class Customer extends Equatable {
  final String id;
  final String name;
  final int numOfNotifications;

  const Customer(this.id, this.name, this.numOfNotifications);

  @override
  List<Object?> get props => [id, name, numOfNotifications];
}

class Contacts extends Equatable {
  final String email;
  final String phone;
  final String link;

  const Contacts(this.email, this.phone, this.link);

  @override
  List<Object?> get props => [email, phone, link];
}

class Authentication extends Equatable {
  final Customer? customer;
  final Contacts? contacts;

  const Authentication(this.customer, this.contacts);

  @override
  List<Object?> get props => [customer, contacts];
}

class DeviceInfo extends Equatable {
  final String name;
  final String identifier;
  final String version;

  const DeviceInfo(this.name, this.identifier, this.version);

  @override
  List<Object?> get props => [name, identifier, version];
}

class Service extends Equatable {
  final int id;
  final String title;
  final String image;

  const Service(this.id, this.title, this.image);

  @override
  List<Object?> get props => [id, title, image];
}

class Store extends Equatable {
  final int id;
  final String title;
  final String image;

  const Store(this.id, this.title, this.image);

  @override
  List<Object?> get props => [id, title, image];
}

class BannerAd extends Equatable {
  final int id;
  final String title;
  final String image;
  final String link;

  const BannerAd(this.id, this.title, this.image, this.link);

  @override
  List<Object?> get props => [id, title, image, link];
}

class HomeData extends Equatable {
  final List<Service> services;
  final List<Store> stores;
  final List<BannerAd> banners;

  const HomeData(this.services, this.stores, this.banners);

  @override
  List<Object?> get props => [services, stores, banners];
}

class HomeObject extends Equatable {
  final HomeData data;

  const HomeObject(this.data);

  @override
  List<Object?> get props => [data];
}

class StoreDetails extends Equatable {
  int id;
  String title;
  String image;
  String details;
  String services;
  String about;

  StoreDetails(
      this.id, this.title, this.image, this.details, this.services, this.about);

  @override
  List<Object?> get props => [
        id,
        title,
        image,
        details,
        services,
        about,
      ];
}
