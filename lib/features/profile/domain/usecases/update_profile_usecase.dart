import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class UpdateProfileParams {
  final String fullName;
  final String mobileNumber;
  final String email;
  final String city;
  final String state;

  UpdateProfileParams({
    required this.fullName,
    required this.mobileNumber,
    required this.email,
    required this.city,
    required this.state,
  });

  Map<String, dynamic> toJson() => {
        'full_name': fullName,
        'mobile_number': mobileNumber,
        'email': email,
        'city': city,
        'state': state,
      };
}

class UpdateProfileUseCase implements UseCase<Profile, UpdateProfileParams> {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  @override
  Future<Either<Failure, Profile>> call(UpdateProfileParams params) {
    return repository.updateProfile(params.toJson());
  }
}
