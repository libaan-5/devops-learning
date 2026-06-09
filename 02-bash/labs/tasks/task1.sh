#!/bin/zsh

calculator() {

read -p "Enter  two numbers: " num1 num2

echo "$num1 + $num2 = $((num1 + num2))"
echo "$num1 - $num2 = $((num1 - num2))"
echo "$num1 * $num2 = $((num1 * num2))"
if [ $num2 -ne 0 ]; then
echo "$num1 / $num2 = $((num1 / num2))"
else echo "Division by zero is not allowed."
fi

}

calculator
