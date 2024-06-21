part of 'movies_data_bloc.dart';

@immutable
sealed class MoviesDataState {}

final class MoviesDataInitial extends MoviesDataState {}

class MoviesDataLoading extends MoviesDataState {}

class MoviesDataLoaded extends MoviesDataState {
  final Moviesdata moviesdata;

  MoviesDataLoaded({required this.moviesdata});
}

class MoviesDataError extends MoviesDataState {}
