import 'package:flutter/material.dart';
import 'package:vinnerenflix/movies/movie_modal.dart';
import 'package:vinnerenflix/search/search_provider..dart';

import '../movies/movies_data.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key, required this.query});

  final String query;

  final _provider = SearchProvider();

  Future<List<MoviesData>> _fetchData() async {
    final dataMovies = await _provider.getData(query: query);
    print(dataMovies);
    return dataMovies ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Resultados",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(child: _buildFutureSearch()),
      ),
    );
  }

  Widget _buildFutureSearch() {
    return FutureBuilder(
      future: _fetchData(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          final moviesData = snapshot.data ?? [];
          if (moviesData.isEmpty) {
            return Container(
              child: Text("Búsqueda sin resultados"),
            );
          }
          return _buildResultList(moviesData);
        } else if (snapshot.hasError) {
          return Container(
            child: Text("Ocurrió un error al recibir la información"),
          );
        } else {
          return CircularProgressIndicator(
            color: Colors.white,
          );
        }
      }),
    );
  }

  Widget _buildResultList(List<MoviesData> moviesData) {
    final data = moviesData[0];
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      itemCount: data.movies.length,
      itemBuilder: ((context, index) {
        final movieData = data.movies[index];
        return GestureDetector(
          onTap: () => MovieDialog.showMovieDialog(context, movieData),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Image.network(movieData.poster)),
                  SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movieData.title,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                        Text(
                            '${movieData.director} (${movieData.country}, ${movieData.year})',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white)),
                      ],
                    ),
                  )
                ],
              ),
              Divider(),
            ],
          ),
        );
      }),
    );
  }
}
