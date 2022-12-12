import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../json_map.dart';

part 'todo_model.g.dart';

/// {@template todo}
/// A single todo item.
///
/// Contains a [title], [description] and [id], in addition to a [isCompleted]
/// flag.
///
/// If an [id] is provided, it cannot be empty. If no [id] is provided, one
/// will be generated.
///
/// [Todo]s are immutable and can be copied using [copyWith], in addition to
/// being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}

@immutable
@JsonSerializable()
class Todo extends Equatable {
  /// {@macro todo}
  Todo({
    String? id,
    required this.title,
    this.description = '',
    this.isCompleted = false,
  })  : assert(
          id == null || id.isNotEmpty,
          'id can not be null and should be empty',
        ),
        id = id ?? const Uuid().v4();

  ///id for the todo
  final String id;

  ///title for the todo
  final String title;

  ///description for the todo
  final String description;

  ///isCompleted for the todo
  final bool isCompleted;

  ///for update the todo, return a old todo with updated values
  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  ///convert json data to a todo object
  static Todo fromJson(JsonMap json) => _$TodoFromJson(json);

  ///convert todo object to json data
  JsonMap toJson() => _$TodoToJson(this);

  @override
  List<Object> get props => [id, title, description, isCompleted];
}
