MAIN_CHOICES = [
    'Осмотреть печку',
    'Осмотреть стол возле окна',
    'Осмотреть сервант',
    'Осмотреть бабушку',
    'Выйти во двор'
]

# Статусы обьектов игры
$grandma_status = ''
$window_status = 'открыто'
$inventory = []
$stove_status = []

TIME_START = Time.now
TIME_END = TIME_START + 120