class StyleFunctions {
  static String amountStyle(String amount) {
    String left = '', left2 = '';
    for (int i = amount.length - 1; i > -1; i--) {
      left += amount[i];
    }
    for (int i = 0; i < left.length; i++) {
      left2 += left[i];
      if ((i + 1) % 3 == 0) {
        left2 += ' ';
      }
    }
    amount = '';
    for (int i = left2.length - 1; i > -1; i--) {
      amount += left2[i];
    }
    return amount;
  }
}
