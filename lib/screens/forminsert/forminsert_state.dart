part of 'forminsert_cubit.dart';

class FormInsertState extends Equatable {
  final TextEditingController name;
  final TextEditingController birthDate;
  final TextEditingController phone;
  final TextEditingController pinCode;
  final TextEditingController email;
   String country;
   String city;
   String state;
   String gender;
  List<HobbyModelList> selectedHobbys = [];
  List<HobbyModelList> hobby = [];
  DateTime selectedDate;
  FormInsertState(
      {
      required this.email,
      required this.name,
      required this.city,
      required this.gender,
      required this.hobby,
      required this.selectedHobbys,
      required this.phone,
      required this.state,
      required this.country,
      required this.pinCode,
      required this.birthDate,
      required this.selectedDate});
  @override
  // TODO: implement props
  List<Object?> get props =>
      [city, gender, hobby, selectedHobbys, name,birthDate, phone, selectedDate, city, state, country];

  FormInsertState copyWith({
    TextEditingController? name,
    TextEditingController? birthDate,
    TextEditingController? phone,
    TextEditingController? pinCode,
    TextEditingController? email,
    String? country,
    String? city,
    String? state,
    String? gender,
    List<HobbyModelList>? selectedHobbys,
    List<HobbyModelList>? hobby,
    DateTime? selectedDate,
  }) {
    return FormInsertState(
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      phone: phone ?? this.phone,
      pinCode: pinCode ?? this.pinCode,
      email: email ?? this.email,
      country: country ?? this.country,
      city: city ?? this.city,
      state: state ?? this.state,
      gender: gender ?? this.gender,
      selectedHobbys: selectedHobbys ?? this.selectedHobbys,
      hobby: hobby ?? this.hobby,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
