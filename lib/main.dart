import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Habito {
  String nome;
  bool feito;

  Habito({required this.nome, required this.feito});
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
  final List<Habito> habitos = [
    Habito(nome: 'Beber água', feito: false),
    Habito(nome: 'Ler', feito: false),
    Habito(nome: 'Exercitar', feito: false),
    Habito(nome: 'Estudar Flutter', feito: false),
  ];
  @override
  Widget build(BuildContext context) {
    final int totalHabitos = habitos.length;
    final int habitosFeitos = habitos.where((habito) => habito.feito).length;
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
            SizedBox(height: 8),
            Text(
              '$habitosFeitos de $totalHabitos hábitos concluídos',
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
                      value: habito.feito,
                      onChanged: (valor) {
                        setState(() {
                          habito.feito = valor ?? false;
                        });
                      },
                    ),
                    SizedBox(width: 12),
                    Text(habito.nome),
                    Spacer(),
                    Text(habito.feito ? '1/1' : '0/1'),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //abrindo a segunda tela
          //context: É o "endereço" do seu widget na árvore de widgets.
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddHabitPage()),
          );
        },
        tooltip: 'Adicionar hábito',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddHabitPage extends StatefulWidget {
  const AddHabitPage({super.key});

  // cria o State
  @override
  State<AddHabitPage> createState() => _AddHabitPageState();
}

class _AddHabitPageState extends State<AddHabitPage> {
  // controller: controla o texto digitado
  final TextEditingController nomeController = TextEditingController();

  // cria dispose: libera memória
  @override
  void dispose() {
    nomeController.dispose();
    super.dispose();
  }

  // cria build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Hábito'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(
                labelText: 'Nome do hábito',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Acesse o texto usando o controlador
                print('Enviar: ${nomeController.text}');

                Navigator.pop(context);
              },
              child: Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
