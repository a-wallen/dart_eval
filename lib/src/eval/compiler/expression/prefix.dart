import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:dart_eval/dart_eval_bridge.dart';
import 'package:dart_eval/source_node_wrapper.dart';
import 'package:dart_eval/src/eval/compiler/context.dart';
import 'package:dart_eval/src/eval/compiler/variable.dart';

import '../errors.dart';
import 'expression.dart';

/// Compile a [PrefixExpression] to EVC bytecode
Variable compilePrefixExpression(CompilerContext ctx, PrefixExpression e) {
  var V = compileExpression(e.operand, ctx);

  final opMap = {
    TokenType.MINUS: '-',
  };

  var method = opMap[e.operator.type] ?? (throw CompileError('Unknown unary operator ${e.operator.type}'));

  if (V.type != EvalTypes.intType && V.type != EvalTypes.doubleType) {
    throw CompileError('Unary operator $method is currently only supported for ints and doubles');
  }
  final zero = V.type == EvalTypes.intType ? BuiltinValue(intval: 0) : BuiltinValue(doubleval: 0.0);
  return zero.push(ctx).invoke(ctx, method, [V]).result;
}
