import 'package:flutter/material.dart';
import 'package:vinnerenflix/movies/movie_modal.dart';
import 'package:vinnerenflix/movies/movie_provider.dart';

import 'movies_data.dart';

class MoviesView extends StatelessWidget {
  MoviesView({super.key});
  final _provider = MovieProvider();

  Future<List<MoviesData>> _fetchData() async {
    final dataMovies = await _provider.getData();
    print(dataMovies);
    return dataMovies ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: double.infinity,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/slider.png',
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 20,
            ),
            _buildFutureCategories(),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFutureCategories() {
    return FutureBuilder(
      future: _fetchData(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          final moviesData = snapshot.data ?? [];
          if (moviesData.isEmpty) {
            return Container(
              child: Text("Ocurrió un error al recibir la información"),
            );
          }
          return _buildCategories(moviesData);
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

  Widget _buildCategories(List<MoviesData> moviesData) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      itemCount: moviesData.length,
      itemBuilder: ((context, index) {
        final movieData = moviesData[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movieData.category,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            Divider(),
            const SizedBox(
              height: 15,
            ),
            _buildCarouselCategory(movieData),
            const SizedBox(
              height: 15,
            ),
          ],
        );
      }),
    );
  }

  Widget _buildCarouselCategory(MoviesData movieData) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: movieData.movies.length,
        itemBuilder: ((context, index) {
          final movie = movieData.movies[index];
          return Row(
            children: [
              GestureDetector(
                onTap: () {
                  MovieDialog.showMovieDialog(context, movie);
                },
                child: Image.network(
                  movie.poster,
                  width: 100,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          );
        }),
      ),
    );
  }
}
