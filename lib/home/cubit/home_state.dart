part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.index,
  });

  final int index;

  @override
  List<Object?> get props => [index];
}
