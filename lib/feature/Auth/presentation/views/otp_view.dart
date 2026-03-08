import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/app_color.dart';
import '../../../../core/di/get_it.dart';
import '../../domain/auth_repo/reset_repo.dart';
import '../reset_cubit/reset_cubit.dart';
import '../reset_cubit/reset_state.dart';
import '../widgets/gradient_button.dart';
import '../widgets/otp_timer.dart';
import 'success_view.dart';

class OTPView extends StatefulWidget {
  final String email;
  const OTPView(this.email, {super.key});

  static const String routeName = 'otpView';

  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  final _c1 = TextEditingController();
  final _c2 = TextEditingController();
  final _c3 = TextEditingController();
  final _c4 = TextEditingController();

  final _f1 = FocusNode();
  final _f2 = FocusNode();
  final _f3 = FocusNode();
  final _f4 = FocusNode();

  String get otpCode => "${_c1.text}${_c2.text}${_c3.text}${_c4.text}";

  @override
  void dispose() {
    _c1.dispose();
    _c2.dispose();
    _c3.dispose();
    _c4.dispose();
    _f1.dispose();
    _f2.dispose();
    _f3.dispose();
    _f4.dispose();
    super.dispose();
  }

  InputDecoration _otpDecoration() {
    return InputDecoration(
      counterText: "",
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.withValues(alpha: .3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColor.purColor, width: 1.6),
      ),
    );
  }

  Widget _otpBox({
    required TextEditingController controller,
    required FocusNode focusNode,
    required FocusNode? next,
    required FocusNode? prev,
  }) {
    return SizedBox(
      width: 70,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        maxLength: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
        ],
        decoration: _otpDecoration(),
        onChanged: (v) {
          if (v.length == 1 && next != null) {
            next.requestFocus();
          }
          if (v.isEmpty && prev != null) {
            prev.requestFocus();
          }
          setState(() {});
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ResetCubit(getIt.get<ResetRepo>()),
      child: Scaffold(
        body: BlocConsumer<ResetCubit, ResetState>(
          listener: (context, state) async {
            if (state is OtpVerified) {
              context.read<ResetCubit>().sendResetLink(widget.email);
            }

            if (state is ResetLinkSent) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const SuccessView()),
              );
            }

            if (state is ResetError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            final loading = state is ResetLoading;

            return Directionality(
              textDirection: TextDirection.rtl,
              child: Stack(
                children: [
                  // Background gradient
                  Container(
                    decoration: BoxDecoration(
                     color: AppColor.accent
                    ),
                  ),

                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(Icons.arrow_back_ios, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // White card
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.78,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(26),
                          topRight: Radius.circular(26),
                        ),
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 18),

                          // badge circle
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF4F3FF),
                              borderRadius: BorderRadius.circular(32),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "${otpCode.isEmpty ? "" : otpCode.length}*",
                              style: TextStyle(
                                color: AppColor.purColor,
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),

                          const SizedBox(height: 18),
                          const Text(
                            "ادخل رمز التحقق",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 8),

                          Text(
                            "لقد قمنا بارسال رمز التأكيد للبريد الإلكتروني التالي",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.email,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),

                          const SizedBox(height: 24),

                          // OTP boxes
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _otpBox(controller: _c1, focusNode: _f1, next: _f2, prev: null),
                              _otpBox(controller: _c2, focusNode: _f2, next: _f3, prev: _f1),
                              _otpBox(controller: _c3, focusNode: _f3, next: _f4, prev: _f2),
                              _otpBox(controller: _c4, focusNode: _f4, next: null, prev: _f3),
                            ],
                          ),

                          const SizedBox(height: 18),

                          // Timer
                          OTPTimer(
                            onResend: () => context.read<ResetCubit>().sendOTP(widget.email),
                          ),

                          const SizedBox(height: 8),

                          // Resend text
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "لم تستلم رمزًا؟ ",
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                              TextButton(
                                onPressed: () => context.read<ResetCubit>().sendOTP(widget.email),
                                child: Text(
                                  "طلب رمز جديد",
                                  style: TextStyle(
                                    color: AppColor.accent,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const Spacer(),

                          GradientButton(
                            text: "تحقق",
                            loading: loading,
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              if (otpCode.length != 4) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("من فضلك أدخل رمز مكوّن من 4 أرقام")),
                                );
                                return;
                              }
                              context.read<ResetCubit>().verifyOTP(widget.email, otpCode);
                            },
                          ),

                          const SizedBox(height: 18),

                          // Bottom links (optional like screenshot)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  // navigate to login if you want
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "تسجيل الدخول!",
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Text(
                                "تذكرت كلمة المرور؟",
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
