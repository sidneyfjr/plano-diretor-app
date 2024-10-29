import 'package:flutter/material.dart';
import 'package:plano_diretor_app/pages/home.dart';
import 'package:plano_diretor_app/utils/consts.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String initialUrl = AppConsts.urlDiretor + 'homeapp';

    Future.delayed(const Duration(seconds: 3)).then((_){
      Navigator.pushReplacement(
        context, MaterialPageRoute(
          builder: (context)=> const Home(initialUrl: initialUrl),
          ));
    });
    
    return 
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.purple, Colors.orange]
                  //colors: [Color.fromRGBO(0,141,169,1), Color.fromRGBO(86, 179, 80, 1), ]
                  //  colors: [Color.fromRGBO(54, 174, 106,1), Color.fromRGBO(240, 215, 64, 1), ]
                  )),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                 Image(image: AssetImage('assets/images/marca-plano-diretor-3.png')),
                  LinearProgressIndicator(color: Colors.orange,)
              ],
            ),
          ),
      
      
    );
  }
}
