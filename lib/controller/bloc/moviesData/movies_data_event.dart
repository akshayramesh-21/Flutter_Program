part of 'movies_data_bloc.dart';

@immutable
sealed class MoviesDataEvent {}

class MoviedataFetch extends MoviesDataEvent {}
