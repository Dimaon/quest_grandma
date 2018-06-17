# Подключаем логику игровых сцен
require_relative 'scenes/stove'
require_relative 'scenes/table'
require_relative 'scenes/servant'
require_relative 'scenes/grandma'
require_relative 'scenes/street'
require_relative 'scenes/end_game'

# Основной процесс игры, из него мы попадаем в другую игровую зону
# и возвращаемся, когда делаем выбор "осмотреться"
def main_process
  end_game if TIME_END <= Time.now

  puts_main_choices

  case $choice
  when 1
    stove_logic
  when 2
    table_logic
  when 3
    servant_logic
  when 4
    grandma_logic
  when 5
    street_logic
  else
    main_process
  end
end
