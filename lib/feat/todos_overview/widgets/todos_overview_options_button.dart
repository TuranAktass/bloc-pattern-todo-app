import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/feat/auth/bloc/auth_bloc_bloc.dart';
import 'package:todo_app/feat/todos_overview/bloc/todos_overview_bloc.dart';
import 'package:todo_app/l10n/l10n.dart';

@visibleForTesting
enum TodosOverviewOption { toggleAll, clearCompleted, logout }

class TodosOverviewOptionsButton extends StatelessWidget {
  const TodosOverviewOptionsButton({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;

    final todos = context.select((TodosOverviewBloc bloc) => bloc.state.todos);
    final hasTodos = todos.isNotEmpty;
    final completedTodosAmount = todos.where((todo) => todo.isCompleted).length;

    return PopupMenuButton<TodosOverviewOption>(
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      tooltip: strings.todosOverviewOptionsTooltip,
      onSelected: (options) {
        switch (options) {
          case TodosOverviewOption.toggleAll:
            context
                .read<TodosOverviewBloc>()
                .add(const TodosOverviewToggleAllRequested());
            break;
          case TodosOverviewOption.clearCompleted:
            context
                .read<TodosOverviewBloc>()
                .add(const TodosOverviewClearCompletedRequested());
            break;
          case TodosOverviewOption.logout:
            context.read<AuthBlocBloc>().add(LoggedOut());
            break;
        }
      },
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: TodosOverviewOption.toggleAll,
            enabled: hasTodos,
            child: Text(
              completedTodosAmount == todos.length
                  ? strings.todosOverviewOptionsMarkAllIncomplete
                  : strings.todosOverviewOptionsMarkAllComplete,
            ),
          ),
          PopupMenuItem(
            value: TodosOverviewOption.clearCompleted,
            enabled: hasTodos && completedTodosAmount > 0,
            child: Text(strings.todosOverviewOptionsClearCompleted),
          ),
          PopupMenuItem(
            value: TodosOverviewOption.logout,
            enabled: true,
            child: Text(strings.signout),
          ),
        ];
      },
      icon: const Icon(Icons.more_vert_rounded),
    );
  }
}
