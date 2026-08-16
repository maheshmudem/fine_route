import 'package:equatable/equatable.dart';

abstract class BusinessEvent extends Equatable {
  const BusinessEvent();

  @override
  List<Object?> get props => [];
}

class GetBusinessEvent extends BusinessEvent {}

class UpdateBusinessEvent extends BusinessEvent {
  final Map<String, dynamic> changedFields;

  const UpdateBusinessEvent({
    required this.changedFields,
  });

  @override
  List<Object?> get props => [changedFields];
}
