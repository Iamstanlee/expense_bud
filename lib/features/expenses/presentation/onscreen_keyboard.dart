import 'package:expense_bud/config/constants.dart';
import 'package:expense_bud/config/theme.dart';
import 'package:expense_bud/core/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class OnScreenKeyboard extends StatefulWidget {
  final ValueChanged<String> onChange;
  final ValueChanged<String> onEnter;
  const OnScreenKeyboard(
      {required this.onChange, required this.onEnter, Key? key})
      : super(key: key);

  @override
  _OnScreenKeyboardState createState() => _OnScreenKeyboardState();
}

class _OnScreenKeyboardState extends State<OnScreenKeyboard> {
  final double _kPadHeight = 65;
  final _kMax = 100000;
  String _editValue = "";

  void _onChange(_Key key) {
    String value = key.value;
    if (value == 'delete') {
      if (_editValue.isNotEmpty) {
        _editValue = _editValue.substring(0, _editValue.length - 1);
        widget.onChange(_editValue);
      }
      return;
    }

    if (_canEditText(_editValue, value) &&
        !_hasReachedMaxAmount(_editValue, key)) {
      if (key.addAmount) {
        final _amount = _editValue.isEmpty
            ? value
            : (value.toFloat() + _editValue.toFloat()).toString();
        _editValue = _amount;
      } else {
        _editValue += value;
      }

      return widget.onChange(_editValue);
    }
  }

  void _onEnter() {
    if ((_editValue.isNotEmpty && _editValue[_editValue.length - 1] != '.')) {
      widget.onEnter(_editValue);
    }
  }

  bool _canEditText(String text, String value) {
    final dotChar = value == '.';
    if (text.isEmpty && !dotChar) return true;
    if (text.isEmpty && dotChar) return false;
    if (text[text.length - 1] == '.' && dotChar) return false;
    if (text.length == 1 && text[0] == '0' && value == '0') return false;
    if (text.contains(".") && dotChar) return false;
    return true;
  }

  bool _hasReachedMaxAmount(String text, _Key key) {
    String value = key.value;
    if (text.isEmpty || value == '.') return false;
    final _amount = key.addAmount
        ? (text.toFloat() + value.toFloat()).toString()
        : text += value;
    return !(_amount.toFloat() < _kMax);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _kPadHeight * 4 + 40,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: _quickKeys
                .map((e) => SizedBox(
                      height: 40,
                      width: context.getWidth(0.33),
                      child: Keypad(
                        _Key("+${e.value}"),
                        color: AppColors.kGrey200,
                        onTap: () => _onChange(e),
                      ),
                    ))
                .toList(),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      ..._numberKeys
                          .map((e) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: e
                                    .map(
                                      (key) => Expanded(
                                        child: SizedBox(
                                          height: _kPadHeight,
                                          child: Keypad(
                                            key,
                                            onTap: () => _onChange(key),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ))
                          .toList(),
                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: _kPadHeight,
                              child: Keypad(
                                _Key("0"),
                                onTap: () => _onChange(_Key("0")),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: _kPadHeight,
                            width: context.getWidth(0.224),
                            child: Keypad(
                              _Key("."),
                              onTap: () => _onChange(_Key(".")),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: context.getWidth(0.33),
                  child: Column(
                    children: [
                      SizedBox(
                        height: _kPadHeight,
                        child: Keypad(
                          _Key("delete"),
                          onTap: () => _onChange(_Key("delete")),
                          color: AppColors.kGrey200,
                          child: const Icon(
                            PhosphorIcons.backspace,
                            color: Colors.black45,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Keypad(
                          _Key("enter"),
                          onTap: () => _onEnter(),
                          color: AppColors.kPrimary,
                          child: const Icon(
                            PhosphorIcons.arrowElbowDownLeftThin,
                            size: IconSizes.lg,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Keypad extends StatelessWidget {
  final _Key _key;
  final Color? color;
  final Widget? child;
  final Function? onTap;
  const Keypad(this._key, {this.color, this.child, this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap!(),
      child: Container(
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          border: Border.all(
            color: AppColors.kGrey,
            width: .9,
          ),
        ),
        child: Center(
          child: child ?? Text(_key.value, style: context.textTheme.subtitle1),
        ),
      ),
    );
  }
}

class _Key {
  String value;
  bool addAmount;
  _Key(this.value, {this.addAmount = false});
}

List<_Key> _quickKeys = [
  _Key("100", addAmount: true),
  _Key("250", addAmount: true),
  _Key("500", addAmount: true)
];

List<List<_Key>> _numberKeys = [
  [
    _Key("1"),
    _Key("2"),
    _Key("3"),
  ],
  [
    _Key("4"),
    _Key("5"),
    _Key("6"),
  ],
  [
    _Key("7"),
    _Key("8"),
    _Key("9"),
  ]
];
