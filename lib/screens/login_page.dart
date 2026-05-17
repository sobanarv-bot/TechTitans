import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'dashboard_page.dart';
import 'register_page.dart';

class LoginPage
    extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() =>
      _LoginPageState();
}

class _LoginPageState
    extends State<LoginPage> {
  final _formKey =
      GlobalKey<FormState>();

  final _emailController =
      TextEditingController();

  final _passwordController =
      TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;

  Future<void> login() async {
    if (!_formKey.currentState!
        .validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await AuthService().login(
        email:
            _emailController.text
                .trim(),
        password:
            _passwordController.text
                .trim(),
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (_) =>
                  const DashboardPage(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        const SnackBar(
          content: Text(
            'Invalid email or password',
          ),
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFB71C1C),

      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.all(
              20,
            ),

            child: Card(
              elevation: 6,
              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                  20,
                ),
              ),

              child: Padding(
                padding:
                    const EdgeInsets.all(
                  25,
                ),

                child: Form(
                  key: _formKey,

                  child: Column(
                    mainAxisSize:
                        MainAxisSize.min,

                    children: [
                      const Text(
                        'PENNYWISE',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight:
                              FontWeight
                                  .w900,
                          color: Color(
                            0xFFB71C1C,
                          ),
                        ),
                      ),

                      const Text(
                        'by TechTitans',
                        style: TextStyle(
                          fontStyle:
                              FontStyle
                                  .italic,
                          color:
                              Colors
                                  .grey,
                        ),
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),

                      TextFormField(
                        controller:
                            _emailController,

                        decoration:
                            const InputDecoration(
                          labelText:
                              'Email',
                          border:
                              OutlineInputBorder(),
                        ),

                        validator:
                            (value) {
                          if (value ==
                                  null ||
                              value
                                  .isEmpty) {
                            return 'Enter email';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      TextFormField(
                        controller:
                            _passwordController,

                        obscureText:
                            _obscurePassword,

                        decoration:
                            InputDecoration(
                          labelText:
                              'Password',

                          border:
                              const OutlineInputBorder(),

                          suffixIcon:
                              IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons
                                      .visibility_off
                                  : Icons
                                      .visibility,
                            ),

                            onPressed:
                                () {
                              setState(
                                () {
                                  _obscurePassword =
                                      !_obscurePassword;
                                },
                              );
                            },
                          ),
                        ),

                        validator:
                            (value) {
                          if (value ==
                                  null ||
                              value
                                  .isEmpty) {
                            return 'Enter password';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(
                        height: 25,
                      ),

                      SizedBox(
                        width:
                            double
                                .infinity,
                        height: 50,

                        child:
                            ElevatedButton(
                          onPressed:
                              _isLoading
                                  ? null
                                  : login,

                          style:
                              ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(
                              0xFFB71C1C,
                            ),
                          ),

                          child:
                              _isLoading
                                  ? const CircularProgressIndicator(
                                      color:
                                          Colors.white,
                                    )
                                  : const Text(
                                      'Sign In',
                                      style:
                                          TextStyle(
                                        color:
                                            Colors.white,
                                      ),
                                    ),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment
                                .center,

                        children: [
                          const Text(
                            "No account?",
                          ),

                          TextButton(
                            onPressed:
                                () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (_) =>
                                          const RegisterPage(),
                                ),
                              );
                            },

                            child:
                                const Text(
                              'Register',
                              style:
                                  TextStyle(
                                color:
                                    Color(
                                  0xFFB71C1C,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}