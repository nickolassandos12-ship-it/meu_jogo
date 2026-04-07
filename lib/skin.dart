import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:meu_jogo/main.dart';

void main() {
  runApp(const skinjogo());
}

class skinjogo extends StatelessWidget {
  const skinjogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Meu Jogo'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🔵 FUNDO
          Positioned.fill(
            child: Image.asset(
              'assets/fundo_home.png',
              fit: BoxFit.cover,
              
              
          ),
         ),
          // 🌑 CAMADA ESCURA (overlay)
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.5), // ajuste aqui
       ),
      ),
       Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: BotaoAnimado(
                imagem: 'assets/voltar.png',
                largura: 200,
                onTap: () {
                  print('voltar clicado');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => const MyApp(),
                  ),
                 );          
                },
              ),
            ),
          ),


          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: BotaoAnimado(
                imagem: 'assets/selecionar.png',
                largura: 350,

                onTap: () {
                  print('voltar clicado');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => const MyApp(),
                  ),
                 );          
                },
              ),
            ),
          ),

       Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 25),
              child:Image.asset(
                'assets/slots_skins.png',
                width: 650,
                
              )
                )
                ),

                //peixes

        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min, 
            children: [
              InkWell(
                onTap: () {
                  print("Vermelho");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => const MyApp(),));
                },
                child: Image.asset('assets/peixe lado.png', width: 170),
              ),
              SizedBox(width: 18),
              InkWell(
                onTap: () {
                  print("Azul");
                },
                child: Image.asset('assets/peixe2 lado.png', width: 170),
              ),
              SizedBox(width: 18,),
              InkWell(
                onTap: () {
                  print("Azul");
                },
                child: Image.asset('assets/peixe3 lado.png', width: 170),
      ),
    ],
  ),
)])
);

  }
  }
      
    

class BotaoAnimado extends StatefulWidget {
  final String imagem;
  final double largura;
  final VoidCallback onTap;

  const BotaoAnimado({
    super.key,
    required this.imagem,
    required this.onTap,
    this.largura = 200,
  });

  @override
  State<BotaoAnimado> createState() => _BotaoAnimadoState();
}

class _BotaoAnimadoState extends State<BotaoAnimado> {
  double _scale = 1.0;

  void _pressionar() => setState(() => _scale = 0.9);
  void _soltar() => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => _pressionar(),
      onTapUp: (_) => _soltar(),
      onTapCancel: _soltar,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        child: Image.asset(
          widget.imagem,
          width: widget.largura,
        ),
      ),
    );
  }
}