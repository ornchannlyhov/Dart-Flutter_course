bool isBalanced(String str) {
  List<String> stack = [];
  Map<String, String> matchingBrackets = {
    ')': '(',
    '}': '{',
    ']': '[',
  };

  for (var char in str.split('')) {
    if (matchingBrackets.containsValue(char)) {
      stack.add(char);
    } else if (matchingBrackets.containsKey(char)) {
      if (stack.isEmpty || stack.removeLast() != matchingBrackets[char]) {
        return false;
      }
    }
  }

  return stack.isEmpty;
}

String checkBrackets(String str) {
  return isBalanced(str) ? 'match' : 'not match';
}

void main() {
  print(checkBrackets('{what is (42)}?'));
  print(checkBrackets('{[}'));
  print(checkBrackets('{[[(a)b]c]d}'));
}
