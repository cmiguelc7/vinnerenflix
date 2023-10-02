import 'package:vinnerenflix/search/search_data.dart';

import '../movies/movies_data.dart';
import 'package:http/http.dart' as http;

class SearchProvider {
  Future<List<MoviesData>?> getData({required String query}) async {
    final url = Uri.https('api.npoint.io', 'a2f95a2c6638a71539da');
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      final responseData = searchResponseDataFromJson(resp.body);
      return responseData.data;
    }
    return null;
  }
}
