import 'package:flutter/material.dart';

class HomeHelper {
  static String getErrorMessage(BuildContext context, String errorCode) {
    return switch (errorCode) {
      'unsupported-code' => 'Currency code not supported.',
      'malformed-request' => 'Invalid request. Check the parameters and try again.',
      'invalid-key' => 'Invalid API key. Please check the configuration and try again.',
      'inactive-account' => 'Account inactive. Please check your email and try again.',
      'quota-reached' => 'You have reached the limit of available requests.',
      _ => 'An unexpected error occurred. Please try again later.',
    };
  }
}
