import 'package:dart_eval/dart_eval.dart';
import 'package:dart_eval/dart_eval_bridge.dart';

class X {
  const X(this.q);

  final int q;

  int doThing() {
    return q + q;
  }
}

void main(List<String> args) {
  final source = '''
    int fib(int n) {
      if (n <= 1) return 1;
      return fib(n - 1) + fib(n - 2);
    }
    
    int main () {
      return fib(24);
    }
  ''';
  final timestamp = DateTime.now().millisecondsSinceEpoch;

  final result = eval(source);
  print('Output: $result');
  print('Execution time: ${DateTime.now().millisecondsSinceEpoch - timestamp} ms');
}

class $X extends X with BridgeInstance {
  const $X(int q) : super(q);

  static const $type = BridgeTypeDescriptor('package:flutter/src/main.dart', 'X');

  static $X _$construct(List<Object?> args) => $X(args[0] as int);

  static const BridgeClass<$X> $classDef = BridgeClass($type, constructors: {
    '': BridgeConstructor(_$construct, [BridgeParameter(type: EvalTypes.intType)])
  }, methods: {
    'doThing': BridgeFunction([])
  }, fields: {
    'q': BridgeField()
  });

  @override
  EvalValue? $bridgeGet(String identifier) {
    switch (identifier) {
      case 'q':
        return EvalInt(super.q);
      case 'doThing':
        return EvalFunctionImpl((runtime, target, args) => EvalInt(super.doThing()));
    }
    throw UnimplementedError();
  }

  @override
  void $bridgeSet(String identifier, EvalValue value) {
    throw UnimplementedError();
  }

  @override
  int get q => $_get('q');

  @override
  int doThing() => $_invoke('doThing', []);
}
