import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rastreador de Hábitos',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: const MyHomePage(title: 'Meus Hábitos'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, dynamic>> habitos = [
    {'nome': 'Beber água', 'feito': false},
    {'nome': 'Ler', 'feito': false},
    {'nome': 'Exercitar', 'feito': false},
    {'nome': 'Estudar Flutter', 'feito': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hoje', style: Theme.of(context).textTheme.headlineMedium),
            SizedBox(height: 8),
            Text(
              'Acompanhe seus hábitos diários',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 24),
            ...habitos.map((habito) {
              return Container(
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Checkbox(
                      value: habito['feito'],
                      onChanged: (valor) {
                        setState(() {
                          habito['feito'] = valor ?? false;
                        });
                      },
                    ),
                    SizedBox(width: 12),
                    Text(habito['nome']),
                    Spacer(),
                    Text(habito['feito'] ? '1/1' : '0/1'),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Adicionar novo hábito');
        },
        tooltip: 'Adicionar hábito',
        child: const Icon(Icons.add),
      ),
    );
  }
}
