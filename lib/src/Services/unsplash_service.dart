import 'dart:convert' as convert;

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models.dart';
import '../utils.dart';

class UnsplashService {
  final _baseUrl = 'https://api.unsplash.com';

  String _errorObtained(int statusCode) {
    String error = 'Ocurrió un error';

    switch (statusCode) {
      case 400:
        error = 'Error en la petición';
        break;
      case 401:
        error = 'Unauthorized';
        break;
      case 403:
        error = 'Forbidden';
        break;
      case 404:
        error = 'Page Not Found';
        break;
      case 408:
        error = 'Timeout';
        break;
      default:
        error = 'Ocurrió un error';
    }

    if (statusCode >= 500) error = 'Server error';

    return error;
  }

  Future<String> _sendRequest(String url) async {
    final uri = Uri.parse(url);
    final response = await http.get(uri).onError(
      (e, s) {
        return http.Response('', 400);
      },
    ).timeout(
      const Duration(seconds: 60),
      onTimeout: () {
        return http.Response('TIMEOUT', 408);
      },
    );
    final statusCode = response.statusCode;

    if (statusCode != 200) {
      throw Exception(_errorObtained(statusCode));
    }

    return convert.utf8.decode(response.bodyBytes);
  }

  Future<List<Photo>> getPhotoList({int? page}) async {
    String url = '$_baseUrl/photos?client_id=$apiKey';
    if (page != null) url += '&page=$page&per_page=30';

    final bodyStr = await _sendRequest(url);

    final List infoList = convert.json.decode(bodyStr);
    final photoList = infoList.map((e) => Photo.fromJson(e)).toList();

    if (kDebugMode) {
      print(bodyStr);
    }
    return photoList;
  }

  Future<List<Photo>> searchPhotos({int? page, required String query}) async {
    String url = '$_baseUrl/search/photos?client_id=$apiKey';
    if (page != null) url += '&page=$page&per_page=30&query=$query';

    final bodyStr = await _sendRequest(url);
    final Map<String, dynamic> info = convert.json.decode(bodyStr);
    final List infoList = info['results'];
    final photoList = infoList.map((e) => Photo.fromJson(e)).toList();

    if (kDebugMode) {
      print(bodyStr);
    }
    return photoList;
  }

  Future<Photo> likeAPhoto({required String id}) async {
    String url = '$_baseUrl/photos/:$id/like?client_id=$apiKey';

    final uri = Uri.parse(url);
    final response = await http.post(uri).onError(
      (e, s) {
        return http.Response('', 400);
      },
    ).timeout(
      const Duration(seconds: 60),
      onTimeout: () {
        return http.Response('TIMEOUT', 408);
      },
    );
    final statusCode = response.statusCode;

    if (statusCode != 201) {
      throw Exception(_errorObtained(statusCode));
    }
    final bodyStr = convert.utf8.decode(response.bodyBytes);
    final photoInfo = convert.json.decode(bodyStr);

    return Photo.fromJson(photoInfo);
  }

  Future<List<Photo>> listLikedPhotos({int? page}) async {
    String url = '$_baseUrl/users/$username/likes?client_id=$apiKey';
    if (page != null) url += '&page=$page&per_page=30';

    final bodyStr = await _sendRequest(url);
    final List infoList = convert.json.decode(bodyStr);
    final photoList = infoList.map((e) => Photo.fromJson(e)).toList();

    if (kDebugMode) {
      print(bodyStr);
    }
    return photoList;
  }

  Future<List<Topic>> getTopicList() async {
    String url = '$_baseUrl/topics?client_id=$apiKey';
    final bodyStr = await _sendRequest(url);
    final List infoList = convert.json.decode(bodyStr);
    final topicList = infoList.map((e) => Topic.fromJson(e)).toList();

    if (kDebugMode) {
      print(bodyStr);
    }
    return topicList;
  }
}
