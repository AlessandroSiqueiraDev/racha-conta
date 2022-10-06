import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //variáveis
  double taxa = 0;
  var totalconta, totalpagar, comissao;
  var qtdpessoas;

  //criando os textcontrollers
  TextEditingController txttotal = TextEditingController();
  TextEditingController txtqtd = TextEditingController();

  //Criando a chave do form
  final _formkey = GlobalKey<FormState>();

  //Método que calcula a conta

  void calcularconta() {
    // 1- Receber os valores

    setState(() {
      totalconta = double.parse(txttotal.text);
      qtdpessoas = int.parse(txtqtd.text);

      // 2 Calcular a comissão

      comissao = (taxa * totalconta) / 100;

      // calcular o total

      totalpagar = (totalconta + comissao) / qtdpessoas;

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("A CONTA É: "),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      "assets/smile.png",
                      width: 100,
                    ),
                    SizedBox(height: 10),
                    Text(
                      " O TOTAL DA CONTA É: R\$ $totalconta",
                      style: TextStyle(fontSize: 13),
                    ),
                    SizedBox(height: 10),
                    Text(
                      " O TOTAL DA COMISSÃO É: R\$ $comissao",
                      style: TextStyle(fontSize: 13),
                    ),
                    SizedBox(height: 10),
                    Text(
                      " O VALOR POR PESSOA É: R\$ $totalpagar",
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    child: Text("OK"),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Color.fromARGB(255, 240, 75, 9),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Racha Conta"),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 240, 75, 9),
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formkey,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Image.asset(
                    "assets/icon_money.png",
                    width: 100,
                  ),
                ),
                TextFormField(
                    controller: txttotal,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(labelText: "Total da conta"),
                    style: TextStyle(fontSize: 19),
                    validator: ((valor) {
                      if (valor!.isEmpty)
                        return "Campo Obrigatório";
                      else
                        return null;
                    })),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Taxa de Seviço % :",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Slider(
                        value: taxa,
                        min: 0,
                        max: 10,
                        label: "$taxa%",
                        divisions: 10,
                        activeColor: Color.fromARGB(255, 240, 75, 9),
                        inactiveColor: Colors.grey,
                        onChanged: (double valor) {
                          setState(() {
                            taxa = valor;
                          });
                        })
                  ],
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: txtqtd,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(labelText: "Qtd de Pessoas"),
                  style: TextStyle(fontSize: 18),
                  validator: (valor) {
                    if (valor!.isEmpty)
                      return "Campo Obrigatório";
                    else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  child: Text(
                    "Calcular",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 240, 75, 9),
                      onPrimary: Colors.white),
                  onPressed: (() {
                    if (_formkey.currentState!.validate()) {
                      calcularconta();
                    }
                  }),
                )
              ]),
            ),
          )),
        ));
  }
}
