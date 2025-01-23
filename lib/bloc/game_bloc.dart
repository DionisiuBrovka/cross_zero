import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cross_zero/model/game_model.dart';
import 'package:meta/meta.dart';

part 'game_event.dart';
part 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc()
      : super(GameWait(
            gameModel: GameModel(
                whosTurn: CellValue.cross,
                cells: List.generate(9, (index) => null)))) {
    on<MakeTurn>((event, emit) {
      if (state is GameWait) {
        final GameModel newGameState =
            (state as GameWait).gameModel.makeTurn(event.index);

        log(event.index.toString());
        log(newGameState.cells.toString());

// sSs
        if (newGameState.cells.contains(null)) {
          emit(GameWait(gameModel: newGameState));
        } else {
          emit(GameEnd());
        }
      }
    });
  }
}
