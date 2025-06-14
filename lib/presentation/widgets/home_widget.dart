import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:currency_converter/business_logic.dart';
import 'package:currency_converter/data.dart';
import 'package:currency_converter/presentation.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Cubits:
    final HomeCubit homeCubit = context.read<HomeCubit>();
    return Column(
      children: <Widget>[
        const SizedBox(height: 20),

        BlocSelector<HomeCubit, HomeState, Ammount>(
          selector: (state) => state.ammount,
          builder: (context, ammount) {
            return CustomTextField(
              errorText: ammount.displayError != null ? 'Error' : null,
              errorStyle: CustomTextStyle.s15w500(ColorPalette.redDark),
              hint: 'Amount',
              hintStyle: CustomTextStyle.s15w500(ColorPalette.grey),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              onChanged: (value) => homeCubit.ammountChanged(value),
              style: CustomTextStyle.s15w500(ColorPalette.black),
            );
          },
        ),
        const SizedBox(height: 20),

        BlocSelector<HomeCubit, HomeState, bool>(
          selector: (state) => state.showMenu,
          builder: (context, showMenu) {
            final HomeCubit homeCubit = context.read<HomeCubit>();
            return GestureDetector(
              onTap: () {
                homeCubit.manageMenuToggle(showMenu: !showMenu);
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: Column(
                children: <Widget>[
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: ColorPalette.white,
                      border: Border.all(
                        color: ColorPalette.grey,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Select the currency',
                            style: CustomTextStyle.s15w500(ColorPalette.grey),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Icon(
                            !showMenu ? Icons.expand_more_rounded : Icons.expand_less_rounded,
                            color: ColorPalette.greenLight,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                  ),

                  BlocBuilder<ApiCallsCubit, ApiCallsState>(
                    builder: (context, state) {
                      return Visibility(
                        visible: showMenu,
                        child: Container(
                          constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height * 0.4,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorPalette.grey,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(5)),
                          ),
                          child: ListView.builder(
                            itemCount: state.resultsSupportedCodes.supportedCodes.length,
                            itemBuilder: (context, index) {
                              final SupportedCodesModel supportedCodes = state.resultsSupportedCodes.supportedCodes[index];

                              return ListTile(
                                title: Text(
                                  '${supportedCodes.code}: ${supportedCodes.name}',
                                  style: CustomTextStyle.s15w400(ColorPalette.black),
                                ),
                                onTap: () {},
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(height: 20),

        BlocBuilder<ApiCallsCubit, ApiCallsState>(
          builder: (context, state) {
            final ResultsConversionRatesModel response = state.resultsConversionRates;
            final Map<String, dynamic> ratesMap = response.conversionRates;

            return Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.8,
                ),
                itemCount: ratesMap.length,
                itemBuilder: (context, index) {
                  final String currencyCode = ratesMap.keys.elementAt(index);
                  final double rate = ratesMap[currencyCode];

                  return Column(
                    children: <Widget>[
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorPalette.greyLight3,
                          border: Border.all(color: ColorPalette.grey),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          currencyCode,
                          style: CustomTextStyle.s15w500(ColorPalette.black),
                        ),
                      ),
                      const SizedBox(height: 10),

                      Container(
                        height: 50,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                          color: ColorPalette.greenLight.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: ColorPalette.greenLight),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          rate.toString(),
                          style: CustomTextStyle.s15w600(ColorPalette.black),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
