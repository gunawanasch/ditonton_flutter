part of 'popular_tv_bloc.dart';

abstract class PopularTVState extends Equatable {
  const PopularTVState();
}

class PopularTVInitial extends PopularTVState {
  const PopularTVInitial();

  @override
  List<Object> get props => [];
}

class PopularTVLoading extends PopularTVState {
  const PopularTVLoading();

  @override
  List<Object> get props => [];
}

class PopularTVSuccess extends PopularTVState {
  final List<TV> result;
  const PopularTVSuccess(this.result);

  @override
  List<Object> get props => [result];
}

class PopularTVError extends PopularTVState {
  final String message;
  const PopularTVError(this.message);

  @override
  List<Object> get props => [message];
}
