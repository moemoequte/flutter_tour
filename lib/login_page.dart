import 'package:flutter/material.dart';
import 'package:flutter_tour/app_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          return Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(children: [
                const TextField(),
                const TextField(),
                TextButton(
                    onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AppPage(),
                          ),
                        ),
                    child: const Text('login'))
              ]),
            ),
          );
        },
      ),
    );
  }
}
