import 'dart:async';
import 'package:flutter/material.dart';
import 'package:plano_diretor_app/utils/consts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:plano_diretor_app/components/webview.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.initialUrl}) : super(key: key);
  final String initialUrl;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String currentUrl = '';
  String pageName = '';
  String session = '';
  String user = '';
  int error = 0;
  final controller = Completer<WebViewController>();
  final itemsGrid = [
    {
      'image': AppConsts.imgHome,
      'label': 'Home',
      'page': 'home',
    },
    {
      'image': AppConsts.imgNossaCidade,
      'label': 'Nossa Cidade',
      'page': 'nossa-cidade',
    },
    {
      'image': AppConsts.imgOQueE,
      'label': 'O Que é',
      'page': 'o-que-e',
    },
    {
      'image': AppConsts.imgGrandesEixos,
      'label': 'Grandes Eixos',
      'page': 'grandes-eixos',
    },
    {
      'image': AppConsts.imgComoParticipar,
      'label': 'Como Participar',
      'page': 'como-participar',
    },
    {
      'image': AppConsts.imgAgenda,
      'label': 'Agenda',
      'page': 'agenda',
    },
    {
      'image': AppConsts.imgDocumentos,
      'label': 'Documentos',
      'page': 'documentos',
    },
    {
      'image': AppConsts.imgPalavrasChave,
      'label': 'Palavras Chave',
      'page': 'palavras-chave',
    },
    {
      'image': AppConsts.imgComoParticipar,
      'label': 'Participação',
      'page': 'login-do-cidadao',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: currentUrl.contains('homeapp') ? null : _appBar(context),
      body: error != 0
          ? const Center(child: Text('Erro ao carregar!'))
          : Stack(
              children: [
                WebViewPage(
                  controller: controller,
                  currentUrl: _currentUrl,
                  loadError: _loadError,
                  changeStyle: _changeStyle,
                  getUser: _getUser,
                  initialUrl: widget.initialUrl,
                ),
                currentUrl.contains('homeapp')
                    ? Stack(
                        children: [
                          Container(
                              width: double.infinity,
                              height: 160.0,
                              decoration:
                                  BoxDecoration(gradient: _linearGradient())),
                          Container(
                            height: 200.0,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                 topLeft :  Radius.circular(12.0),
                                 topRight: Radius.circular(12.0),
                                  bottomLeft: Radius.circular(56.0),
                                      bottomRight:  Radius.circular(56.0),

                                    ),
                                gradient: _linearGradient(),
                              ),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 36.0),
                                  padding: const EdgeInsets.only(top: 48.0),
                              child: const Image(
                                  image: AssetImage(AppConsts.imgLogo))),
                          Container(
                            margin: const EdgeInsets.only(top: 210.0),
                            child: GridView.count(
                              padding: const EdgeInsets.all(42.0),
                              mainAxisSpacing: 28.0,
                              crossAxisSpacing: 24.0,
                              crossAxisCount: 2,
                              children: List.generate(
                                  user != 'nobody'
                                      ? itemsGrid.length
                                      : itemsGrid.length - 1, (index) {
                                return _btnGrid(context,
                                    imgPath: itemsGrid[index]['image']!,
                                    label: itemsGrid[index]['label']!,
                                    page: itemsGrid[index]['page']!);
                              }),
                            ),
                          ),
                        ],
                      )
                    : const Center(),
              ],
            ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      flexibleSpace:
          Container(decoration: BoxDecoration(gradient: _linearGradient())),
      automaticallyImplyLeading: false,
      leading: MaterialButton(
        child: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => _goHome(page: 'homeapp'),
      ),
      title:
          Text(pageName.toUpperCase(), style: const TextStyle(fontSize: 16.0)),
      centerTitle: true,
      actions: [
        user == 'nobody'
            ? Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.article_outlined)),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Home(
                                    initialUrl:
                                        AppConsts.fnRedirectFortalezaDigital(
                                            AppConsts.urlDiretor))));
                      },
                      icon: const Icon(Icons.login_rounded)),
                ],
              )
            : IconButton(
                onPressed: () {}, icon: const Icon(Icons.person_rounded))
      ],
    );
  }

  _goHome({required String page}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Home(
                initialUrl: session.length.toString() != '0'
                    ? AppConsts.urlDiretor + page + '?session=' + session
                    : AppConsts.urlDiretor + page)));
  }

  LinearGradient _linearGradient() {
    return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.purple, Colors.orange]);
  }

  Widget _btnGrid(BuildContext context,
      {required String imgPath, required String label, required String page}) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          gradient: _linearGradient(),
          borderRadius: const BorderRadius.all(Radius.circular(12.0))),
      child: OutlinedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.all(8.0))
        ),
        onPressed: () => _goHome(page: page),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 70.0,
              height: 70.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white),
                image: DecorationImage(
                  image: AssetImage(imgPath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(label,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  _loadError(int codeError) {
    setState(() {
      error = codeError;
    });
    print('error $error');
  }

  _changeStyle(WebViewController webViewController) {
    webViewController.runJavascript(
        "document.getElementById('t_Body_title').value != '' ? document.getElementById('t_Body_title').remove() : '';");
    webViewController.runJavascript(
        "document.getElementById('t_Header').value != '' ? document.getElementById('t_Header').remove() : '';");
  }

  _getUser(WebViewController webViewController) async {
    user = await webViewController.runJavascriptReturningResult(
        "document.getElementById('P0_USER').value;");
    setState(() {
      user = user.replaceAll(RegExp(r'"'), '');
    });
  }

  _currentUrl(String currentUrl) {
    setState(() {
      this.currentUrl = currentUrl;
      print('currentUrl: $currentUrl');

      pageName = currentUrl.substring(AppConsts.urlDiretor.length);
      print('pageName: ' + pageName);

      session = currentUrl.contains('session')
          ? currentUrl
              .substring(currentUrl.indexOf('session') + 'session='.length)
          : '';
      print('session: $session');
      
    });
  }
}
