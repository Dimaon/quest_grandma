# Вывод в консоль основных вариантов игры
def puts_main_choices
  puts "Ты в обычном деревенском домике. Прям у входа стоит печка. " \
        "Возле окна стоит стол. По правую руку возле стола стоит сервант."
  puts "Рядом валяется окрававленная бабушка."
  buffer

  MAIN_CHOICES.each_with_index do |choice, index|
    puts "#{index + 1} #{choice} \n"
  end

  puts "Выбрать вариант от 1 до #{MAIN_CHOICES.size}"
  $choice = STDIN.gets.to_i
end

# Вывод вариантов из массива вопросов
def puts_variants(variants)
  variants.each_with_index do |variant, index|
    puts "#{index + 1} - #{variant}"
  end

  loop do
    puts "Ваше действие: "
    choice = STDIN.gets.to_i
    return choice if choice.between?(1, variants.size)
  end
end
# Вывод пустой строки и ожидания
def buffer(seconds = 1)
  puts
  sleep seconds
end

def get_answer?(action = "1. Осмотреться")
  buffer
  puts "Ваши действия: "
  puts action
  loop do
    puts "Ваш ответ:"
    i = gets.to_i
    return true if i == 1
  end
end