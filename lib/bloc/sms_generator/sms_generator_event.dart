part of 'sms_generator_bloc.dart';

abstract class SmsGeneratorEvent extends Equatable {
  const SmsGeneratorEvent();

  @override
  List<Object?> get props => [];
}

class SmsGeneratorInitial extends SmsGeneratorEvent {}

class SmsGeneratorRun extends SmsGeneratorEvent {
  
  final String bankName;

  const SmsGeneratorRun({
    required this.bankName,
  });

  @override
  List<Object?> get props => [bankName];
}
