// Этап 1
// Необходимо написать программу, которая угадывает задуманное пользователем число от 1 до 100,
// за как можно меньшее количество шагов. Программа выдаёт предполагаемые числа,
//а пользователь отвечает, больше его число или меньше, чем число на экране.

// Допустим, пользователь загадал число 32,
//тогда вывод программы может быть похож на этот:

//  Is it 50?

// > less

//  Is it 25?

// > greater

//  Is it 40?

// > less

//  Is it 30?

// > greater

//  Is it 35?

// > less

//  Is it 32?

// > yes

//  Got it in 6 steps!

// Указания:

// Предполагайте, что пользователь всегда играет честно и не обманывает программу.
// Постарайтесь решить задачу двумя или более способами.
// Считайте число шагов в функции угадывания и возвращайте его.
// Делите код на функции.

import 'dart:io';
import 'dart:math';

void main() {
  print('задай начальное число');
  int minNumber = int.parse(stdin.readLineSync()!);
  print('Задай конечное число');
  int maxNumber = int.parse(stdin.readLineSync()!);
  print('Сколько попыток даешь компт=ьютеру?');
  int tryCount = int.parse(stdin.readLineSync()!);
  var number = createNumber(minNumber, maxNumber);
  if (number.runtimeType == int) {
    return game(number, minNumber, maxNumber, tryCount);
  } else {
    print(number.runtimeType);
    print('Выход из программы ....');
    return;
  }
}

createNumber(int minNumber, int maxNumber) {
  /*Функция для получения загаданного числа.
  Она принимает в себя диапазон из минимального и максимального чисел
  Если пользователь вводит число не из этого диапазона или число типа !int
  то возвращается null и программа прерывается
  */
  int numberCheck = 0;
  int number = 0;
  print(
      'Загадай число от $minNumber до $maxNumber, компьютер попробует его отгадать');
  do {
    number = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
    if (number <= maxNumber && number >= minNumber) {
      return number;
    } else {
      while (!(number <= maxNumber && number >= minNumber)) {
        numberCheck++;
        print(
            'Загадай число из диапазона ($minNumber - $maxNumber). У вас осталось ${(numberCheck - 7).abs()} попыток, попробуйте снова');
        number = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
        if (number <= maxNumber && number >= minNumber) {
          return number;
        } else if (numberCheck >= 6) {
          print('Количеcтво неправильно загаданных чисел превысило 7');
          return;
        }
      }
    }
  } while (true);
}

void game(int number, int minNumber, int maxNumber, int tryCount) {
  int counter = 0;
  int firstNumber = minNumber;
  int secondNumber = maxNumber;
  int randomNumber = (((secondNumber - firstNumber) / 2) + firstNumber) ~/ 1;
  String userSays = '';
  while (counter <= tryCount) {
    String thisNumber = 'Компьютер: Это число $randomNumber?';
    if (randomNumber == number) {
      counter++;
      print(thisNumber);
      userSays = stdin.readLineSync()!; //yes
      if (userSays == 'yes') {
        randomNumber = number;
        print('компьютер отгадал ваше загаданное число за $counter попыток');
        return;
      } else {
        print('Вы забыли ваше загаданное число');
        return;
      }
    } else if (randomNumber > number) {
      print(thisNumber);
      userSays = stdin.readLineSync()!; //less
      if (userSays == 'less') {
        secondNumber = randomNumber;
        randomNumber = (((secondNumber - firstNumber) / 2) + firstNumber) ~/ 1;
        counter++;
      } else {
        print('Вы забыли ваше загаданное число');
        return;
      }
    } else if (randomNumber < number) {
      print(thisNumber);
      userSays = stdin.readLineSync()!; //greater
      if (userSays == 'greater') {
        firstNumber = randomNumber;
        randomNumber = (((secondNumber - firstNumber) / 2) + firstNumber) ~/ 1;
        counter++;
      } else {
        print('Вы забыли ваше загаданное число');
        return;
      }
    }
  }
  print('Компьютер не смог отгадать за $tryCount попыток');
}
