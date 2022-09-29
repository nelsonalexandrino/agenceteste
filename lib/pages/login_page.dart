import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/login_provider.dart';
import '../pages/products_page.dart';
import '../widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/login';
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/agence.png', height: 45),
              Text(
                'Teste',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: userController,
                hintText: 'Usuario',
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                controller: passwordController,
                hintText: 'Senha',
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(foregroundColor: Colors.grey),
                  child: const Text('Esqueci a senha'),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 0),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, ProductsPage.routeName);
                  },
                  child: const Text('Entrar'),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Ou',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 0),
                      onPressed: () {
                        context
                            .read<LoginProvider>()
                            .signWithGoogle()
                            .then((value) {
                          debugPrint('value: $value');
                          if (value) {
                            Navigator.pushReplacementNamed(
                                context, ProductsPage.routeName);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Não fez o login')));
                          }
                        });
                      },
                      child: const Text('Google'),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 0),
                      onPressed: () {
                        context
                            .read<LoginProvider>()
                            .signWithFacebook()
                            .then((value) {
                          debugPrint('value: $value');
                          if (value) {
                            Navigator.pushReplacementNamed(
                                context, ProductsPage.routeName);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Não fez o login'),
                              ),
                            );
                          }
                        });
                      },
                      child: const Text('Facebook'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
