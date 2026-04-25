part of 'sign_in_page.dart';

/// SignIn page content section
class SignInPageContent extends StatefulWidget {
  /// constructor
  const SignInPageContent({super.key});

  @override
  State<SignInPageContent> createState() => _SignInPageContentState();
}

class _SignInPageContentState extends State<SignInPageContent> {
  late final TextEditingController _emailTec;
  late final TextEditingController _passwordTec;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _emailTec = TextEditingController();
    _passwordTec = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailTec.dispose();
    _passwordTec.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.h),
        child: Column(
          children: [
            SizedBox(height: 30.h),

            AppTextField(
              label: 'Email',
              hint: 'john@g.co',
              controller: _emailTec,
              focusNode: _emailFocusNode,
              onChanged: context.read<SignInCubit>().onSetEmail,
              onSubmitted: (_) => _passwordFocusNode.requestFocus(),
            ),

            SizedBox(height: 10.h),

            AppTextField(
              label: 'Password',
              hint: '********',
              controller: _passwordTec,
              focusNode: _passwordFocusNode,
              obscureText: true,
              onChanged: context.read<SignInCubit>().onSetPassword,
              // clear focus
              onSubmitted: (_) => _passwordFocusNode.unfocus(),
            ),

            SizedBox(height: 30.h),

            BlocBuilder<SignInCubit, SignInState>(
              buildWhen: (previous, current) => previous.isProcessing != current.isProcessing,
              builder: (context, state) {
                return AppElevatedButton(
                  isLoading: state.isProcessing,
                  onPressed: context.read<SignInCubit>().loginUserEmail,
                  child: const Text('SignIn'),
                );
              },
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
