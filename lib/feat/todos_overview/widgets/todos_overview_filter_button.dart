import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/feat/todos_overview/bloc/todos_overview_bloc.dart';
import 'package:todo_app/feat/todos_overview/models/todos_view_filter.dart';
import 'package:todo_app/l10n/l10n.dart';

class TodosOverviewFilterButton extends StatelessWidget {
  const TodosOverviewFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.strings;

    final activeFilter =
        context.select((TodosOverviewBloc bloc) => bloc.state.filter);

    return PopupMenuButton<TodosViewFilter>(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      initialValue: activeFilter,
      tooltip: l10n.todosOverviewFilterTooltip,
      onSelected: (filter) {
        context
            .read<TodosOverviewBloc>()
            .add(TodosOverviewFilterChanged(filter));
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: TodosViewFilter.all,
            child: Text(l10n.todosOverviewFilterAll),
          ),
          PopupMenuItem(
            value: TodosViewFilter.activeOnly,
            child: Text(l10n.todosOverviewFilterActiveOnly),
          ),
          PopupMenuItem(
            value: TodosViewFilter.completedOnly,
            child: Text(l10n.todosOverviewFilterCompletedOnly),
          ),
        ];
      },
      icon: const Icon(Icons.filter_list_rounded),
    );
  }
}
