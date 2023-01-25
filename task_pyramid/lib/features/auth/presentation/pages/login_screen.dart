import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../qr_scan/presentation/pages/scan_screen.dart';
import '../cubit/login_cubit.dart';
import '../../../../core/constant/constant.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../widgets/submit_button_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  String value = "";
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        key: scaffoldKey,
        body: SingleChildScrollView(
          child: Padding(
            padding: Constant.kPaddingH30,
            child: Column(
              children: [
                const SizedBox(height: 50),

                Text("Login", style: Constant.bodyText20),
                const SizedBox(height: 40),
                Center(
                  child: CustomFormField(
                    validation: 'Field required',
                    hintText: 'Enter your phone',
                    onChanged: (String value) {
                      context.read<LoginCubit>().loginParams.phone = value;
                    },
                    inputType: TextInputType.phone,
                    focusNode: phoneFocusNode,
                    validationFunction: (value) {
                     if (value!.isEmpty) {
                        return 'Field required';
                      } else {
                        return null;
                      }
                    },
                    onEditingComplete: () {
                      // emailFocusNode.unfocus();
                      // FocusScope.of(context).requestFocus(passwordFocusNode);
                      FocusScope.of(context).nextFocus();
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: CustomFormField(
                      validation: 'Field required',
                      hintText: 'password',
                      focusNode: passwordFocusNode,
                      inputType: TextInputType.visiblePassword,
                      security: true,
                      onChanged: (String value) {
                        context.read<LoginCubit>().loginParams.password = value;},
                      suffixBool: true,
                      textInputAction: TextInputAction.done,
                      saved: (value) async {
                        passwordFocusNode.unfocus();
                        await context.read<LoginCubit>().userLogin(formKey);
                      }),
                ),
                const SizedBox(height: 5),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      'Forget password ?',
                      style: Constant.bodyLineGrey14.copyWith(color:Constant. fontGraylight),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: BlocConsumer<LoginCubit, LoginState>(
                      listener: (context, state) {
                    if (state is LoginSuccess) {
                      Constant.pushReplacment(
                          context, const QrCodeScreen());
                    } else if (state is LoginError) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.message),
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.red,
                      ));
                    }
                  }, builder: (context, loginState) {
                    if (loginState is LoginLoading) {
                      return Center(child: Constant.indicator);
                    } else {
                      return SubmitButton(
                        title: 'Login',
                        function: () async {
                          await context
                              .read<LoginCubit>()
                              .userLogin(formKey);
                          // bottomIcon: Icons.arrow_back,
                        },
                      );
                    }
                  }),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
