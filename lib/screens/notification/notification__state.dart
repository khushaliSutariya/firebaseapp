part of 'notification__cubit.dart';

class NotificationState extends Equatable {
  final TextEditingController titleController;
  final TextEditingController timeInput;
  final TextEditingController descriptionController;
   NotificationState({required this.timeInput,required this.titleController, required this.descriptionController});
  @override
  List<Object?> get props => [];

  NotificationState copyWith({
    TextEditingController? titleController,
    TextEditingController? timeInput,
    TextEditingController? descriptionController,
  }) {
    return NotificationState(
      titleController: titleController ?? this.titleController,
      timeInput: timeInput ?? this.timeInput,
      descriptionController: descriptionController ?? this.descriptionController,
    );
  }
}
