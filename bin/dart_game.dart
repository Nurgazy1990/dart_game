// Этап 2

// Протестируйте, какой из способов угадывания эффективнее.
//Сгенерируйте массив из 100 или более случайных чисел и
//по очереди прогоните его через каждый алгоритм угадывания.
//Определите среднее количество шагов, которое потребовалось каждому алгоритму на одно число.
// Лучший алгоритм тот, который угадал быстрее.

// Указания:

// Сохраняйте результаты работы алгоритмов в отдельные списки.
// Для тестирования скопируйте код алгоритмов и логику теста в отдельный файл .py.
// Вместо хода игры выводите назв только загаданное число и количество шагов, например:

// Using: Algorithm

// Got 32 in 6 steps

// Got 50 in 1 step

// Got 100 in 7 steps

// ...

// Этап 3

// Нужно добавить вариант игры наоборот: компьютер загадывает
//случайное число от 1 до 100, а пользователь должен отгадать.

// Компьютер выводит сообщения:

// greater, если число больше догадки

// less, если число меньше догадки

// yes, если пользователь угадал

// Указания:

// В начале игры пользователь попадает в меню, где может выбрать режим игры.

// Этап 4

// Нужно добавить вариант игры по очереди. Один раунд состоит из двух этапов:

// Пользователь загадывает число, а компьютер угадывает.
// Компьютер загадывает число, а пользователь отгадывает.

// Указания
// Выигрывает тот, кто угадал число за меньшее число ходов.
// Пользователь может выбрать, сколько раундов длится игра - от 1 до 10.
//По умолчанию в игре 3 раунда (пользователь ничего не ввёл и нажал enter).
// В игре выигрывает тот, кто победил в большем количестве раундов.
//Если число раундов было чётным, то может быть ничья.
// Форматируйте вывод так, чтобы было понятно, кто сейчас играет,
//выводите номер раунда и отделяйте раунды друг от друга отступами.
//Вы можете использовать строки вида "===================="
//и переносы строк, чтобы аккуратно разделить раунды.

// Этап 5 (бонусный).
// Добавьте выбор уровня сложности.

// Используйте результаты этапа 2, чтобы выбрать алгоритмы для разных уровней сложности.
// На лёгком уровне сложности компьютер использует более простой, медленный алгоритм угадывания.
// На сложном уровне сложности компьютер использует более быстрый, оптимальный алгоритм угадывания.

// Указания:

// Пользователь выбирает уровень сложности после выбора режима игры.

import 'dart:io';
import 'dart:math';

void main() {
  game();
}

void game() {
  int counter = 0;
  int randomNumber = Random().nextInt(100) + 1;
  print('Я загадал число от 1 до 100, попробуй его отгадать');
  while (true) {
    counter++;
    int number = int.tryParse(stdin.readLineSync() ?? '') ?? 0;
    if (randomNumber == number) {
      print('Вы угадали');
      break;
    } else if (counter >= 7) {
      print('Вы проиграли');
      break;
    } else if (randomNumber > number) {
      print('Число больше');
    } else if (randomNumber < number) {
      print('Число меньше');
    }
  }
}