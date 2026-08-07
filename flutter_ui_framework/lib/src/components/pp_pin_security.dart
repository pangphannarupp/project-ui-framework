import 'package:flutter/material.dart';
import 'dart:math';

// ==========================================
// PPPinDots
// ==========================================

class PPPinDots extends StatefulWidget {
  final int length;
  final String value;
  final bool error;
  final String errorText;
  final bool success;

  const PPPinDots({
    super.key,
    this.length = 6,
    this.value = '',
    this.error = false,
    this.errorText = 'PIN does not match. Please try again.',
    this.success = false,
  });

  @override
  State<PPPinDots> createState() => _PPPinDotsState();
}

class _PPPinDotsState extends State<PPPinDots> with TickerProviderStateMixin {
  late AnimationController _shakeController;
  late AnimationController _pulseController;
  
  bool _wasError = false;
  bool _wasSuccess = false;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
    _pulseController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    
    _checkAnimations();
  }

  @override
  void didUpdateWidget(PPPinDots oldWidget) {
    super.didUpdateWidget(oldWidget);
    _checkAnimations();
  }

  void _checkAnimations() {
    if (widget.error && !_wasError) {
      _shakeController.forward(from: 0.0);
    }
    if (widget.success && !_wasSuccess) {
      _pulseController.forward(from: 0.0);
    }
    _wasError = widget.error;
    _wasSuccess = widget.success;
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  bool _isFilled(int index) {
    return widget.value.length >= index;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _shakeController,
          builder: (context, child) {
            // Shake logic: 0 -> -8 -> 8 -> 0
            double offset = 0;
            double v = _shakeController.value;
            if (v < 0.25) {
              offset = -8 * (v / 0.25);
            } else if (v < 0.75) {
              offset = -8 + 16 * ((v - 0.25) / 0.5);
            } else {
              offset = 8 - 8 * ((v - 0.75) / 0.25);
            }
            return Transform.translate(
              offset: Offset(offset, 0),
              child: child,
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: List.generate(widget.length, (index) {
              bool filled = _isFilled(index + 1);
              
              Color borderColor = const Color(0xFF003399); // primary
              Color bgColor = Colors.transparent;
              
              if (widget.error) {
                borderColor = const Color(0xFFFF4D4F); // danger
                if (filled) bgColor = const Color(0xFFFF4D4F);
              } else if (widget.success) {
                borderColor = const Color(0xFF52C41A); // success
                bgColor = const Color(0xFF52C41A);
              } else if (filled) {
                bgColor = const Color(0xFF003399);
              }

              return AnimatedBuilder(
                animation: _pulseController,
                builder: (context, child) {
                  double scale = 1.0;
                  if (widget.success) {
                    // Staggered pulse effect
                    double delay = index * 0.05;
                    double v = _pulseController.value;
                    if (v > delay) {
                      double progress = (v - delay) / 0.4;
                      if (progress <= 1.0) {
                        if (progress < 0.5) {
                          scale = 1.0 + 0.25 * (progress / 0.5);
                        } else {
                          scale = 1.25 - 0.25 * ((progress - 0.5) / 0.5);
                        }
                      }
                    }
                  }
                  
                  return Transform.scale(
                    scale: scale,
                    child: child,
                  );
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 16,
                  height: 16,
                  margin: EdgeInsets.only(right: index == widget.length - 1 ? 0 : 16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: borderColor, width: 1.5),
                    color: bgColor,
                  ),
                ),
              );
            }),
          ),
        ),
        if (widget.error && widget.errorText.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 14, color: Color(0xFFFF4D4F)),
                const SizedBox(width: 6),
                Text(
                  widget.errorText,
                  style: const TextStyle(
                    color: Color(0xFFFF4D4F),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

// ==========================================
// PPSecureKeypad
// ==========================================

class PPSecureKeypad extends StatefulWidget {
  final bool showHeader;
  final ValueChanged<String> onPress;

  const PPSecureKeypad({
    super.key,
    this.showHeader = true,
    required this.onPress,
  });

  @override
  State<PPSecureKeypad> createState() => _PPSecureKeypadState();
}

class _PPSecureKeypadState extends State<PPSecureKeypad> {
  List<String> _shuffledKeys = [];

  final Map<String, String> _lettersMap = {
    '1': '', '2': 'ABC', '3': 'DEF',
    '4': 'GHI', '5': 'JKL', '6': 'MNO',
    '7': 'PQRS', '8': 'TUV', '9': 'WXYZ',
    '0': '+'
  };

  @override
  void initState() {
    super.initState();
    _randomizeKeys();
  }

  void _randomizeKeys() {
    List<String> nums = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];
    nums.shuffle(Random());
    int shieldIndex = Random().nextInt(11);
    nums.insert(shieldIndex, 'shield');
    setState(() {
      _shuffledKeys = nums;
    });
  }

  void randomizeKeys() {
    _randomizeKeys();
  }

  Widget _buildKey(String item) {
    if (item == 'shield') {
      return Container(
        height: 56,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: const Icon(Icons.security, color: Color(0xFFA0AEC0)),
      );
    }

    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      elevation: 0,
      shadowColor: Colors.black.withOpacity(0.02),
      child: InkWell(
        onTap: () => widget.onPress(item),
        borderRadius: BorderRadius.circular(12),
        highlightColor: const Color(0xFF003399),
        splashColor: const Color(0xFF003399).withOpacity(0.5),
        child: Container(
          height: 56,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A2A5E),
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                _lettersMap[item] ?? ' ',
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF718096),
                  letterSpacing: 1,
                  height: 1.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackspace() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => widget.onPress('backspace'),
        borderRadius: BorderRadius.circular(12),
        highlightColor: const Color(0xFF003399),
        child: Container(
          height: 56,
          alignment: Alignment.center,
          child: const Icon(Icons.backspace_outlined, color: Color(0xFF1A2A5E), size: 26),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFF4F6FA),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x0C000000), // rgba(0,0,0,0.05)
            blurRadius: 12,
            offset: Offset(0, -4),
          ),
        ],
      ),
      padding: const EdgeInsets.only(top: 12, left: 20, right: 20, bottom: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.showHeader)
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.verified_user, size: 18, color: Color(0xFF3880FF)),
                  SizedBox(width: 8),
                  Text(
                    'Secure Keypad Active',
                    style: TextStyle(
                      color: Color(0xFF003399),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              mainAxisExtent: 56,
            ),
            itemCount: 12,
            itemBuilder: (context, index) {
              if (index < 11) {
                return _buildKey(_shuffledKeys[index]);
              } else {
                return _buildBackspace();
              }
            },
          ),
        ],
      ),
    );
  }
}
