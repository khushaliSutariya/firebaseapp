
class HobbyModelList {
  String text;
  bool value;

  HobbyModelList({required this.text, required this.value});

  HobbyModelList copyWith({
    String? text,
    bool? value,
  }) {
    return HobbyModelList(
      text: text ?? this.text,
      value: value ?? this.value,
    );
  }
}