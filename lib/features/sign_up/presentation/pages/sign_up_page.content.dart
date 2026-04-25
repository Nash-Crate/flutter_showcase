part of 'sign_up_page.dart';

/// SignUp page content section
class SignUpPageContent extends StatefulWidget {
  /// constructor
  const SignUpPageContent({super.key});

  @override
  State<SignUpPageContent> createState() => _SignUpPageContentState();
}

class _SignUpPageContentState extends State<SignUpPageContent> {
  late final TextEditingController _nameTec;
  late final TextEditingController _emailTec;
  late final TextEditingController _passwordTec;
  late final TextEditingController _confirmPasswordTec;
  late final FocusNode _nameFocusNode;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late final FocusNode _confirmPasswordFocusNode;

  @override
  void initState() {
    super.initState();
    _nameTec = TextEditingController();
    _emailTec = TextEditingController();
    _passwordTec = TextEditingController();
    _confirmPasswordTec = TextEditingController();
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _nameTec.dispose();
    _emailTec.dispose();
    _passwordTec.dispose();
    _confirmPasswordTec.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
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
              label: 'Name',
              hint: 'John Doe',
              controller: _nameTec,
              focusNode: _nameFocusNode,
              onChanged: context.read<SignUpCubit>().onSetName,
              onSubmitted: (_) => _emailFocusNode.requestFocus(),
            ),

            SizedBox(height: 10.h),

            AppTextField(
              label: 'Email',
              hint: 'john@g.co',
              controller: _emailTec,
              focusNode: _emailFocusNode,
              onChanged: context.read<SignUpCubit>().onSetEmail,
              onSubmitted: (_) => _passwordFocusNode.requestFocus(),
            ),

            SizedBox(height: 10.h),

            AppTextField(
              label: 'Password',
              hint: '********',
              controller: _passwordTec,
              focusNode: _passwordFocusNode,
              obscureText: true,
              onChanged: context.read<SignUpCubit>().onSetPassword,
              onSubmitted: (_) => _confirmPasswordFocusNode.requestFocus(),
            ),

            SizedBox(height: 10.h),

            AppTextField(
              label: 'Confirm Password',
              hint: '********',
              controller: _confirmPasswordTec,
              focusNode: _confirmPasswordFocusNode,
              obscureText: true,
              onChanged: context.read<SignUpCubit>().onSetConfirmPassword,
              // clear focus
              onSubmitted: (_) => _confirmPasswordFocusNode.unfocus(),
            ),

            SizedBox(height: 30.h),

            BlocBuilder<SignUpCubit, SignUpState>(
              buildWhen: (previous, current) => previous.isProcessing != current.isProcessing,
              builder: (context, state) {
                return AppElevatedButton(
                  isLoading: state.isProcessing,
                  onPressed: context.read<SignUpCubit>().signUpUserEmail,
                  child: const Text('Sign Up'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
