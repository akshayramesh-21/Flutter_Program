import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:geeksynergy/model/movies.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'movies_data_event.dart';
part 'movies_data_state.dart';

class MoviesDataBloc extends Bloc<MoviesDataEvent, MoviesDataState> {
  MoviesDataBloc() : super(MoviesDataInitial()) {
    on<MoviedataFetch>((event, emit) async {
      emit(MoviesDataLoading());
      try {
        final response = await http.post(
            Uri.parse(
              "https://hoblist.com/api/movieList",
            ),
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: {
              "category": "movies",
              "language": "kannada",
              "genre": "all",
              "sort": "voting"
            });

        log("${response.body}");
        log("${response.statusCode}");
        if (response.statusCode == 200) {
          final jsondata = await json.decode(response.body);

          final getdata = Moviesdata.fromJson(jsondata);

          emit(MoviesDataLoaded(moviesdata: getdata));
        }
      } catch (e) {
        log(e.toString());
        emit(MoviesDataError());
      }
    });
  }
}
