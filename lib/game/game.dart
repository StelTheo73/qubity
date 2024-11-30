import 'package:qartvm/qartvm.dart';

import '../constants/gates.dart';
import './base_game.dart';
import 'state/level_state.dart';

class QubityGame extends BaseGame {
  QubityGame({required super.level});

  Future<void> updateSpaceships() async {
    LevelStates.resetSpaceshipPositions();
    LevelStates.createSpaceshipPositions(gameRegister);
    LevelStates.removeLevelSpaceships(removeAll);

    LevelStates.createLevelSpaceships();
  }

  void quantumCalculation({
    required String gate0,
    String gate1 = 'I',
  }) {
    final QCircuit circuit = QCircuit(size: gameRegister.size);

    if (gameRegister.size == 1) {
      // ignore: avoid_dynamic_calls
      gatesMap[gate0 as Gate]!['action'](circuit, 0);
    } else {
      // ignore: avoid_dynamic_calls
      gatesMap[gate0 as Gate]!['action'](circuit, 1);
      // ignore: avoid_dynamic_calls
      gatesMap[gate1 as Gate]!['action'](circuit, 0);
    }

    circuit.execute(gameRegister);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // await quantumCalculation(
    // gate0: 'X',
    // );
  }
}
