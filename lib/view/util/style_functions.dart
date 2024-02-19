class StyleFunctions{
  static String amountStyle(String text) {
    String left = '', left2 = '';
    for (int i = text.length - 1; i > -1; i--) {
      left += text[i];
    }
    for (int i = 0; i < left.length; i++) {
      left2 += left[i];
      if ((i + 1) % 3 == 0) {
        left2 += ' ';
      }
    }
    text = '';
    for (int i = left2.length - 1; i > -1; i--) {
      text += left2[i];
    }
    return text;
  }
}