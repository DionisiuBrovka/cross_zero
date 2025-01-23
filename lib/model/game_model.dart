enum CellValue { zero, cross }

class GameModel {
  final CellValue whosTurn;
  final List<CellValue?> cells;

  GameModel({required this.whosTurn, required this.cells});

  GameModel makeTurn(int index) {
    List<CellValue?> newCells = cells;
    newCells[index] = whosTurn;

    return GameModel(
        whosTurn: whosTurn == CellValue.zero ? CellValue.cross : CellValue.zero,
        cells: newCells);
  }
}
