# encoding: utf-8

# Подключаем методы с логикой игры
require_relative "lib/game_statuses"
require_relative "lib/game_logic"
require_relative "lib/output_game_process"

# Квест В гостях у бабушки
# Игра содержит сцены жестокости и насилия, не рекомендуется запускать лицам,
# не достигшим 16-летнего возраста, психически неуравновешенным людям и беременным женщинам.

puts "Предысловие..."
buffer(0)

puts "В это лето ты решил навестить свою бабушку. У тебя всегда были напряженные отношения с бабушкой.
В этот раз ты не сдержался и замочил бабушку. Теперь надо замести следы и спрятать тело бабушки, пока не вернулся дедушка..."
buffer(0)

# Основной процесс игры со всеми сценами
main_process