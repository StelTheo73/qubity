import 'package:function_tree/function_tree.dart';
import 'package:qartvm/qartvm.dart';

class ComplexCoefficient {
  ComplexCoefficient(this.real, this.imaginary);

  final String real;
  final String imaginary;

  @override
  String toString() {
    return 'ComplexCoefficient(real: $real, imaginary: $imaginary)';
  }
}

class CreateQBit {
  static Qbit createQBit(String c0, String c1) {
    late final Qbit qbit;

    final ComplexCoefficient c0Complex = _extractComplexCoefficient(c0);
    final ComplexCoefficient c1Complex = _extractComplexCoefficient(c1);

    qbit = Qbit(
      ket0: Complex(
        re: c0Complex.real.interpret().toDouble(),
        im: c0Complex.imaginary.interpret().toDouble(),
      ),
      ket1: Complex(
        re: c1Complex.real.interpret().toDouble(),
        im: c1Complex.imaginary.interpret().toDouble(),
      ),
    );

    return qbit;
  }

  static ComplexCoefficient _extractComplexCoefficient(String coefficientPart) {
    final String cReString = _extractRealPart(coefficientPart);
    final String cImString = _extractImaginaryPart(coefficientPart);

    return ComplexCoefficient(
      cReString,
      cImString,
    );
  }

  static String _extractRealPart(String coefficient) {
    late final String realPart;

    if (!coefficient.contains('i')) {
      return coefficient;
    }

    if (coefficient.contains('-i')) {
      realPart = coefficient.split('-i')[0].replaceAll(' ', '');
    } else {
      realPart = coefficient.split('i')[0].replaceAll(' ', '');
    }

    if (realPart.isEmpty) {
      return '0';
    }
    return realPart;
  }

  static String _extractImaginaryPart(String coefficient) {
    late final String imaginaryPart;

    if (!coefficient.contains('i')) {
      return '0';
    }

    if (coefficient.contains('-i')) {
      imaginaryPart = '-${coefficient.split('-i')[1].replaceAll(' ', '')}';
    } else {
      imaginaryPart = coefficient.split('i')[1].replaceAll(' ', '');
    }

    if (imaginaryPart.isEmpty) {
      return '1';
    }
    if (imaginaryPart == '-') {
      return '-1';
    }
    return imaginaryPart;
  }
}
