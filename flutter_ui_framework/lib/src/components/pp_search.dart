import 'dart:ui';
import 'package:flutter/material.dart';

class PPSearch extends StatefulWidget {
  final String value;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSearch;
  final VoidCallback? onClearHistory;
  final ValueChanged<dynamic>? onRemoveHistoryItem;
  final ValueChanged<dynamic>? onSelect;
  final String placeholder;
  final List<dynamic> results;
  final List<dynamic> history;
  final bool loading;
  final String Function(dynamic item)? itemLabelBuilder;

  const PPSearch({
    Key? key,
    this.value = '',
    this.onChanged,
    this.onSearch,
    this.onClearHistory,
    this.onRemoveHistoryItem,
    this.onSelect,
    this.placeholder = 'Search...',
    this.results = const [],
    this.history = const [],
    this.loading = false,
    this.itemLabelBuilder,
  }) : super(key: key);

  @override
  State<PPSearch> createState() => _PPSearchState();
}

class _PPSearchState extends State<PPSearch> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  bool _isFocused = false;
  int _activeIndex = -1;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void didUpdateWidget(PPSearch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value && widget.value != _controller.text) {
      _controller.text = widget.value;
    }
    if (_isFocused) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _updateOverlay();
        }
      });
    }
  }

  @override
  void dispose() {
    _removeOverlay();
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
    if (_isFocused) {
      _showOverlay();
    } else {
      // Small delay to allow tap events on overlay to process
      Future.delayed(const Duration(milliseconds: 150), () {
        if (mounted && !_focusNode.hasFocus) {
          _removeOverlay();
        }
      });
    }
  }

  String _getLabel(dynamic item) {
    if (widget.itemLabelBuilder != null) {
      return widget.itemLabelBuilder!(item);
    }
    return item.toString();
  }

  bool get _hasHistory => widget.history.isNotEmpty;
  bool get _hasResults => widget.results.isNotEmpty;
  bool get _isOpen => _isFocused && (_hasHistory || _hasResults);
  List<dynamic> get _currentList => _controller.text.isNotEmpty ? widget.results : widget.history;

  void _updateOverlay() {
    if (_isOpen) {
      if (_overlayEntry == null) {
        _showOverlay();
      } else {
        _overlayEntry!.markNeedsBuild();
      }
    } else {
      _removeOverlay();
    }
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;
    if (!_isOpen) return;

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height + 12.0),
          child: Material(
            color: Colors.transparent,
            child: Container(
              constraints: const BoxConstraints(maxHeight: 360),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xCCE2E8F0)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A000000), // 0.1
                    blurRadius: 40,
                    offset: Offset(0, 20),
                    spreadRadius: -10,
                  ),
                  BoxShadow(
                    color: Color(0x0D000000), // 0.05
                    blurRadius: 15,
                    offset: Offset(0, 10),
                    spreadRadius: -5,
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                  child: SingleChildScrollView(
                    child: _buildOverlayContent(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOverlayContent() {
    if (_controller.text.isNotEmpty) {
      if (widget.results.isNotEmpty) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: widget.results.asMap().entries.map((e) => _buildItem(e.value, e.key, isHistory: false)).toList(),
          ),
        );
      } else {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          alignment: Alignment.center,
          child: Text(
            'No results found for "${_controller.text}"',
            style: const TextStyle(color: Color(0xFF64748B), fontSize: 14),
          ),
        );
      }
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_hasHistory)
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'RECENT SEARCHES',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF64748B),
                      letterSpacing: 0.5,
                    ),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () {
                        widget.onClearHistory?.call();
                        _focusNode.requestFocus();
                      },
                      child: ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds),
                        child: const Text(
                          'Clear All',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: widget.history.asMap().entries.map((e) => _buildItem(e.value, e.key, isHistory: true)).toList(),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildItem(dynamic item, int index, {required bool isHistory}) {
    bool isActive = _activeIndex == index;

    return _HoverItem(
      isActive: isActive,
      onTap: () {
        if (widget.onSelect != null) {
          widget.onSelect!(item);
        }
        _removeOverlay();
        _focusNode.unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(
              isHistory ? Icons.schedule : Icons.search,
              size: 18,
              color: const Color(0xFF94A3B8), // Will be overridden by hover state in _HoverItem
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                _getLabel(item),
                style: const TextStyle(fontSize: 15, color: Color(0xFF1E293B)),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isHistory)
              _RemoveHistoryButton(
                onTap: () {
                  widget.onRemoveHistoryItem?.call(item);
                  _focusNode.requestFocus();
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: _isFocused ? Colors.white : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(24),
          border: _isFocused ? null : Border.all(color: const Color(0xCCE2E8F0)),
          boxShadow: _isFocused
              ? const [
                  BoxShadow(color: Color(0x408B5CF6), blurRadius: 15, offset: Offset(0, 4), spreadRadius: -3),
                  BoxShadow(color: Color(0x268B5CF6), blurRadius: 6, offset: Offset(0, 2), spreadRadius: -2),
                ]
              : const [
                  BoxShadow(color: Color(0x05000000), blurRadius: 4, offset: Offset(0, 2), blurStyle: BlurStyle.inner),
                ],
        ),
        child: Row(
          children: [
            AnimatedScale(
              scale: _isFocused ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 300),
              child: Icon(
                Icons.search,
                color: _isFocused ? const Color(0xFF8B5CF6) : const Color(0xFF64748B),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: KeyboardListener(
                focusNode: FocusNode(), // Dummy focus node for intercepting raw keys
                onKeyEvent: (event) {
                  // We handle up/down/enter via the TextField's onSubmitted or raw keyboard listener if needed.
                  // For simplicity, we can rely on standard text input, but up/down requires FocusNode traversal tricks.
                },
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  style: const TextStyle(fontSize: 15, color: Color(0xFF1E293B)),
                  decoration: InputDecoration(
                    hintText: widget.placeholder,
                    hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: (val) {
                    widget.onChanged?.call(val);
                    _activeIndex = -1;
                    _updateOverlay();
                  },
                  onSubmitted: (val) {
                    widget.onSearch?.call(val);
                    _focusNode.unfocus();
                    _removeOverlay();
                  },
                ),
              ),
            ),
            if (widget.loading)
              const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2.5),
              )
            else if (_controller.text.isNotEmpty)
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    _controller.clear();
                    widget.onChanged?.call('');
                    _focusNode.requestFocus();
                    _updateOverlay();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.cancel,
                      color: Color(0xFF94A3B8),
                      size: 20,
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class _HoverItem extends StatefulWidget {
  final Widget child;
  final bool isActive;
  final VoidCallback onTap;

  const _HoverItem({required this.child, required this.isActive, required this.onTap});

  @override
  State<_HoverItem> createState() => _HoverItemState();
}

class _HoverItemState extends State<_HoverItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    bool active = widget.isActive || _isHovered;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: active ? const Color(0xCCF1F5F9) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: active
                ? const [BoxShadow(color: Color(0xFF8B5CF6), offset: Offset(-2, 0), spreadRadius: 0)]
                : null,
          ),
          transform: Matrix4.translationValues(active ? 6 : 0, 0, 0),
          child: IconTheme(
            data: IconThemeData(
              color: active ? const Color(0xFF8B5CF6) : const Color(0xFF94A3B8),
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class _RemoveHistoryButton extends StatefulWidget {
  final VoidCallback onTap;
  const _RemoveHistoryButton({required this.onTap});

  @override
  State<_RemoveHistoryButton> createState() => _RemoveHistoryButtonState();
}

class _RemoveHistoryButtonState extends State<_RemoveHistoryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: _isHovered ? const Color(0x1AEF4444) : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: AnimatedScale(
            scale: _isHovered ? 1.0 : 0.8,
            duration: const Duration(milliseconds: 200),
            child: Icon(
              Icons.close,
              size: 20,
              color: _isHovered ? const Color(0xFFEF4444) : const Color(0xFFCBD5E1),
            ),
          ),
        ),
      ),
    );
  }
}
