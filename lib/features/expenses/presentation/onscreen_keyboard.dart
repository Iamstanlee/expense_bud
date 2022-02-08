import 'package:expense_tracker/config/constants.dart';
import 'package:expense_tracker/config/theme.dart';
import 'package:expense_tracker/core/utils/extensions.dart';
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
  String _editValue = "";

  void _onChange(_Key key) {
    String value = key.value;
    if (_editValue.length >= 7 && value != 'delete') return;

    if (value == 'delete') {
      if (_editValue.isNotEmpty) {
        _editValue = _editValue.substring(0, _editValue.length - 1);
      } else {
        return;
      }
    } else if (value == '.') {
      if (_isEditValueValid(_editValue)) {
        _editValue += value;
      } else {
        return;
      }
    } else {
      if (_editValue.length == 1 && _editValue[0] == '0' && value == '0') {
        return;
      }
      if (key.replaceText) {
        _editValue = value;
      } else {
        _editValue += value;
      }
    }
    widget.onChange(_editValue);
  }

  void _onEnter() {
    if (_isEditValueValid(_editValue)) {
      widget.onEnter(_editValue);
    }
  }

  bool _isEditValueValid(String value) {
    return !((_editValue.isEmpty) || _editValue[_editValue.length - 1] == '.');
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
                        e,
                        color: AppColors.kLightGrey,
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
                          color: AppColors.kLightGrey,
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
  bool replaceText;
  _Key(this.value, {this.replaceText = false});
}

List<_Key> _quickKeys = [
  _Key("100", replaceText: true),
  _Key("250", replaceText: true),
  _Key("500", replaceText: true)
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
