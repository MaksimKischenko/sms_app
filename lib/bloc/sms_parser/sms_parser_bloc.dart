import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:telephony/telephony.dart';

part 'sms_parser_event.dart';
part 'sms_parser_state.dart';

class SmsParserBloc extends Bloc<SmsParserEvent, SmsParserState> {

  SmsParserBloc() 
  : super(SmsParserLoading()) {
    on<SmsParserEvent>(_onEvent); 
  }

  void _onEvent(
    SmsParserEvent event,
    Emitter<SmsParserState> emit
  ) {
    if (event is SmsParserRun) return _onSmsParserRun(event, emit);
  }

  void _onSmsParserRun(
    SmsParserRun event,
    Emitter<SmsParserState> emit
  ) async {

    emit(SmsParserLoading());

    var listMessages = event.messages;
    String payInfo = '';  
    List<double?> finalListSum = [];
    double finalSum = 0.0; 


    listMessages?.forEach(((element) {
      if((element.body ?? '' ).contains('Card#9845')) {
        var list = element.body?.split(';');

        list?.forEach((item) {
          if(item.contains('Oplata')) {
            payInfo = item;
          }
        });   

        payInfo.split(' ').forEach((item) {
          if(double.tryParse(item) != null) {
            var paySum = double.tryParse(item);
            finalListSum.add(paySum);
          }
        });
      }
    }));

    finalListSum.forEach((element) {
      finalSum = finalSum + element!;
    });
  
    emit(SmsParserSuccess(
        paySum: finalSum     
     ));
  }
}
