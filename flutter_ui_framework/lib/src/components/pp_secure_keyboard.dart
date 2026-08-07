import 'package:flutter/material.dart';
import 'dart:math';

class PPSecureKeyboard extends StatefulWidget {
  final ValueChanged<String> onPress;

  const PPSecureKeyboard({
    super.key,
    required this.onPress,
  });

  @override
  State<PPSecureKeyboard> createState() => _PPSecureKeyboardState();
}

class _PPSecureKeyboardState extends State<PPSecureKeyboard> {
  bool _isShifted = false;
  bool _showSymbols = false;

  final List<String> _defaultNumbers = ['1','2','3','4','5','6','7','8','9','0'];
  final List<String> _defaultLetters = ['q','w','e','r','t','y','u','i','o','p','a','s','d','f','g','h','j','k','l','z','x','c','v','b','n','m'];
  final List<String> _defaultSymbols = ['!','@','#','\$','%','^','&','*','(',')','-','+','_','=','{','}','[',']',':',';','"','\'','<','>','?','/'];

  List<int> _shieldPositions = [0, 0, 0, 0];

  @override
  void initState() {
    super.initState();
    _randomizeKeys();
  }

  void _randomizeKeys() {
    final rand = Random();
    setState(() {
      _shieldPositions = [
        rand.nextInt(11),
        rand.nextInt(11),
        rand.nextInt(10),
        rand.nextInt(8),
      ];
    });
  }

  void randomizeKeys() {
    _randomizeKeys();
  }

  List<String> get _row0Keys {
    List<String> nums = List.from(_defaultNumbers);
    nums.insert(_shieldPositions[0], 'shield');
    return nums;
  }

  List<String> get _row1Keys {
    List<String> source = _showSymbols ? _defaultSymbols : _defaultLetters;
    List<String> keys = source.sublist(0, 10);
    keys.insert(_shieldPositions[1], 'shield');
    return keys;
  }

  List<String> get _row2Keys {
    List<String> source = _showSymbols ? _defaultSymbols : _defaultLetters;
    List<String> keys = source.sublist(10, 19);
    keys.insert(_shieldPositions[2], 'shield');
    return keys;
  }

  List<String> get _row3Keys {
    List<String> source = _showSymbols ? _defaultSymbols : _defaultLetters;
    List<String> keys = source.sublist(19, 26);
    keys.insert(_shieldPositions[3], 'shield');
    return keys;
  }

  String _formatChar(String char) {
    if (_showSymbols) return char;
    return _isShifted ? char.toUpperCase() : char;
  }

  void _toggleShift() {
    setState(() {
      _isShifted = !_isShifted;
    });
  }

  void _toggleSymbols() {
    setState(() {
      _showSymbols = !_showSymbols;
      if (_showSymbols) _isShifted = false;
    });
  }

  void _emitPress(String val) {
    if (val.length == 1 && RegExp(r'[a-z]').hasMatch(val) && !_showSymbols && _isShifted) {
      widget.onPress(val.toUpperCase());
    } else {
      widget.onPress(val);
    }
  }

  Widget _buildKey(String char, {int flex = 1}) {
    if (char == 'shield') {
      return Expanded(
        flex: flex,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          height: 48,
          alignment: Alignment.center,
          child: const Icon(Icons.security, color: Color(0xFF5F6368), size: 20),
        ),
      );
    }

    String displayChar = _formatChar(char);

    return Expanded(
      flex: flex,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        child: Material(
          color: const Color(0xFF2C2D31),
          borderRadius: BorderRadius.circular(8),
          elevation: 1,
          child: InkWell(
            onTap: () => _emitPress(char),
            borderRadius: BorderRadius.circular(8),
            highlightColor: const Color(0xFF4A4B50),
            child: Container(
              height: 48,
              alignment: Alignment.center,
              child: Text(
                displayChar,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFuncKey(Widget child, VoidCallback onTap, {int flex = 1, bool isActive = false}) {
    return Expanded(
      flex: flex,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        child: Material(
          color: isActive ? const Color(0xFF3880FF) : const Color(0xFF202124),
          borderRadius: BorderRadius.circular(8),
          elevation: 1,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8),
            highlightColor: const Color(0xFF4A4B50),
            child: Container(
              height: 48,
              alignment: Alignment.center,
              child: child,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1B1E),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.only(top: 8, bottom: 24, left: 4, right: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Row 0
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _row0Keys.map((k) => _buildKey(k)).toList(),
          ),
          const SizedBox(height: 8),
          
          // Row 1
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _row1Keys.map((k) => _buildKey(k)).toList(),
          ),
          const SizedBox(height: 8),
          
          // Row 2
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _row2Keys.map((k) => _buildKey(k)).toList(),
            ),
          ),
          const SizedBox(height: 8),
          
          // Row 3
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFuncKey(
                Icon(Icons.keyboard_capslock, color: _isShifted ? Colors.white : const Color(0xFFE8EAED), size: 24),
                _toggleShift,
                isActive: _isShifted,
              ),
              ..._row3Keys.map((k) => _buildKey(k)),
              _buildFuncKey(
                const Icon(Icons.backspace_outlined, color: Color(0xFFE8EAED), size: 24),
                () => _emitPress('backspace'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          
          // Row 4
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFuncKey(
                Text(
                  _showSymbols ? 'ABC' : '\$%?',
                  style: const TextStyle(color: Color(0xFFE8EAED), fontSize: 16, fontWeight: FontWeight.w600),
                ),
                _toggleSymbols,
                flex: 2,
              ),
              _buildFuncKey(
                const Text('😊', style: TextStyle(fontSize: 20)),
                () => _emitPress('emoji'),
              ),
              _buildKey(' ', flex: 5),
              _buildFuncKey(
                const Text('.', style: TextStyle(color: Color(0xFFE8EAED), fontSize: 20)),
                () => _emitPress('.'),
              ),
              _buildFuncKey(
                const Icon(Icons.keyboard_return, color: Color(0xFFE8EAED), size: 24),
                () => _emitPress('enter'),
                flex: 2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
