import 'package:flutter/material.dart';

class PPKanbanCardData {
  final String id;
  final String title;
  final dynamic payload;

  PPKanbanCardData({
    required this.id,
    required this.title,
    this.payload,
  });
}

class PPKanbanColumnData {
  final String id;
  final String title;
  final List<PPKanbanCardData> cards;

  PPKanbanColumnData({
    required this.id,
    required this.title,
    required this.cards,
  });
}

class PPKanbanBoard extends StatefulWidget {
  final List<PPKanbanColumnData> columns;
  final void Function(List<PPKanbanColumnData> newColumns)? onColumnsChanged;
  final Widget Function(BuildContext context, PPKanbanCardData card)? cardBuilder;
  final double columnWidth;

  const PPKanbanBoard({
    super.key,
    required this.columns,
    this.onColumnsChanged,
    this.cardBuilder,
    this.columnWidth = 300.0,
  });

  @override
  State<PPKanbanBoard> createState() => _PPKanbanBoardState();
}

class _PPKanbanBoardState extends State<PPKanbanBoard> {
  late List<PPKanbanColumnData> _columns;

  @override
  void initState() {
    super.initState();
    _columns = widget.columns;
  }

  @override
  void didUpdateWidget(PPKanbanBoard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.columns != oldWidget.columns) {
      _columns = widget.columns;
    }
  }

  void _handleDrop(String fromColId, String toColId, String cardId, int? insertIndex) {
    setState(() {
      final fromColIndex = _columns.indexWhere((c) => c.id == fromColId);
      final toColIndex = _columns.indexWhere((c) => c.id == toColId);
      
      if (fromColIndex == -1 || toColIndex == -1) return;

      final cardIndex = _columns[fromColIndex].cards.indexWhere((c) => c.id == cardId);
      if (cardIndex == -1) return;

      final card = _columns[fromColIndex].cards.removeAt(cardIndex);
      
      if (insertIndex == null || insertIndex > _columns[toColIndex].cards.length) {
        _columns[toColIndex].cards.add(card);
      } else {
        int finalInsertIndex = insertIndex;
        // Adjust insert index if moving within the same column and dropping after its original position
        if (fromColId == toColId && cardIndex < finalInsertIndex) {
          finalInsertIndex -= 1;
        }
        _columns[toColIndex].cards.insert(finalInsertIndex, card);
      }
      
      widget.onColumnsChanged?.call(_columns);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _columns.map((column) => _buildColumn(column)).toList(),
      ),
    );
  }

  Widget _buildColumn(PPKanbanColumnData column) {
    return Container(
      width: widget.columnWidth,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Column Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    column.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF374151),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E7EB),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '${column.cards.length}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Column Content area as a DragTarget
          Flexible(
            child: DragTarget<Map<String, dynamic>>(
              onAcceptWithDetails: (details) {
                _handleDrop(
                  details.data['columnId'],
                  column.id,
                  details.data['cardId'],
                  null, // Append to end
                );
              },
              builder: (context, candidateData, rejectedData) {
                return Container(
                  constraints: const BoxConstraints(minHeight: 100),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(12),
                    itemCount: column.cards.length,
                    itemBuilder: (context, index) {
                      final card = column.cards[index];
                      return _buildDragTargetCard(column, card, index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDragTargetCard(PPKanbanColumnData column, PPKanbanCardData card, int index) {
    return DragTarget<Map<String, dynamic>>(
      onAcceptWithDetails: (details) {
        _handleDrop(
          details.data['columnId'],
          column.id,
          details.data['cardId'],
          index,
        );
      },
      builder: (context, candidateData, rejectedData) {
        final isHovering = candidateData.isNotEmpty;
        
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isHovering) 
              Container(
                height: 4,
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Draggable<Map<String, dynamic>>(
                data: {
                  'columnId': column.id,
                  'cardId': card.id,
                },
                feedback: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: widget.columnWidth - 24, // subtract padding
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    child: _buildCardContent(card),
                  ),
                ),
                childWhenDragging: Opacity(
                  opacity: 0.4,
                  child: _buildCardContent(card),
                ),
                child: _buildCardContent(card),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCardContent(PPKanbanCardData card) {
    if (widget.cardBuilder != null) {
      return widget.cardBuilder!(context, card);
    }
    
    // Default Card
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000), // 0.1 opacity black
            blurRadius: 3,
            offset: Offset(0, 1),
          )
        ],
      ),
      child: Text(
        card.title,
        style: const TextStyle(
          fontSize: 14,
          color: Color(0xFF1F2937),
        ),
      ),
    );
  }
}
