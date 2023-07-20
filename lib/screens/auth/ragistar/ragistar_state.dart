part of 'ragistar_cubit.dart';

class RagistarState extends Equatable {
  final FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController fullName;
  TextEditingController lastName;
  TextEditingController phone;
  TextEditingController email;
  TextEditingController password;
  TextEditingController confirmPassword;
  final GlobalKey<FormState> formKey;
  int selectedIndex;
  RagistarState(
      {required this.email,
      required this.lastName,
      required this.fullName,
      required this.confirmPassword,
      required this.password,
      required this.phone,required this.formKey,required this.selectedIndex});
  @override
  List<Object?> get props => [auth,formKey,selectedIndex];

  RagistarState copyWith({
    TextEditingController? fullName,
    TextEditingController? lastName,
    TextEditingController? phone,
    TextEditingController? email,
    TextEditingController? password,
    TextEditingController? confirmPassword,
    GlobalKey<FormState>? formKey,
    int? selectedIndex,
  }) {
    return RagistarState(
      fullName: fullName ?? this.fullName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      formKey: formKey ?? this.formKey,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
