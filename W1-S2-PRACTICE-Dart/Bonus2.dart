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

void main() {
  print(isBalanced('{what is (42)}?')); 
  print(isBalanced('[text}'));
  print(isBalanced('{[[(a)b]c]d}')); 
}
