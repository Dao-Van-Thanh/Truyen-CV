class RegexConstants {
  static final phone = RegExp(
    r'^(?:\+84|0|84)(?:296|216|211|270|207|294|273|234|237|208|227|276|212|299|233|203|255|235|232|257|210|259|238|229|228|272|214|205|263|213|260|297|258|221|218|293|225|220|239|226|219|269|277|251|215|261|262|236|206|292|290|252|271|274|256|275|222|291|204|209|254|296)\d{7}$|^(?:\+84|0|84)(?:24|28)\d{8}$|^(?:\+84|0|84)(?:86|96|97|98|32|33|34|35|36|37|38|39|89|90|93|70|79|77|76|78|88|91|94|83|84|85|81|82|92|56|58)\d{7}$',
  );
  static final specialCharacters = RegExp(r'[!@#$%^&*()_+{}\[\]:;<>,.?/\|]');
  static final email = RegExp(
    r'^(?=.{4,64}@)[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static final password = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_:])[a-zA-Z\d!@#$%^&*()_:]{8,}$',
  );
  static final fullName = RegExp(r'^[a-zA-Z0-9 ]*$');

  static final textNormal = RegExp(r'[a-z]');
  static final textUppercase = RegExp(r'[A-Z]');
  static final eightCharacters = RegExp(r'^.{8,}$');
  static final hasNumber = RegExp(r'\d');
  static final number = RegExp(r'^\d+$');
  static final validCharacters = RegExp(r'^[a-zA-Z0-9!@#$%^&*()_]');
  static final website = RegExp(
    r'[(http(s)?):\/\/(www\.)?a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)',
  );
  static final noSpacesOrSpecialChars = RegExp(r'^[a-zA-Z0-9]*$');

  static final bankInput = RegExp(r'^[a-zA-Z0-9 ]*$');

  RegexConstants._();
}
