import 'package:dio/dio.dart';
import 'article_models.dart';

class ApiService {
  final Dio _dio = Dio();
  final String baseUrl = 'http://192.168.0.173:8000/get_articles';

  Future<List<Article>> fetchArticles() async {
    try {
      Response response = await _dio.get(baseUrl);
      var data = response.data;
      List<dynamic> articlesJson = data['articles'];  // Access the 'articles' key to get the list
      return articlesJson.map((json) => Article.fromJson(json as Map<String, dynamic>)).toList();
    } catch (error) {
      print('Error fetching articles: $error');
      throw error;
    }
  }
}
