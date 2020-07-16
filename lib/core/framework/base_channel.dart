import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

typedef ExceptionOrDefault<T> = T Function(dynamic error);

const CHANNEL_PREFIX = 'com.luxinfity.asetku/';

class BaseChannel {
  final MethodChannel channel;
  final String channelName;

  BaseChannel(this.channelName)
      : this.channel = MethodChannel(CHANNEL_PREFIX + channelName);

  @protected
  Future<T> execute<T>(
    String actionName, {
    dynamic arguments,
    ExceptionOrDefault<T> errorOr,
  }) async {
    try {
      return await channel.invokeMethod<T>(actionName, arguments);
    } catch (error) {
      if (errorOr != null) return errorOr(error);
      throw error;
    }
  }
}
