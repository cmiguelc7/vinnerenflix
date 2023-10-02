import 'package:flutter/material.dart';
import 'package:vinnerenflix/movies/movies_data.dart';

class MovieDialog {
  static Future<void> showMovieDialog(BuildContext context, Movie movie) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.white,
            insetAnimationDuration: const Duration(milliseconds: 100),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              height: 200,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: Image.network(movie.poster)),
                  SizedBox(
                    width: 20,
                  ),
                  SingleChildScrollView(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.53,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                              '${movie.director} (${movie.country}, ${movie.year})',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16)),
                          Text(movie.genre,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.blue[900])),
                          SizedBox(
                            height: 20,
                          ),
                          Text('Sinopsis',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.blue[700])),
                          Text(
                            movie.plot,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
