import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:currency_converter/business_logic.dart';
import 'package:currency_converter/presentation.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.greenLight,
        centerTitle: true,
        title: Text(
          'Currency Converter',
          style: CustomTextStyle.s31w600(ColorPalette.white),
        ),
        toolbarHeight: 60,
      ),
      backgroundColor: ColorPalette.greyLight6,
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SafeArea(
          bottom: false,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.center,
              child: BlocConsumer<ApiCallsCubit, ApiCallsState>(
                listener: (context, state) {
                  if (state.getConversionRatesStatus == FormzSubmissionStatus.success) {
                    context.read<HomeCubit>().initializeConversionRates(
                      rawRates: state.resultsConversionRates.conversionRates,
                      supportedCodes: state.resultsSupportedCodes.supportedCodes,
                    );
                  }
                },
                builder: (context, state) => switch (state.getConversionRatesStatus) {
                  FormzSubmissionStatus.inProgress => Center(
                    child: CircularProgressIndicator(color: ColorPalette.greenLight),
                  ),
                  FormzSubmissionStatus.success => HomeWidget(),
                  FormzSubmissionStatus.failure => Center(
                    child: Text(
                      state.errorMessage.isNotEmpty ? state.errorMessage : '',
                      style: CustomTextStyle.s17w700(ColorPalette.black),
                    ),
                  ),
                  _ => Container(),
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
