import 'package:aset_ku/core/network/network.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class FrameworkServiceLocator {
  const FrameworkServiceLocator();

  Future setupFrameworkLocator(GetImpl getX) async {
    // so a instance cab be shared accross repo
    getX.put<Uuid>(Uuid());

    getX.put<DioFactory>((option) => Dio(option));
    getX.put<DioFactory>((option) => Dio(option), tag: PING_DOMAIN);
  }
}
