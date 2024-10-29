class AppConsts {
  static const imgHome = 'assets/images/home.jpg';
  static const imgNossaCidade = 'assets/images/nossa-cidade.jpg';
  static const imgOQueE = 'assets/images/o-que-e.png';
  static const imgGrandesEixos = 'assets/images/grandes-eixos.png';
  static const imgComoParticipar = 'assets/images/como-participar.jpg';
  static const imgAgenda = 'assets/images/agenda.jpg';
  static const imgDocumentos = 'assets/images/documentos.jpg';
  static const imgPalavrasChave = 'assets/images/palavras-chave.jpg';
  static const imgLogo = 'assets/images/marca-plano-diretor-3.png';

  static const urlParticipa =
  static const urlDiretor =
  static const rhssoUrl =
  static const rhssoRealm =
  static const rhssoClientId =
  static const redirectToCheck =


  static String fnRedirectFortalezaDigital(String url) {
    return rhssoUrl +
        'realms/' +
        rhssoRealm +
        '/protocol/openid-connect/auth?response_type=code&client_id=' +
        rhssoClientId +
        '&redirect_uri=' +
        url +
        'login-rhsso'
            '&redirectToCheckCpf=' +
        redirectToCheck;
  }
}
