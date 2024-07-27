class PaymentSuggestionRule {
  const PaymentSuggestionRule(
    this.lowerLimit,
    this.upperLimit,
    this.suggestions,
  );
  final int lowerLimit;
  final int upperLimit;
  final List<int> suggestions;
}

class PaymentSuggestionGenerator {
  final List<PaymentSuggestionRule> rules = [
    const PaymentSuggestionRule(0, 1000, [1000, 5000, 10000, 20000]),
    const PaymentSuggestionRule(1000, 5000, [5000, 10000, 20000, 50000]),
    const PaymentSuggestionRule(5000, 10000, [10000, 20000, 50000, 100000]),
    const PaymentSuggestionRule(10000, 20000, [20000, 50000, 100000, 105000]),
    const PaymentSuggestionRule(20000, 50000, [50000, 100000, 105000, 110000]),
    const PaymentSuggestionRule(
      50000,
      100000,
      [100000, 105000, 110000, 115000],
    ),
    const PaymentSuggestionRule(
      100000,
      99999999,
      [100000, 105000, 110000, 115000],
    ),
  ];

  List<int> generateSuggestions(int billAmount) {
    List<int> number = [];
    const addedNumber = 5000;
    int divide = 1000;
    if(billAmount < 10000){
      divide = 100;
    }else{
      divide=1000;
    }

    final rounder =
        ((billAmount / divide).ceilToDouble() * divide).ceilToDouble();

    for (final rule in rules) {
      if (billAmount >= rule.lowerLimit && billAmount < rule.upperLimit) {
        var suggestions = rule.suggestions
            .map(
              (suggestion) => suggestion,
            )
            .toList();

        if (billAmount > 100000) {
          int additionalAmount = 0;
          for (var i = 0; i < suggestions.length; i++) {
            if (i == 0) {
              int roundedNumber = rounder.toInt();
              suggestions[0] = roundedNumber;
            } else {
              suggestions[i] = (rounder + additionalAmount).toInt();
            }

            additionalAmount += addedNumber;
          }
          suggestions = suggestions.map(
            (suggestion) {
              int indexWhere = suggestions.indexWhere(
                (element) => element == suggestion,
              );
              int remainder = suggestion % addedNumber;
              if (indexWhere == 0) {
                return suggestion;
              }
              return suggestion +
                  (remainder == 0
                      ? 0
                      : (addedNumber - addedNumber) - remainder);
            },
          ).toList();
        } else if (billAmount < 100000) {
          for (var i = 0; i < suggestions.length; i++) {
            if (i == 0) {
              int roundedNumber = rounder.toInt();
              suggestions[0] = roundedNumber == billAmount ? roundedNumber+ (divide) : roundedNumber;
            } else {
              suggestions[i] = rule.suggestions[(i> 0) ? i-1 : i];
            }
          }
        }

        number = suggestions;
      }
    }

    return number;
  }
}
