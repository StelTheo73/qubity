import 'package:qartvm/qartvm.dart';

import '../constants/gates.dart';
import './base_game.dart';

class QubityGame extends BaseGame {
  QubityGame({required super.level});

  Future<void> quantumCalculation({
    required String gate0,
    String gate1 = 'I',
  }) async {
    final QCircuit circuit = QCircuit(size: gameRegister.size);

    if (gameRegister.size == 1) {
      // ignore: avoid_dynamic_calls
      gatesMap[gate0]!['action'](circuit, 0);
    } else {
      // ignore: avoid_dynamic_calls
      gatesMap[gate0]!['action'](circuit, 1);
      // ignore: avoid_dynamic_calls
      gatesMap[gate1]!['action'](circuit, 0);
    }

    circuit.execute(gameRegister);

    // draw spaceships to new positions
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // await quantumCalculation(
    // gate0: 'X',
    // );
  }
}
