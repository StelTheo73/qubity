import 'package:qartvm/qartvm.dart';

import '../constants/gates.dart';
import './base_game.dart';
import 'objects/gate.dart';
import 'state/level_state.dart';

class QubityGame extends BaseGame {
  QubityGame({required super.level});

  Future<void> updateSpaceships() async {
    LevelStates.resetSpaceshipPositions();
    LevelStates.createSpaceshipPositions(gameRegister);
    LevelStates.removeLevelSpaceships(removeAll);
    LevelStates.createLevelSpaceships();
    await addAll(LevelStates.levelSpaceships);
  }

  void quantumCalculation({
    required String gate0,
    String gate1 = 'I',
  }) {
    final QCircuit circuit = QCircuit(size: gameRegister.size);
    final Gate gate0Gate = Gate.getGateFromString(gate0);
    final Gate gate1Gate = Gate.getGateFromString(gate1);

    if (gameRegister.size == 1) {
      // ignore: avoid_dynamic_calls
      gatesMap[gate0Gate]!['action'](circuit, 0);
    } else {
      // ignore: avoid_dynamic_calls
      gatesMap[gate0Gate]!['action'](circuit, 1);
      // ignore: avoid_dynamic_calls
      gatesMap[gate1Gate]!['action'](circuit, 0);
    }

    circuit.execute(gameRegister);
  }

  void selectGate(GateComponent gateComponent) {
    deselectGate();
    selectedGate = gateComponent;
    gateComponent.select();
    registerComponent.highlightCircuitGates();
  }

  void deselectGate() {
    selectedGate?.deselect();
    selectedGate = null;
    registerComponent.resetCircuitGates();
  }

  Future<void> applyGate(int qubitId) async {
    final Gate? gateToApply = selectedGate?.gate;
    if (gateToApply == null) {
      return;
    }
    late final String gate0;
    late final String gate1;

    deselectGate();

    if (qubitId == 0) {
      gate0 = gateToApply.name;
      gate1 = 'I';
    } else {
      gate0 = 'I';
      gate1 = gateToApply.name;
    }

    quantumCalculation(
      gate0: gate0,
      gate1: gate1,
    );
    registerComponent.updateRegister();
    await updateSpaceships();
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
  }
}
