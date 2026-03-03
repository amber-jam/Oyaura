import 'package:flutter/material.dart';
import '../widgets/logo_widget.dart';

class LoginScreen extends StatefulWidget {
	@override
	@override
	State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
	final _formKey = GlobalKey<FormState>();
	final TextEditingController _emailController = TextEditingController();
	final TextEditingController _passwordController = TextEditingController();

	@override
	void dispose() {
		_emailController.dispose();
		_passwordController.dispose();
		super.dispose();
	}

	void _submit() {
		if (_formKey.currentState?.validate() ?? false) {
			// For now, just navigate to home and show a confirmation.
			ScaffoldMessenger.of(context).showSnackBar(
				SnackBar(content: Text('Logging in...')),
			);
			Navigator.pushNamed(context, '/home');
		}
	}

	@override
	Widget build(BuildContext context) {
		final colorScheme = Theme.of(context).colorScheme;

		return Scaffold(
			backgroundColor: Color(0xFFEFF8F7),
			body: SafeArea(
				child: SingleChildScrollView(
					padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
					child: Column(
						crossAxisAlignment: CrossAxisAlignment.stretch,
						children: [
							SizedBox(height: 8),
							LogoWidget(),
							SizedBox(height: 8),
							Text(
								'Welcome back',
								textAlign: TextAlign.center,
								style: TextStyle(
									fontSize: 22,
									fontWeight: FontWeight.w600,
									color: Colors.teal[800],
								),
							),
							SizedBox(height: 8),
							Text(
								'Sign in to continue to Oyaura Wellness',
								textAlign: TextAlign.center,
								style: TextStyle(color: Colors.grey[700]),
							),
							SizedBox(height: 24),

							Form(
								key: _formKey,
								child: Column(
									children: [
										TextFormField(
											controller: _emailController,
											keyboardType: TextInputType.emailAddress,
											decoration: InputDecoration(
												labelText: 'Email',
												prefixIcon: Icon(Icons.email_outlined),
												border: OutlineInputBorder(
													borderRadius: BorderRadius.circular(8),
												),
											),
											validator: (value) {
												if (value == null || value.trim().isEmpty) {
													return 'Please enter your email';
												}
												if (!RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$").hasMatch(value)) {
													return 'Enter a valid email address';
												}
												return null;
											},
										),
										SizedBox(height: 12),
										TextFormField(
											controller: _passwordController,
											obscureText: true,
											decoration: InputDecoration(
												labelText: 'Password',
												prefixIcon: Icon(Icons.lock_outline),
												border: OutlineInputBorder(
													borderRadius: BorderRadius.circular(8),
												),
											),
											validator: (value) {
												if (value == null || value.isEmpty) {
													return 'Please enter your password';
												}
												if (value.length < 6) {
													return 'Password must be at least 6 characters';
												}
												return null;
											},
										),
										SizedBox(height: 20),
										SizedBox(
											width: double.infinity,
											height: 50,
											child: ElevatedButton(
												onPressed: _submit,
												style: ElevatedButton.styleFrom(
													backgroundColor: colorScheme.primary,
													shape: RoundedRectangleBorder(
														borderRadius: BorderRadius.circular(8),
													),
												),
												child: Text(
													'Login',
													style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
												),
											),
										),
									],
								),
							),

							SizedBox(height: 16),
							Row(
								mainAxisAlignment: MainAxisAlignment.center,
								children: [
									Text('Don\'t have an account? '),
									TextButton(
										onPressed: () {
											Navigator.pushNamed(context, '/signup');
										},
										child: Text('Sign up', style: TextStyle(color: colorScheme.primary)),
									)
								],
							),
						],
					),
				),
			),
		);
	}
}

