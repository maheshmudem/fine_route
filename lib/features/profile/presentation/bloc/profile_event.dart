import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class GetProfileEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  final String fullName;
  final String mobileNumber;
  final String email;
  final String city;
  final String state;

  const UpdateProfileEvent({
    required this.fullName,
    required this.mobileNumber,
    required this.email,
    required this.city,
    required this.state,
  });

  @override
  List<Object?> get props => [fullName, mobileNumber, email, city, state];
}
