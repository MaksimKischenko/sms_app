import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:telephony/telephony.dart';

part 'sms_generator_event.dart';
part 'sms_generator_state.dart';

class SmsGeneratorBloc extends Bloc<SmsGeneratorEvent, SmsGeneratorState> {

  SmsGeneratorBloc() 
  : super(SmsGeneratorLoading()) {
    on<SmsGeneratorEvent>(_onEvent); 
  }

  void _onEvent(
    SmsGeneratorEvent event,
    Emitter<SmsGeneratorState> emit
  ) {
    if( event is SmsGeneratorInitial) return _onSmsGeneratorInitial(event, emit);
    if (event is SmsGeneratorRun) return _onSmsGeneratorRun(event, emit);

  }

  void _onSmsGeneratorInitial(
    SmsGeneratorInitial event,
    Emitter<SmsGeneratorState> emit
  ) async {

    emit(SmsGeneratorLoading());

    try {
      
     final Telephony telephony = Telephony.instance;

     final messages = await telephony.getInboxSms(
      columns: [SmsColumn.ADDRESS, SmsColumn.BODY],
      sortOrder: [OrderBy(SmsColumn.ADDRESS, sort: Sort.ASC),
        OrderBy(SmsColumn.BODY)]
     );

     emit(SmsGeneratorSuccess(
        messages: messages
     ));

    // ignore: avoid_catches_without_on_clauses
    } catch(error, _) {
      emit(SmsGeneratorError(
        error: error
      ));
    }
  }


  void _onSmsGeneratorRun(
    SmsGeneratorRun event,
    Emitter<SmsGeneratorState> emit
  ) async {

    emit(SmsGeneratorLoading());

    try {
      
     final Telephony telephony = Telephony.instance;

     final messages = await telephony.getInboxSms(
      columns: [SmsColumn.ADDRESS, SmsColumn.BODY],
      filter: SmsFilter.where(SmsColumn.ADDRESS).equals(event.bankName),
      sortOrder: [OrderBy(SmsColumn.ADDRESS, sort: Sort.ASC),
        OrderBy(SmsColumn.BODY)]
     );


     emit(SmsGeneratorSuccess(
        messages: messages
     ));

    // ignore: avoid_catches_without_on_clauses
    } catch(error, _) {
      emit(SmsGeneratorError(
        error: error
      ));
    }
  }
}
