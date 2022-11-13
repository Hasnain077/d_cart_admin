import 'package:d_cart_admin/components/common_button.dart';
import 'package:d_cart_admin/components/custom_background.dart';
import 'package:d_cart_admin/components/text_form_field.dart';
import 'package:d_cart_admin/providers/login_provider.dart';
import 'package:d_cart_admin/utils/mytheme.dart';
import 'package:d_cart_admin/utils/responsive_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = true;
  bool isObscure = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  late Size size;
  late LoginProvider loginProvider;
  @override
  void initState() {
    loginProvider = Provider.of<LoginProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: ResponsiveBuilder(
        mobile: CustomBackground(
          fit: BoxFit.fitHeight,
          asset: "assets/png/login_portrait_background.jpg",
          child: loginForm,
        ),
        tablet: desktopLogin,
        web: desktopLogin,
      ),
    );
  }

  Widget get desktopLogin => CustomBackground(
        fit: BoxFit.fill,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Container(),
            ),
            Expanded(
              flex: 1,
              child: loginForm,
            ),
          ],
        ),
      );

  Widget get loginForm => Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 30,
            child: Container(
              padding: const EdgeInsets.all(20),
              width: double.maxFinite,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "Signin",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 29,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Text(
                      "Welcome back",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormFieldComponent(
                      title: "Your Email",
                      hint: "email@address.com",
                      controller: _emailController,
                    ),
                    const SizedBox(height: 20),
                    Consumer<LoginProvider>(
                      builder: (_, ref, child) => TextFormFieldComponent(
                        isObscure: ref.obscure,
                        title: "Password",
                        controller: _passController,
                        hint: "6+ characters required",
                        suffixWidget: InkWell(
                          splashColor: Colors.white,
                          hoverColor: Colors.white,
                          onTap: () {
                            ref.toggleObscure();
                          },
                          child: Icon(
                            !ref.obscure ? Icons.visibility_off : Icons.visibility,
                            color: MyTheme.textFormBorder,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Consumer<LoginProvider>(
                      builder: (_, ref, child) => CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        checkboxShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3),
                        ),
                        value: ref.checked,
                        checkColor: Colors.white,
                        activeColor: MyTheme.textFormBorder,
                        title: const Text("Remember me"),
                        controlAffinity: ListTileControlAffinity.leading,
                        visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                        onChanged: (checked) {
                          ref.toggleCheck(checked ?? false);
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Consumer<LoginProvider>(
                      builder: (_, ref, child) => CommonButton(
                        text: ref.isLoading ? "Loading..." : "Login",
                        textStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        onPressed: ref.isLoading
                            ? null
                            : () {
                                ref.login("username", "password");
                              },
                        borderRadius: 8,
                        verticalPadding: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
