String toNumberString(double number) {
  RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
  return number.toString().replaceAll(regex, '');
}