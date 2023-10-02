import 'package:vinnerenflix/movies/movies_data.dart';
import 'package:http/http.dart' as http;

class MovieProvider {
  Future<List<MoviesData>?> getData() async {
    final url = Uri.https('api.npoint.io', '41d9847b3be7c092b860');
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      final responseData = responseDataFromJson(resp.body);
      return responseData.data;
    }
    return null;
  }
}
