import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GoldScreen extends StatelessWidget {
  const GoldScreen({super.key});

  @override
  Widget build(BuildContext context) {
  Stream<double> getGoldPriceStream() async* {
    while (true) {
      // Simuliere einen sich ändernden Goldpreis
      await Future.delayed(const Duration(seconds: 1));
      yield 69.22 + (1.0 - 2.0 * (DateTime.now().second % 2));
    }
  }

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              Text('Live Kurs:',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 20),
              StreamBuilder<double>(
                stream: getGoldPriceStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      NumberFormat.currency(
                        locale: 'de_DE',
                        symbol: '€',
                      ).format(snapshot.data),
                      style: Theme.of(context).textTheme.headlineLarge,
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              ),// StreamBuilder ist ein Widget, das sich automatisch aktualisiert.
            ],
          ),
        ),
      ),
    );
  }

  Row _buildHeader(BuildContext context) {
    return Row(
      children: [
        const Image(
          image: AssetImage('assets/bars.png'),
          width: 100,
        ),
        Text('Gold', style: Theme.of(context).textTheme.headlineLarge),
      ],
    );
  }
}
