part of 'language_cubit.dart';



class LanguageState extends Equatable {
  Locale? locale;
  LanguageState({this.locale});
  @override
  // TODO: implement props
  List<Object?> get props => [locale];

  LanguageState copyWith({
    Locale? locale,
  }) {
    return LanguageState(
      locale: locale ?? this.locale,
    );
  }
}
