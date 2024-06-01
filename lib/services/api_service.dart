import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/theme/colors.dart';
import 'package:flutter_app/util/constants.dart';
import 'package:get/get.dart';

import '../exceptions/force_logout_exception.dart';
import 'auth_service.dart';

class ApiService extends GetConnect {
  final AuthService authService = Get.find<AuthService>();

  @override
  void onInit() {
    super.onInit();
    httpClient.baseUrl = Constants.baseUrl;
    httpClient.timeout = const Duration(seconds: 10);
  }

  // Function to send a GET request
  Future<Response<T>?> sendGetRequest<T>(
    bool isAuthRequired,
    String endpoint, {
    Map<String, String>? headers = const {},
    Map<String, dynamic>? query = const {},
    T Function(dynamic)? decoder,
  }) async {
    try {
      final response = await get(
        endpoint,
        headers: {
          ...headers ?? {},
          if (isAuthRequired)
            'Authorization': 'Bearer ${authService.getBearerToken()}',
          if (isAuthRequired) 'x-access-token': authService.getBearerToken(),
            'x-access-token': authService.getBearerToken(),
        },
        query: query,
        decoder: decoder,
      );

      print(response.toString());

      if (kDebugMode) {
        print(response.statusCode);
        print(response.bodyString);
      }

      if (response.statusCode == null) {
        throw Exception("No response, check your internet connection");
      }

      if (response.statusCode == HttpStatus.unauthorized) {
        throw ForceLogoutException("Unauthorized");
      }

      return response;
    } catch (error) {
      _handleError(error);
      return null;
    }
  }

  // Function to send a POST request
  Future<Response<T>?> sendPostRequest<T>(
    bool isAuthRequired,
    String endpoint, {
    dynamic data,
    Map<String, String>? headers = const {},
    Map<String, dynamic>? query = const {},
    T Function(dynamic)? decoder,
  }) async {
    try {
      if (isAuthRequired) {
        print('Bearer ${authService.getBearerToken()}');
      }

      print(data.toString());

      final response = await post(
        endpoint,
        data,
        headers: {
          ...headers ?? {},
          if (isAuthRequired)
            'Authorization': 'Bearer ${authService.getBearerToken()}',
          if (isAuthRequired) 'x-access-token': authService.getBearerToken(),
        },
        query: query,
        decoder: decoder,
      );

      if (kDebugMode) {
        print(response.statusCode);
        print(response.bodyString);
      }

      if (response.statusCode == null) {
        throw Exception("No response, check your internet connection");
      }

      if (response.statusCode == HttpStatus.unauthorized) {
        throw ForceLogoutException("Unauthorized");
      }

      return response;
    } catch (error) {
      _handleError(error);
      return null;
    }
  }

  // Function to send a PATCH request
  Future<Response<T>?> sendPatchRequest<T>(
      bool isAuthRequired,
      String endpoint, {
        dynamic data,
        Map<String, String>? headers = const {},
        Map<String, dynamic>? query = const {},
        T Function(dynamic)? decoder,
      }) async {
    try {
      final response = await patch(
        endpoint,
        data,
        headers: {
          ...headers ?? {},
          if (isAuthRequired)
            'x-access-token': authService.getBearerToken(),
        },
        query: query,
        decoder: decoder,
      );

      if (kDebugMode) {
        print(response.statusCode);
        print(response.bodyString);
      }

      if (response.statusCode == null) {
        throw Exception("No response, check your internet connection");
      }

      if (response.statusCode == HttpStatus.unauthorized) {
        throw ForceLogoutException("Unauthorized");
      }

      return response;
    } catch (error) {
      _handleError(error);
      return null;
    }
  }


  void _handleError(dynamic error) {
    if (error is SocketException) {
      // Handle network/socket errors
      Get.snackbar(
        'Error',
        'Network error occurred',
        colorText: Colors.white,
        backgroundColor: WorkWiseColors.darkGreyColor.withOpacity(0.9),
      );
    } else if (error is TimeoutException) {
      // Handle timeout errors
      Get.snackbar(
        'Error',
        'Request timed out',
        colorText: Colors.white,
        backgroundColor: WorkWiseColors.darkGreyColor.withOpacity(0.9),
      );
    } else {
      if (kDebugMode) {
        print(error);
      }
      // Handle other errors
      Get.snackbar(
        'Error',
        error.toString().replaceAll('Exception: ', ''),
        colorText: Colors.white,
        backgroundColor: WorkWiseColors.darkGreyColor.withOpacity(0.9),
      );

      // Check if the error indicates a need for force logout
      if (error is ForceLogoutException) {
        authService.forceLogout();
      }
    }
  }
}
