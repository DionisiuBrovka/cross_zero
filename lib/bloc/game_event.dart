part of 'game_bloc.dart';

@immutable
sealed class GameEvent {}

class MakeTurn extends GameEvent {
  final int index;

  MakeTurn({required this.index});
}
