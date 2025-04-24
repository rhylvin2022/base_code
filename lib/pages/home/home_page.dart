import 'package:base_code/blocs/authentication/authentication_bloc.dart';
import 'package:base_code/blocs/localization/app_localization.dart';
import 'package:base_code/blocs/sample_bloc/sample_bloc_bloc.dart';
import 'package:base_code/global/app_colors.dart';
import 'package:base_code/widgets/base_view.dart';
import 'package:base_code/widgets/primary_button.dart';
import 'package:base_code/widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends BaseView {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends BaseViewState {
  String setup = '';
  String punchLine = '';
  @override
  Widget rootWidget(BuildContext context) => MultiBlocListener(
        listeners: [
          BlocListener<SampleBlocBloc, SampleBlocState>(
              listener: (context, state) {
            if (state is GetSampleBlocSuccess) {
              hideLoadingDialog(context);
              setState(() {
                setup = state.response.setup!;
                punchLine = state.response.punchline!;
              });
            }
          }),
        ],
        child: Scaffold(
          backgroundColor: AppColors.white,
          body: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrimaryButton(
                      buttonText:
                          '${AppLocalizations.of(context)!.translate("trigger_api")}',
                      onPressed: () {
                        showLoadingDialog(context);
                        context.read<SampleBlocBloc>().add(GetSampleBloc());
                      },
                    ),
                    VerticalSpace(),
                    PrimaryButton(
                      buttonText:
                          '${AppLocalizations.of(context)!.translate("logout")}',
                      onPressed: () {
                        context
                            .read<AuthenticationBloc>()
                            .add(AuthenticationLogoutRequested());
                      },
                    ),
                    VerticalSpace(),
                    setup == ''
                        ? Container()
                        : Text(
                            setup,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 19,
                                color: AppColors.primaryColor,
                                fontFamily: "Satoshi-Bold"),
                          ),
                    VerticalSpace(),
                    punchLine == ''
                        ? Container()
                        : Text(
                            punchLine,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 19,
                                color: AppColors.primaryColor,
                                fontFamily: "Satoshi-Bold"),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
