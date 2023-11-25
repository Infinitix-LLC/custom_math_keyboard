import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:custom_math_keyboard/src/foundation/node.dart';

/// Class representing a button configuration.
abstract class KeyboardButtonConfig {
  /// Constructs a [KeyboardButtonConfig].
  const KeyboardButtonConfig({
    this.flex,
    this.keyboardCharacters = const [],
  });

  /// Optional flex.
  final int? flex;

  /// The list of [RawKeyEvent.character] that should trigger this keyboard
  /// button on a physical keyboard.
  ///
  /// Note that the case of the characters is ignored.
  ///
  /// Special keyboard keys like backspace and arrow keys are specially handled
  /// and do *not* require this to be set.
  ///
  /// Must not be `null` but can be empty.
  final List<String> keyboardCharacters;
}

/// Class representing a button configuration for a [FunctionButton].
class BasicKeyboardButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [KeyboardButtonConfig].
  const BasicKeyboardButtonConfig({
    required this.label,
    required this.value,
    this.args,
    this.asTex = false,
    this.highlighted = false,
    List<String> keyboardCharacters = const [],
    int? flex,
  }) : super(
          flex: flex,
          keyboardCharacters: keyboardCharacters,
        );

  /// The label of the button.
  final String label;

  /// The value in tex.
  final String value;

  /// List defining the arguments for the function behind this button.
  final List<TeXArg>? args;

  /// Whether to display the label as TeX or as plain text.
  final bool asTex;

  /// The highlight level of this button.
  final bool highlighted;
}

/// Class representing a button configuration of the Delete Button.
class DeleteButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [DeleteButtonConfig].
  DeleteButtonConfig({int? flex}) : super(flex: flex);
}

/// Class representing a button configuration of the Previous Button.
class PreviousButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [DeleteButtonConfig].
  PreviousButtonConfig({int? flex}) : super(flex: flex);
}

/// Class representing a button configuration of the Next Button.
class NextButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [DeleteButtonConfig].
  NextButtonConfig({int? flex}) : super(flex: flex);
}

/// Class representing a button configuration of the Submit Button.
class SubmitButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [SubmitButtonConfig].
  SubmitButtonConfig({int? flex}) : super(flex: flex);
}

/// Class representing a button configuration of the Submit Button.
class SpaceButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [SubmitButtonConfig].
  SpaceButtonConfig({int? flex}) : super(flex: flex);
}

/// Class representing a button configuration of the Submit Button.
class FunctionPageButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [SubmitButtonConfig].
  const FunctionPageButtonConfig({int? flex}) : super(flex: flex);
}

/// Class representing a button configuration of the Page Toggle Button.
class LetterPageButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [PageButtonConfig].
  const LetterPageButtonConfig({int? flex}) : super(flex: flex);
}

/// Class representing a button configuration of the Page Toggle Button.
class StandardPageButtonConfig extends KeyboardButtonConfig {
  /// Constructs a [PageButtonConfig].
  const StandardPageButtonConfig({int? flex}) : super(flex: flex);
}

/// List of keyboard button configs for the digits from 0-9.
///
/// List access from 0 to 9 will return the appropriate digit button.
final _digitButtons = [
  for (var i = 0; i < 10; i++)
    BasicKeyboardButtonConfig(
      label: '$i',
      value: '$i',
      keyboardCharacters: ['$i'],
    ),
];

const _decimalButton = BasicKeyboardButtonConfig(
  label: '.',
  value: '.',
  keyboardCharacters: ['.', ','],
  highlighted: true,
);

const _subtractButton = BasicKeyboardButtonConfig(
  label: '−',
  value: '-',
  keyboardCharacters: ['-'],
  highlighted: true,
);

/// Keyboard showing extended functionality. ==> 2
final functionKeyboard = [
  [
    const BasicKeyboardButtonConfig(
      label: r'\frac{\Box}{\Box}',
      value: r'\frac',
      flex: 3,
      args: [TeXArg.braces, TeXArg.braces],
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\Box^2',
      value: '^2',
      args: [TeXArg.braces],
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\Box^{\Box}',
      value: '^',
      args: [TeXArg.braces],
      asTex: true,
      keyboardCharacters: [
        '^',
        // This is a workaround for keyboard layout that use ^ as a toggle key.
        // In that case, "Dead" is reported as the character (e.g. for German
        // keyboards).
        'Dead',
      ],
    ),
    const BasicKeyboardButtonConfig(
      label: r'\sin',
      value: r'\sin(',
      asTex: true,
      keyboardCharacters: ['s'],
    ),
    const BasicKeyboardButtonConfig(
      label: r'\sin^{-1}',
      value: r'\sin^{-1}(',
      asTex: true,
    ),
  ],
  [
    const BasicKeyboardButtonConfig(
      label: r'\sqrt{\Box}',
      value: r'\sqrt',
      flex: 3,
      args: [TeXArg.braces],
      asTex: true,
      keyboardCharacters: ['r'],
    ),
    const BasicKeyboardButtonConfig(
      label: r'\sqrt[\Box]{\Box}',
      value: r'\sqrt',
      args: [TeXArg.brackets, TeXArg.braces],
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: r'\cos',
      value: r'\cos(',
      asTex: true,
      keyboardCharacters: ['c'],
    ),
    const BasicKeyboardButtonConfig(
      label: r'\cos^{-1}',
      value: r'\cos^{-1}(',
      asTex: true,
    ),
    const BasicKeyboardButtonConfig(
      label: '___',
      value: '\\:',
      highlighted: true,
      keyboardCharacters: [' '],
    ),
  ],
  [
    const BasicKeyboardButtonConfig(
      label: r'\log_{\Box}(\Box)',
      value: r'\log_',
      flex: 3,
      asTex: true,
      args: [TeXArg.braces, TeXArg.parentheses],
    ),
    const BasicKeyboardButtonConfig(
      label: r'\ln(\Box)',
      value: r'\ln(',
      asTex: true,
      keyboardCharacters: ['l'],
    ),
    const BasicKeyboardButtonConfig(
      label: r'\tan',
      value: r'\tan(',
      asTex: true,
      keyboardCharacters: ['t'],
    ),
    const BasicKeyboardButtonConfig(
      label: r'\tan^{-1}',
      value: r'\tan^{-1}(',
      asTex: true,
    ),
    DeleteButtonConfig()
  ],
  [
    const LetterPageButtonConfig(),
    const StandardPageButtonConfig(),
    const BasicKeyboardButtonConfig(
      label: '(',
      value: '(',
      highlighted: true,
      keyboardCharacters: ['('],
    ),
    const BasicKeyboardButtonConfig(
      label: ')',
      value: ')',
      highlighted: true,
      keyboardCharacters: [')'],
    ),
    PreviousButtonConfig(
      flex: 3,
    ),
    NextButtonConfig(
      flex: 3,
    ),
  ],
];

/// Standard keyboard for math expression input. ==> 1
final standardKeyboard = [
  [
    _digitButtons[7],
    _digitButtons[8],
    _digitButtons[9],
    const BasicKeyboardButtonConfig(
      label: '×',
      value: r'\cdot',
      keyboardCharacters: ['*'],
      highlighted: true,
    ),
    const BasicKeyboardButtonConfig(
      label: '÷',
      value: r'\frac',
      keyboardCharacters: ['/'],
      args: [TeXArg.braces, TeXArg.braces],
      highlighted: true,
    ),
  ],
  [
    _digitButtons[4],
    _digitButtons[5],
    _digitButtons[6],
    const BasicKeyboardButtonConfig(
      label: '+',
      value: '+',
      keyboardCharacters: ['+'],
      highlighted: true,
    ),
    _subtractButton,
  ],
  [
    _digitButtons[1],
    _digitButtons[2],
    _digitButtons[3],
    const BasicKeyboardButtonConfig(
      label: '=',
      value: '=',
      highlighted: true,
      keyboardCharacters: ['='],
    ),
    DeleteButtonConfig(),
  ],
  [
    const LetterPageButtonConfig(),
    const FunctionPageButtonConfig(),
    _digitButtons[0],
    _decimalButton,
    PreviousButtonConfig(
      flex: 3,
    ),
    NextButtonConfig(
      flex: 3,
    ),
  ],
];

final letterKeyboard = [
  [
    const BasicKeyboardButtonConfig(
      label: 'q',
      value: 'q',
      keyboardCharacters: ['q'],
    ),
    const BasicKeyboardButtonConfig(
      label: 'w',
      value: 'w',
      keyboardCharacters: ['w'],
    ),
    const BasicKeyboardButtonConfig(
      label: 'e',
      value: 'e',
      keyboardCharacters: ['e'],
    ),
    const BasicKeyboardButtonConfig(
      label: 'r',
      value: 'r',
      keyboardCharacters: ['r'],
    ),
    const BasicKeyboardButtonConfig(
      label: 't',
      value: 't',
      keyboardCharacters: ['t'],
    ),
    const BasicKeyboardButtonConfig(
      label: 'y',
      value: 'y',
      keyboardCharacters: ['y'],
    ),
    const BasicKeyboardButtonConfig(
      label: 'u',
      value: 'u',
      keyboardCharacters: ['u'],
    ),
    const BasicKeyboardButtonConfig(
      label: 'i',
      value: 'i',
      keyboardCharacters: ['i'],
    ),
    const BasicKeyboardButtonConfig(
      label: 'o',
      value: 'o',
      keyboardCharacters: ['o'],
    ),
    const BasicKeyboardButtonConfig(
      label: 'p',
      value: 'p',
      keyboardCharacters: ['p'],
    ),
  ],
  [
    const BasicKeyboardButtonConfig(
      label: 'a',
      value: 'a',
      keyboardCharacters: ['a'],
    ),
    const BasicKeyboardButtonConfig(
      label: 's',
      value: 's',
      keyboardCharacters: ['s'],
    ),
    const BasicKeyboardButtonConfig(
      label: 'd',
      value: 'd',
      keyboardCharacters: ['d'],
    ),
    const BasicKeyboardButtonConfig(
      label: 'f',
      value: 'f',
      keyboardCharacters: ['f'],
    ),
    const BasicKeyboardButtonConfig(
      label: 'g',
      value: 'g',
      keyboardCharacters: ['g'],
    ),
    const BasicKeyboardButtonConfig(
      label: 'h',
      value: 'h',
      keyboardCharacters: ['h'],
    ),
    const BasicKeyboardButtonConfig(
      label: 'j',
      value: 'j',
      keyboardCharacters: ['j'],
    ),
    const BasicKeyboardButtonConfig(
      label: 'k',
      value: 'k',
      keyboardCharacters: ['k'],
    ),
    const BasicKeyboardButtonConfig(
      label: 'l',
      value: 'l',
      keyboardCharacters: ['l'],
    ),
  ],
  [
    const BasicKeyboardButtonConfig(
      label: 'z',
      value: 'z',
      keyboardCharacters: ['z'],
    ),
    const BasicKeyboardButtonConfig(
      label: 'x',
      value: 'x',
      keyboardCharacters: ['x'],
    ),
    const BasicKeyboardButtonConfig(
      label: 'c',
      value: 'c',
      keyboardCharacters: ['c'],
    ),
    const BasicKeyboardButtonConfig(
      label: 'v',
      value: 'v',
      keyboardCharacters: ['v'],
    ),
    const BasicKeyboardButtonConfig(
      label: 'b',
      value: 'b',
      keyboardCharacters: ['b'],
    ),
    const BasicKeyboardButtonConfig(
      label: 'n',
      value: 'n',
      keyboardCharacters: ['n'],
    ),
    const BasicKeyboardButtonConfig(
      label: 'm',
      value: 'm',
      keyboardCharacters: ['m'],
    ),
    DeleteButtonConfig(),
  ],
  [
    const StandardPageButtonConfig(),
    const FunctionPageButtonConfig(),
    const BasicKeyboardButtonConfig(
      flex: 4,
      label: '____',
      value: '\\:',
      highlighted: true,
      keyboardCharacters: [' '],
    ),
    PreviousButtonConfig(
      flex: 3,
    ),
    NextButtonConfig(
      flex: 3,
    ),
  ],
];
