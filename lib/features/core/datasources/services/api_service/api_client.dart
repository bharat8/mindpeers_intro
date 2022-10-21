import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mindpeers_intro/features/core/datasources/failures/failures.dart';
import 'package:mindpeers_intro/features/core/datasources/services/api_service/endpoints.dart';

/// Custom Client for API calls with prefix Headers, URI
/// and Failures
class ApiClient {
  ///* GET Request
  static Future<http.Response> get(
    String endpoint,
  ) async {
    try {
      final response = await http
          .get(
            getUri(endpoint),
          )
          .timeout(timeLimit);

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Failure.serverError(
          code: response.statusCode,
          message: response.reasonPhrase,
        );
      }
    } on SocketException catch (_) {
      throw const Failure.connection();
    } on ServerError catch (e) {
      throw Failure.serverError(
        code: e.code,
        message: e.message,
      );
    } catch (e) {
      throw Failure.unexpected(
        e.toString(),
      );
    }
  }

  ///* POST Request
  static Future<http.Response> post(
    String endpoint, {
    Object? body,
  }) async {
    try {
      final response = await http
          .post(
            getUri(endpoint),
            body: body,
          )
          .timeout(timeLimit);

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Failure.serverError(
          code: response.statusCode,
          message: response.reasonPhrase,
        );
      }
    } on SocketException catch (_) {
      throw const Failure.connection();
    } on ServerError catch (e) {
      throw Failure.serverError(
        code: e.code,
        message: e.message,
      );
    } catch (e) {
      throw Failure.unexpected(
        e.toString(),
      );
    }
  }

  ///* DELETE Request
  static Future<http.Response> delete(
    String endpoint, {
    Object? body,
  }) async {
    try {
      final response = await http
          .delete(
            getUri(endpoint),
            body: body,
          )
          .timeout(timeLimit);

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Failure.serverError(
          code: response.statusCode,
          message: response.reasonPhrase,
        );
      }
    } on SocketException catch (_) {
      throw const Failure.connection();
    } on ServerError catch (e) {
      throw Failure.serverError(
        code: e.code,
        message: e.message,
      );
    } catch (e) {
      throw Failure.unexpected(
        e.toString(),
      );
    }
  }

  static Uri getUri(String endpoint) {
    return Uri.parse('${Endpoints.baseUrl}$endpoint');
  }
}

/// API request timeout duration
const timeLimit = Duration(milliseconds: 30000);
