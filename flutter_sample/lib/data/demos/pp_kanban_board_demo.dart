import 'package:flutter/material.dart';
import 'package:flutter_ui_framework/flutter_ui_framework.dart';
import '../../models/component_item.dart';

class _PPKanbanDemo extends StatefulWidget {
  const _PPKanbanDemo();

  @override
  State<_PPKanbanDemo> createState() => _PPKanbanDemoState();
}

class _PPKanbanDemoState extends State<_PPKanbanDemo> {
  late List<PPKanbanColumnData> columns;

  @override
  void initState() {
    super.initState();
    columns = [
      PPKanbanColumnData(
        id: 'todo',
        title: 'To Do',
        cards: [
          PPKanbanCardData(id: '1', title: 'Research competitors'),
          PPKanbanCardData(id: '2', title: 'Design landing page'),
          PPKanbanCardData(id: '3', title: 'Write documentation'),
        ],
      ),
      PPKanbanColumnData(
        id: 'in-progress',
        title: 'In Progress',
        cards: [
          PPKanbanCardData(id: '4', title: 'Develop login screen'),
          PPKanbanCardData(id: '5', title: 'Set up database'),
        ],
      ),
      PPKanbanColumnData(
        id: 'done',
        title: 'Done',
        cards: [
          PPKanbanCardData(id: '6', title: 'Project setup'),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PPKanbanBoard(
      columns: columns,
      onColumnsChanged: (newColumns) {
        setState(() {
          columns = newColumns;
        });
      },
    );
  }
}

final ComponentItem pp_kanban_boardData = ComponentItem(
  name: 'PPKanbanBoard',
  description: 'A drag-and-drop Kanban board for managing tasks across columns.',
  demoCode: '''PPKanbanBoard(
  columns: [
    PPKanbanColumnData(
      id: 'todo',
      title: 'To Do',
      cards: [
        PPKanbanCardData(id: '1', title: 'Research competitors'),
        PPKanbanCardData(id: '2', title: 'Design landing page'),
      ],
    ),
    PPKanbanColumnData(
      id: 'in-progress',
      title: 'In Progress',
      cards: [
        PPKanbanCardData(id: '3', title: 'Develop login screen'),
      ],
    ),
  ],
  onColumnsChanged: (newColumns) {
    setState(() => columns = newColumns);
  },
)''',
  demoBuilder: (context) {
    return Container(
      height: 500,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: _PPKanbanDemo(),
      ),
    );
  },
);
