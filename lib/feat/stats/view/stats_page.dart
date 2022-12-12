import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/feat/stats/bloc/stats_bloc.dart';
import 'package:todo_app/l10n/l10n.dart';

import 'package:todos_repository/todos_repository.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatsBloc(
        todosRepository: context.read<TodosRepository>(),
      )..add(const StatsSubscriptionRequested()),
      child: const StatsView(),
    );
  }
}

class StatsView extends StatelessWidget {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.strings;
    final state = context.watch<StatsBloc>().state;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.statsAppBarTitle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ListTile(
            key: const Key('statsView_completedTodos_listTile'),
            leading: const Icon(Icons.check_rounded),
            title: Text(strings.statsCompletedTodoCountLabel),
            trailing: Text(
              '${state.completedTodos}',
              style: textTheme.headline5,
            ),
          ),
          ListTile(
            key: const Key('statsView_activeTodos_listTile'),
            leading: const Icon(Icons.radio_button_unchecked_rounded),
            title: Text(strings.statsActiveTodoCountLabel),
            trailing: Text(
              '${state.activeTodos}',
              style: textTheme.headline5,
            ),
          ),
        ],
      ),
    );
  }
}
