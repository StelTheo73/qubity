import 'package:flame/components.dart';
import 'package:qartvm/qartvm.dart';

import '../constants/gates.dart';
import './base_game.dart';
import 'objects/gate.dart';
import 'state/level_state.dart';

class QubityGame extends BaseGame {
  QubityGame({required super.level});

  // Public Methods
  // --------------

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

  void deselectGate() {
    selectedGate?.deselect();
    selectedGate = null;
    registerComponent.resetCircuitGates();
  }

  void increaseGatesUsed() {
    gatesUsed++;
  }

  void increaseShotsFired() {
    shotsFired++;
  }

  bool isPositionOutOfBounds(Vector2 position) {
    if (position.x >= size.x ||
        position.x <= 0 ||
        position.y >= size.y ||
        position.y <= 0) {
      return true;
    }
    return false;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
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

  @override
  void update(double dt) {
    super.update(dt);
    _triggerLevelCompletion();
  }

  Future<void> updateSpaceships() async {
    LevelStates.resetSpaceshipPositions();
    LevelStates.createSpaceshipPositions(gameRegister);
    LevelStates.removeLevelSpaceships(removeAll);
    LevelStates.createLevelSpaceships();
    await addAll(LevelStates.levelSpaceships);
  }

  // Private Methods
  // ---------------

  Future<void> _triggerLevelCompletion() async {
    if (asteroidHits < LevelStates.levelEnemies.length) {
      return;
    }
    await onLevelCompletion();
  }
}
