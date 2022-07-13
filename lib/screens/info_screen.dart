import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_app/bloc/sms_parser/sms_parser_bloc.dart';
import 'package:sms_app/screens/screens.dart';

import 'package:sms_app/screens/widgets/common_appbar.dart';
import 'package:sms_app/styles.dart';
import 'package:telephony/telephony.dart';

import '../bloc/sms_generator/sms_generator_bloc.dart';


class InfoScreen extends StatefulWidget {
  const InfoScreen({ Key? key }) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {


  List<SmsMessage> listMessages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        name: 'SMS', 
        iconButton: IconButton(
          onPressed: () {
            context.read<SmsParserBloc>().add(SmsParserRun(messages: listMessages));
            Navigator.push(context, MaterialPageRoute(builder: (context) => const FinalSumScreen()));
          }, 
          icon: const Icon(Icons.sms_outlined)
        )
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: BlocBuilder<SmsGeneratorBloc, SmsGeneratorState>(
              builder: (context, state) {
                Widget body = Container();
                if(state is SmsGeneratorLoading) {
                  body = Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(width: double.maxFinite),
                        CircularProgressIndicator(
                          color: AppStyles.secondaryColor,
                        )
                      ],
                    );
                } else if(state is SmsGeneratorSuccess) {
                  body = Column(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: (state.messages ?? []).map((infoSms) {
                          listMessages = state.messages ?? [];
                          return Card(
                            color: AppStyles.mainColor,
                            child: ListTile(
                              leading: const Icon(Icons.message),
                              title: Text('${infoSms.address}', style: AppStyles.buttonTextStyle),
                              subtitle: Text('${infoSms.body}', style: AppStyles.buttonTextStyle),
                            ),
                          );
                        }).toList()
                      ),
                    ],
                  );
                }
                return body;
              }
            ),
          ),
        ),
      ),
    );
  }
}