import 'dart:math';

import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IMC',
      home: MyWidged(),
    )
  );
}

class MyWidged extends StatefulWidget {
  const MyWidged({ Key? key }) : super(key: key);

  @override
  State<MyWidged> createState() => _MyWidged();
}

class _MyWidged extends State<MyWidged> {

  //Atributos
  var txtPeso = TextEditingController();
  var txtAltura = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora IMC'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,

      ),
      backgroundColor: Colors.grey.shade900,
      
      //Corpo
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              children:[
                Icon(
                  Icons.calculate_outlined,
                  size: 120,
                  color: Colors.blue.shade900,
                ),
          
                campoTexto('Peso',txtPeso),
                campoTexto('Altura', txtAltura),
                botao('Calcular'),
              ]
            ),
          ),
        ),
      )
    );

  }
  
  //Campo de texto
  campoTexto(rotulo, variavel){
    return Container(
      child: TextFormField(
        controller: variavel,
        style: TextStyle(
          fontSize: 32,
          color: Colors.white
        ),
        decoration: InputDecoration(
          labelText: rotulo,
          labelStyle: TextStyle(
            fontSize: 24,
            color: Colors.white
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20)
            
          )
        ),

        validator: (value){
          value = value!.replaceFirst(",", ".");
          if(double.tryParse(value)==null){
            return 'Entre com um valor numérico';
          }else{
            return null;
          }
        },
        
      ),
    );
  }
  //Botao
  botao(rotulo){
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(400,50),
        primary: Colors.blue.shade900,
      ),
      onPressed: (){
        //Validar os campos
        if(formKey.currentState!.validate()){
          double p = double.parse(txtPeso.text.replaceFirst(',', '.'));
          double a = double.parse(txtAltura.text.replaceFirst(',', '.'));
          double imc = p/ pow(a,2);
          caixaDialogo('O valor do IMC é ${imc.toStringAsFixed(2)}');
          print('frango');
        }
      },
      child: Text(
        rotulo,
        style: TextStyle(
          fontSize: 26,

        ),
      ),
    );
  }

  //Caixa de diálogo
  caixaDialogo(msg) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Calculadora'),
          content: Text(
            msg,
            style: TextStyle(fontSize: 32),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  txtPeso.clear();
                  txtAltura.clear();
                });
              },
              child: Text('fechar'),
            )
          ],
        );
      },
    );
  }

}