part of 'sms_generator_bloc.dart';

abstract class SmsGeneratorState extends Equatable {
  const SmsGeneratorState();
  
  @override
  List<Object?> get props => [];
}

class SmsGeneratorLoading extends SmsGeneratorState {}

class SmsGeneratorSuccess extends SmsGeneratorState {

  final List<SmsMessage>? messages;

  const SmsGeneratorSuccess({
    this.messages,
  });

  @override
  List<Object?> get props => [messages];
}

class SmsGeneratorError extends SmsGeneratorState {
  final Object error;

  const SmsGeneratorError({
    required this.error
  });

  @override
  List<Object?> get props => [error];
}