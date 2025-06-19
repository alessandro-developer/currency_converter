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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 20),

        /// AMOUNT INPUT FIELD:
        Text(
          'Amount:',
          style: CustomTextStyle.s15w700(ColorPalette.black),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 10),
        BlocSelector<HomeCubit, HomeState, Ammount>(
          selector: (state) => state.ammount,
          builder: (context, ammount) {
            return CustomTextField(
              errorText: ammount.displayError != null ? 'Amount not valid' : null,
              errorStyle: CustomTextStyle.s15w500(ColorPalette.redDark),
              hint: 'Amount',
              hintStyle: CustomTextStyle.s15w500(ColorPalette.grey),
              initialValue: ammount.value,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              onChanged: (value) => homeCubit.ammountChanged(value),
              style: CustomTextStyle.s15w500(ColorPalette.black),
            );
          },
        ),
        const SizedBox(height: 20),

        Text(
          'Select the currency:',
          style: CustomTextStyle.s15w700(ColorPalette.black),
          textAlign: TextAlign.left,
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  /// CURRENCY SELECTION DROPDOWN:
                  BlocSelector<HomeCubit, HomeState, bool>(
                    selector: (state) => state.showMenu,
                    builder: (context, showMenu) => GestureDetector(
                      onTap: () {
                        homeCubit.manageMenuToggle(showMenu: !showMenu);
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: Container(
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
                              child: BlocSelector<HomeCubit, HomeState, List<String>>(
                                selector: (state) => <String>[
                                  state.selectedCurrencyCode,
                                  state.selectedCurrencyName,
                                ],
                                builder: (context, selectedCurrencyInfo) {
                                  final String selectedCurrencyCode = selectedCurrencyInfo[0];
                                  final String selectedCurrencyName = selectedCurrencyInfo[1];

                                  return Text(
                                    selectedCurrencyName.isNotEmpty ? '$selectedCurrencyCode: $selectedCurrencyName' : 'Select the currency',
                                    style: CustomTextStyle.s15w500(selectedCurrencyName.isNotEmpty ? ColorPalette.black : ColorPalette.grey),
                                  );
                                },
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
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// CONVERSION RATES GRID:
                  BlocBuilder<HomeCubit, HomeState>(
                    buildWhen: (previous, current) => previous.conversionRates != current.conversionRates,
                    builder: (context, homeState) {
                      final Map<String, double> ratesMap = homeState.conversionRates;

                      if (ratesMap.isEmpty) {
                        return Center(
                          child: Text(
                            'No conversion rates available.',
                            style: CustomTextStyle.s17w700(ColorPalette.black),
                          ),
                        );
                      }

                      return Expanded(
                        child: GridView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                          ),
                          itemCount: ratesMap.length,
                          itemBuilder: (context, index) {
                            final String currencyCode = ratesMap.keys.elementAt(index);
                            final double rate = ratesMap[currencyCode]!;

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
                                const SizedBox(height: 5),

                                Container(
                                  height: 40,
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: ColorPalette.greenLight.withValues(alpha: 0.4),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: ColorPalette.greenLight),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    rate.toStringAsFixed(2),
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
              ),

              /// CURRENCY SELECTION MENU:
              BlocSelector<HomeCubit, HomeState, bool>(
                selector: (state) => state.showMenu,
                builder: (context, showMenu) => Positioned(
                  top: 50.0 + 20.0,
                  left: 0,
                  right: 0,
                  child: Visibility(
                    visible: showMenu,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.4,
                      ),
                      decoration: BoxDecoration(
                        color: ColorPalette.white,
                        border: Border.all(color: ColorPalette.grey),
                        borderRadius: const BorderRadius.all(Radius.circular(5)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: BlocBuilder<ApiCallsCubit, ApiCallsState>(
                        builder: (context, apiCallsState) => BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, homeState) => ListView.builder(
                            itemCount: apiCallsState.resultsSupportedCodes.supportedCodes.length,
                            itemBuilder: (context, index) {
                              final SupportedCodesModel supportedCodes = apiCallsState.resultsSupportedCodes.supportedCodes[index];
                              final bool isSelected = supportedCodes.code == homeState.selectedCurrencyCode;

                              return ListTile(
                                title: Text(
                                  '${supportedCodes.code}: ${supportedCodes.name}',
                                  style: isSelected ? CustomTextStyle.s15w700(ColorPalette.black) : CustomTextStyle.s15w400(ColorPalette.black),
                                ),
                                onTap: () => homeCubit.selectCurrency(
                                  code: supportedCodes.code,
                                  name: supportedCodes.name,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
