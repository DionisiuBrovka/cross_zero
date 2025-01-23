part of 'game_bloc.dart';

@immutable
sealed class GameState {}

final class GameWait extends GameState {
  final GameModel gameModel;

  GameWait({required this.gameModel});
}

final class GameEnd extends GameState {}
