import 'package:qartvm/qartvm.dart';

enum Gate {
  H('H'),
  I('I'),
  X('X'),
  Y('Y'),
  Z('Z');

  const Gate(this.gate);

  static Gate getGateFromString(String gate) {
    switch (gate) {
      case 'H':
        return Gate.H;
      case 'I':
        return Gate.I;
      case 'X':
        return Gate.X;
      case 'Y':
        return Gate.Y;
      case 'Z':
        return Gate.Z;
      default:
        return Gate.I;
    }
  }

  final String gate;
}

final Map<Gate, Map<String, dynamic>> gatesMap = <Gate, Map<String, dynamic>>{
  Gate.H: <String, dynamic>{
    'name': 'H',
    'image': 'assets/images/gates/H.png',
    'description': 'H gate description for tutorial',
    'action': (QCircuit circuit, int pos) => circuit.hadamard(pos)
  },
  Gate.I: <String, dynamic>{
    'name': 'I',
    'image': 'assets/images/gates/I.png',
    'description': 'I gate description for tutorial',
    'action': (QCircuit circuit, int pos) => circuit.custom(
        pos,
        ComplexMatrix(<List<Complex>>[
          <Complex>[Complex.one, Complex.zero],
          <Complex>[Complex.zero, Complex.one],
        ]))
  },
  Gate.X: <String, dynamic>{
    'name': 'X',
    'image': 'assets/images/gates/X.png',
    'description': 'X gate description for tutorial',
    'action': (QCircuit circuit, int pos) => circuit.pauliX(pos)
  },
  Gate.Y: <String, dynamic>{
    'name': 'Y',
    'image': 'assets/images/gates/Y.png',
    'description': 'Y gate description for tutorial',
    'action': (QCircuit circuit, int pos) => circuit.pauliY(pos)
  },
  Gate.Z: <String, dynamic>{
    'name': 'Z',
    'image': 'assets/images/gates/Z.png',
    'description': 'Z gate description for tutorial',
    'action': (QCircuit circuit, int pos) => circuit.pauliZ(pos)
  },
};
