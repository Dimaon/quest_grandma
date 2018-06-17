def stove_logic
  puts 'Обыкновенная русская печь'
  buffer
  # Обнуляем варианты перед каждым входом в метод
  variants = []
  # Проверяем горит ли печка
  if $stove_status.include?('горит')
    variants << 'Запихать бабушку в печку' unless $stove_status.include? 'бабушка в печке'
    variants << 'Потушить печку'
    variants << 'Осмотреться'
    choice = puts_variants(variants)
    if choice == 2 || choice == 1 && $stove_status.include?('бабушка в печке')
      choke_the_stove
      stove_logic if get_answer?
    elsif choice == 1 && $grandma_status == 'разрублена'
      puts 'Ты запихал бабушку в печку'
      puts 'Из печки начинает очень сильно пахнуть!'
      $stove_status << 'бабушка в печке'
      stove_logic if get_answer?
    elsif choice == 1 && $grandma_status != 'разрублена'
      puts 'Бабушка здоровенная и в печь не помещается.'
      stove_logic if get_answer?
    elsif choice == variants.size
      main_process
    end

  else
    # Проверяем есть ли спички
    variants << 'Запихать бабушку в печку' unless $stove_status.include? 'бабушка в печке'
    variants << 'Разжечь печку' if $inventory.include?('спички')
    variants << 'Осмотреться'
    choice = puts_variants(variants)

    if choice == 1 && $grandma_status != 'разрублена' && !$stove_status.include?('бабушка в печке')
      puts 'Бабушка здоровенная и в печь не помещается.'
      stove_logic if get_answer?

    elsif choice == 1 && $grandma_status == 'разрублена' && !$stove_status.include?('бабушка в печке')
      puts 'Ты запихал бабушку в печку'
      $stove_status << 'бабушка в печке'
      stove_logic if get_answer?

    elsif choice == 1 && $stove_status.include?('бабушка в печке')
      kindle_the_stove_with_grandma
      stove_logic if get_answer?

    elsif choice == 2 && !$stove_status.include?('бабушка в печке') && $inventory.include?('спички')
      stove_actions
      stove_logic if get_answer?

    elsif choice == 2 || !$inventory.include?('спички')
      main_process

    elsif choice == variants.size
      main_process
    end

    if choice == 1 && $inventory.include?('спички')
      stove_actions
    end
  end
end

# Разжигаем или тушим печку
def stove_actions
  #puts 'stove_action'
  # Спичка тухнет, если окно закрыто
  if $window_status == "открыто"
    loop do
      puts "Спичка потухла (:"
      buffer
      variants = ["Зажечь спичку", "Осмотреться"]
      choice = puts_variants(variants)
      break unless $window_status == "открыто" && choice == 1
    end
    stove_logic
    # Печка разгорается, если окно закрыто и она ещё не горит
  else
    # Если в печке бабушка
    if $stove_status.include?('бабушка в печке')
      kindle_the_stove_with_grandma
      buffer(1)
      stove_logic if get_answer?("1. Осмотреться")
      # Если в печке нет бабушки
    else
      kindle_the_stove
      buffer(1)
      stove_logic if get_answer?("1. Осмотреть печку")
    end
  end
end

# Разжечь печку
def kindle_the_stove
  puts "Вы разожгли печку!"
  $stove_status << "горит"
end

# Разжечь печку с бабушкой
def kindle_the_stove_with_grandma
  puts "Печь горит и из нее начинает очень сильно пахнуть!"
  $stove_status << "горит"
end

# Потушить печку
def choke_the_stove
  puts "Вы потушили печку"
  $stove_status.delete_if{ |key| key == "горит" }
end