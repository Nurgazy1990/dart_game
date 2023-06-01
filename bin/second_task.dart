import 'dart:io';
import 'dart:math';

void main() {
  print('Режим совместной игры с ботом');
  print('---Нажми "start" чтобы начать игру---');
  List rangeNumbers = [];
  String startGame = stdin.readLineSync()!;
  if (startGame == 'start') {
    print('-----Давай настроим игру...');
    print('-----Настроим диапазон чисел...');
    rangeNumbers = numberRange();
    if (rangeNumbers.length == 2) {
      print(
          '***Выбран диапазон от ${rangeNumbers.first} до ${rangeNumbers.last}***');
    } else {
      return;
    }
  } else {
    print('Выход из игры ....');
    return;
  }
  twoGames(rangeNumbers.first, rangeNumbers.last);
}

void twoGames(int minNumber, int maxNumber) {
  int botMinNumber = minNumber;
  int botMaxNumber = maxNumber;
  String userSay;
  int botGuessNumber = 0;
  int userGuessNumber = 0;
  int botNumber = Random().nextInt(maxNumber) + minNumber;
  int userGuessCounter;
  int botGuessCounter;
  print(
      'Загадай число от $minNumber до $maxNumber, бот попробует его отгадать');
  var userNumber = createNumber(minNumber, maxNumber);
  if (userNumber >= minNumber && userNumber <= maxNumber) {
    print('Ты загадал число $userNumber');
  } else {
    print('Ты загадал неправильное число');
  }
  print('Очередь бота');
  print('Бот загадал число');
  print('Время отгадывать!');
  while (userNumber != botGuessNumber || botNumber != userGuessNumber) {
    botGuessNumber = botGuessNumberFunc(botMinNumber, botMaxNumber);
    print('Бот думает что ты загадал число $botGuessNumber');
    if (botGuessNumber == userNumber) {
      print('Бот выиграл!');
      break;
    } else if (botGuessNumber > userNumber) {
      userSay = stdin.readLineSync() ?? ''; //less
      if (userSay == 'less') {
        botMaxNumber = botGuessNumber;
      } else {
        print('Вы забыли ваше число');
        print('Выход из программы');
        return;
      }
    } else if (botGuessNumber < userNumber) {
      userSay = stdin.readLineSync() ?? ''; //greater
      if (userSay == 'greater') {
        botMinNumber = botGuessNumber;
      } else {
        print('Вы забыли ваше число');
        print('Выход из программы');
        return;
      }
    }
    print('Отгадай загаданное число бота от $minNumber до $maxNumber:');
    userGuessNumber = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
    if (userGuessNumber == botNumber) {
      print('Вы угадали');
      return;
    } else if (userGuessNumber < botNumber) {
      print('Число больше');
    } else if (userGuessNumber > botNumber) {
      print('Число меньше');
    }
  }
}

List numberRange() {
  List<int> range = [];
  print('Задай начальное число диапазона');
  range.add(int.tryParse(stdin.readLineSync() ?? '') ?? 0);
  print('Задай конечное число диапазона');
  range.add(int.tryParse(stdin.readLineSync() ?? '') ?? 0);
  if (range.first >= range.last) {
    print('Неправильный диапазон');
    return [0];
  } else if ((range.last - range.first) <= 5) {
    print('Слишком маленький диапазон');
    return [0];
  }
  return range;
}

int botGuessNumberFunc(int minNumber, int maxNumber) {
  int randomNumber = (((maxNumber - minNumber) / 2) + minNumber) ~/ 1;
  return randomNumber;
}

createNumber(int minNumber, int maxNumber) {
  /*Функция для получения загаданного числа.
  Она принимает в себя диапазон из минимального и максимального чисел
  Если пользователь вводит число не из этого диапазона или число типа !int
  то возвращается null и программа прерывается
  */
  int numberCheck = 0;
  int number = 0;
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

void botGame(int number, int minNumber, int maxNumber, int tryCount) {
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

// void userGuessNumber(
//   counter,
//   number,
// ) {
//   while (true) {
//     counter++;
//     if (randomNumber == number) {
//       print('Вы угадали');
//       break;
//     } else if (counter >= 7) {
//       print('Вы проиграли');
//       break;
//     } else if (randomNumber > number) {
//       print('Число больше');
//     } else if (randomNumber < number) {
//       print('Число меньше');
//     }
//   }
// }
