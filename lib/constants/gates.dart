import 'package:qartvm/qartvm.dart';

final Map<String, Map<String, dynamic>> gatesMap =
    <String, Map<String, dynamic>>{
  'H': <String, dynamic>{
    'name': 'H',
    'image': 'assets/images/gates/H.png',
    'description': 'H gate description for tutorial',
    'action': (QCircuit circuit, int pos) => circuit.hadamard(pos)
  },
  'I': <String, dynamic>{
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
  'X': <String, dynamic>{
    'name': 'X',
    'image': 'assets/images/gates/X.png',
    'description': 'X gate description for tutorial',
    'action': (QCircuit circuit, int pos) => circuit.pauliX(pos)
  },
  'Y': <String, dynamic>{
    'name': 'Y',
    'image': 'assets/images/gates/Y.png',
    'description': 'Y gate description for tutorial',
    'action': (QCircuit circuit, int pos) => circuit.pauliY(pos)
  },
  'Z': <String, dynamic>{
    'name': 'Z',
    'image': 'assets/images/gates/Z.png',
    'description': 'Z gate description for tutorial',
    'action': (QCircuit circuit, int pos) => circuit.pauliZ(pos)
  },
};
