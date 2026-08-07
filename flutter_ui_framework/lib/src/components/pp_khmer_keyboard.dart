import 'package:flutter/material.dart';

class KeyDef {
  final String main;
  final String? shift;
  final List<String>? popup;
  final List<String>? shiftPopup;

  KeyDef({required this.main, this.shift, this.popup, this.shiftPopup});
}

class PPKhmerKeyboard extends StatefulWidget {
  final ValueChanged<String> onPress;

  const PPKhmerKeyboard({
    super.key,
    required this.onPress,
  });

  @override
  State<PPKhmerKeyboard> createState() => _PPKhmerKeyboardState();
}

class _PPKhmerKeyboardState extends State<PPKhmerKeyboard> {
  bool _isShifted = false;
  bool _showSymbols = false;

  final List<List<KeyDef>> _khmerLayout = [
    [
      KeyDef(main: '១', shift: '!', popup: ['១', '1'], shiftPopup: ['!', '!!']),
      KeyDef(main: '២', shift: 'ៗ'),
      KeyDef(main: '៣', shift: '៉'),
      KeyDef(main: '៤', shift: '៛'),
      KeyDef(main: '៥', shift: '%'),
      KeyDef(main: '៦', shift: '៍'),
      KeyDef(main: '៧', shift: '័'),
      KeyDef(main: '៨', shift: '៏'),
      KeyDef(main: '៩', shift: '('),
      KeyDef(main: '០', shift: ')'),
      KeyDef(main: 'ឥ', shift: '៌'),
      KeyDef(main: 'ឲ', shift: '៎'),
    ],
    [
      KeyDef(main: 'ឆ', shift: 'ឈ'),
      KeyDef(main: 'ឹ', shift: 'ឺ'),
      KeyDef(main: 'េ', shift: 'ែ', popup: ['ៃ', 'ែ', 'េ']),
      KeyDef(main: 'រ', shift: 'ឬ'),
      KeyDef(main: 'ត', shift: 'ទ'),
      KeyDef(main: 'យ', shift: 'ួ'),
      KeyDef(main: 'ុ', shift: 'ូ'),
      KeyDef(main: 'ិ', shift: 'ី'),
      KeyDef(main: 'ោ', shift: 'ៅ'),
      KeyDef(main: 'ផ', shift: 'ភ'),
      KeyDef(main: 'ៀ', shift: 'ឿ'),
      KeyDef(main: 'ឪ', shift: 'ឰ'),
    ],
    [
      KeyDef(main: 'ា', shift: 'ាំ'),
      KeyDef(main: 'ស', shift: 'ៃ'),
      KeyDef(main: 'ដ', shift: 'ឌ'),
      KeyDef(main: 'ថ', shift: 'ធ'),
      KeyDef(main: 'ង', shift: 'អ'),
      KeyDef(main: 'ហ', shift: 'ះ'),
      KeyDef(main: '្', shift: 'ញ'),
      KeyDef(main: 'ក', shift: 'គ'),
      KeyDef(main: 'ល', shift: 'ឡ'),
      KeyDef(main: 'ើ', shift: ''),
      KeyDef(main: '់', shift: '៉'),
      KeyDef(main: 'ឮ', shift: 'ឯ'),
    ],
    [
      KeyDef(main: 'ឋ', shift: 'ឍ'),
      KeyDef(main: 'ខ', shift: 'ឃ'),
      KeyDef(main: 'ច', shift: 'ជ'),
      KeyDef(main: 'វ', shift: ''),
      KeyDef(main: 'ប', shift: 'ព'),
      KeyDef(main: 'ន', shift: 'ណ'),
      KeyDef(main: 'ម', shift: 'ំ'),
      KeyDef(main: 'ួ', shift: 'ុះ'),
      KeyDef(main: '។', shift: ''),
      KeyDef(main: '៊', shift: '?'),
    ]
  ];

  final List<List<KeyDef>> _symbolsLayout = [
    [KeyDef(main: '1'), KeyDef(main: '2'), KeyDef(main: '3'), KeyDef(main: '4'), KeyDef(main: '5'), KeyDef(main: '6'), KeyDef(main: '7'), KeyDef(main: '8'), KeyDef(main: '9'), KeyDef(main: '0'), KeyDef(main: '-'), KeyDef(main: '=')],
    [KeyDef(main: '@'), KeyDef(main: '#'), KeyDef(main: '\$'), KeyDef(main: '_'), KeyDef(main: '&'), KeyDef(main: '-'), KeyDef(main: '+'), KeyDef(main: '('), KeyDef(main: ')'), KeyDef(main: '/'), KeyDef(main: '*'), KeyDef(main: '"')],
    [KeyDef(main: '*'), KeyDef(main: '"'), KeyDef(main: "'"), KeyDef(main: ':'), KeyDef(main: ';'), KeyDef(main: '!'), KeyDef(main: '?'), KeyDef(main: '~'), KeyDef(main: '`'), KeyDef(main: '|'), KeyDef(main: '•'), KeyDef(main: '√')],
    [KeyDef(main: '\\'), KeyDef(main: '%'), KeyDef(main: '{'), KeyDef(main: '}'), KeyDef(main: '['), KeyDef(main: ']'), KeyDef(main: '<'), KeyDef(main: '>'), KeyDef(main: '^'), KeyDef(main: '°')]
  ];

  void _toggleShift() {
    setState(() {
      _isShifted = !_isShifted;
      if (_showSymbols) _showSymbols = false;
    });
  }

  void _toggleSymbols() {
    setState(() {
      _showSymbols = !_showSymbols;
      if (_showSymbols) _isShifted = false;
    });
  }

  void _emitPress(String val) {
    widget.onPress(val);
    if (_isShifted && !_showSymbols) {
      setState(() {
        _isShifted = false;
      });
    }
  }

  KeyDef? _activePopupKeyObj;
  int _hoveredPopupIndex = -1;

  Widget _buildPopup(List<String> options, int hoveredIndex) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF4A4A4A),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(color: Colors.black54, blurRadius: 12, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(options.length, (index) {
          bool isHovered = index == hoveredIndex;
          return Container(
            width: 40,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: isHovered ? const Color(0xFFA8C7FA) : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            alignment: Alignment.center,
            child: Text(
              options[index],
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: isHovered ? Colors.black : Colors.white,
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildKey(KeyDef keyObj, {int flex = 1}) {
    bool useShift = _isShifted && !_showSymbols;
    String displayMain = useShift ? (keyObj.shift ?? keyObj.main) : keyObj.main;
    String? hint = (keyObj.shift != null && !_isShifted && !_showSymbols && keyObj.shift!.isNotEmpty) ? keyObj.shift : null;

    List<String>? nullableOptions = useShift ? keyObj.shiftPopup : keyObj.popup;
    List<String> options = (nullableOptions == null || nullableOptions.isEmpty) ? [displayMain] : nullableOptions;
    
    bool isActive = _activePopupKeyObj == keyObj;

    return Expanded(
      flex: flex,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onTap: () => _emitPress(displayMain),
              onLongPressStart: (details) {
                if (options!.length > 1) {
                  setState(() {
                    _activePopupKeyObj = keyObj;
                    _hoveredPopupIndex = options.length - 1; // Default to right-most
                  });
                }
              },
              onLongPressMoveUpdate: (details) {
                if (options!.length <= 1) return;
                
                double popupWidth = options.length * 44.0; 
                double centerOffset = details.localPosition.dx - 20; 
                double fingerPopupX = (popupWidth / 2) + centerOffset;
                
                int index = (fingerPopupX / 44).floor();
                if (index < 0) index = 0;
                if (index >= options.length) index = options.length - 1;
                
                if (_hoveredPopupIndex != index) {
                  setState(() {
                    _hoveredPopupIndex = index;
                  });
                }
              },
              onLongPressEnd: (details) {
                if (isActive) {
                  if (_hoveredPopupIndex >= 0 && _hoveredPopupIndex < options!.length) {
                    _emitPress(options[_hoveredPopupIndex]);
                  } else {
                    _emitPress(displayMain);
                  }
                  setState(() {
                    _activePopupKeyObj = null;
                    _hoveredPopupIndex = -1;
                  });
                }
              },
              child: Material(
                color: const Color(0xFF3B3B3B),
                borderRadius: BorderRadius.circular(6),
                elevation: 1,
                child: InkWell(
                  onTap: () => _emitPress(displayMain),
                  borderRadius: BorderRadius.circular(6),
                  highlightColor: const Color(0xFF555555),
                  child: Stack(
                    children: [
                      Container(
                        height: 48,
                        alignment: Alignment.center,
                        child: Text(
                          displayMain,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      if (hint != null)
                        Positioned(
                          top: 4,
                          right: 4,
                          child: Text(
                            hint,
                            style: const TextStyle(
                              color: Color(0xFF999999),
                              fontSize: 10,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            if (isActive)
              Positioned(
                top: -65,
                child: _buildPopup(options, _hoveredPopupIndex),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFuncKey(Widget child, VoidCallback onTap, {int flex = 1, bool isActive = false}) {
    return Expanded(
      flex: flex,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 2),
        child: Material(
          color: isActive ? const Color(0xFFE5E5E5) : const Color(0xFF2B2B2B),
          borderRadius: BorderRadius.circular(6),
          elevation: 1,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(6),
            highlightColor: const Color(0xFF444444),
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
    List<List<KeyDef>> layout = _showSymbols ? _symbolsLayout : _khmerLayout;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: layout[0].map((k) => _buildKey(k)).toList(),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: layout[1].map((k) => _buildKey(k)).toList(),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: layout[2].map((k) => _buildKey(k)).toList(),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFuncKey(
                Icon(Icons.keyboard_capslock, color: _isShifted ? Colors.black : Colors.white, size: 24),
                _toggleShift,
                isActive: _isShifted,
                flex: 2,
              ),
              ...layout[3].map((k) => _buildKey(k, flex: 2)),
              _buildFuncKey(
                const Icon(Icons.backspace_outlined, color: Colors.white, size: 24),
                () => _emitPress('backspace'),
                flex: 2,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFuncKey(
                Text(
                  _showSymbols ? 'ABC' : '?123',
                  style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                ),
                _toggleSymbols,
                flex: 3,
              ),
              _buildFuncKey(
                const Text(',', style: TextStyle(color: Colors.white, fontSize: 18)),
                () => _emitPress(','),
                flex: 2,
              ),
              _buildFuncKey(
                const Text('😊', style: TextStyle(fontSize: 18)),
                () => _emitPress('emoji'),
                flex: 2,
              ),
              _buildKey(KeyDef(main: ' '), flex: 8), // Space
              _buildFuncKey(
                const Text('.', style: TextStyle(color: Colors.white, fontSize: 18)),
                () => _emitPress('.'),
                flex: 2,
              ),
              Expanded(
                flex: 3,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  child: Material(
                    color: const Color(0xFF1A73E8),
                    borderRadius: BorderRadius.circular(6),
                    elevation: 1,
                    child: InkWell(
                      onTap: () => _emitPress('enter'),
                      borderRadius: BorderRadius.circular(6),
                      highlightColor: const Color(0xFF1765CC),
                      child: Container(
                        height: 48,
                        alignment: Alignment.center,
                        child: const Icon(Icons.keyboard_return, color: Colors.white, size: 24),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
