part of 'cloudnotification_cubit.dart';


class CloudNotificationState extends Equatable {
  String opToken;
  FirebaseMessaging? firebaseMessaging;
  CloudNotificationState({required this.opToken, this.firebaseMessaging});
  @override
  // TODO: implement props
  List<Object?> get props => [opToken,firebaseMessaging];

  CloudNotificationState copyWith({
    String? opToken,
    FirebaseMessaging? firebaseMessaging,
  }) {
    return CloudNotificationState(
      opToken: opToken ?? this.opToken,
      firebaseMessaging: firebaseMessaging ?? this.firebaseMessaging,
    );
  }
}
