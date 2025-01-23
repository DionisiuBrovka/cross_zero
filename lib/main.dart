import 'dart:developer';

import 'package:cross_zero/bloc/game_bloc.dart';
import 'package:cross_zero/model/game_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('${bloc.runtimeType} $change');
  }
}

void main() {
  Bloc.observer = SimpleObserver();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => GameBloc(),
        child: Scaffold(
          body: Center(
            child: SizedBox(
                height: 600,
                width: 600,
                child: Card(child: BlocBuilder<GameBloc, GameState>(
                  builder: (context, state) {
                    if (state is GameWait) {
                      return GridView.count(
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          crossAxisCount: 3,
                          children: cellGridList(state.gameModel.cells));
                    } else {
                      return const Center(
                        child: Text("УРА 1!!"),
                      );
                    }
                  },
                ))),
          ),
        ),
      ),
    );
  }

  List<Widget> cellGridList(List<CellValue?> listItems) {
    List<Widget> res = [];
    int index = 0;
    for (var element in listItems) {
      res.add(CellWidget(
        index: index,
        value: element,
      ));
      index += 1;
    }
    return res;
  }
}

class CellWidget extends StatelessWidget {
  final CellValue? value;
  final int index;

  const CellWidget({super.key, this.value, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: value == null
          ? () {
              context.read<GameBloc>().add(MakeTurn(index: index));
            }
          : null,
      child: AnimatedContainer(
          duration: Durations.medium3,
          decoration: value == null
              ? const BoxDecoration(color: Colors.grey)
              : value == CellValue.cross
                  ? const BoxDecoration(color: Colors.redAccent)
                  : const BoxDecoration(color: Colors.blueAccent),
          child: value == null
              ? const Center()
              : Icon(value == CellValue.cross ? Icons.close : Icons.circle)),
    );
  }
}
