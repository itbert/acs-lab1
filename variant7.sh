#!/usr/bin/env bash
set -euo pipefail
# Запускать из пустого каталога lab0; Git-коммиты выполняются после каждого этапа.
case "${1:-}" in
1)
mkdir -p claude_monet/pastry_station/oven claude_monet/pastry_station/cold_room claude_monet/hall claude_monet/office louis_room empty_boxes
cat > claude_monet/pastry_station/oven/croissant_plan <<'DATA'
Луи замешивает тесто ранним утром
Круассаны должны быть готовы к открытию
В первую партию добавить миндальный крем
Баринов проверит выпечку лично
DATA
cat > claude_monet/pastry_station/oven/millefeuille_plan <<'DATA'
Коржи для мильфея выпекаются отдельно
Луи готовит ванильный крем
Десерт украсят свежими ягодами
Первую порцию подадут Виктору Петровичу
DATA
cat > claude_monet/pastry_station/cold_room/cream_note <<'DATA'
Сливочный крем хранится в холодной комнате
Шоколадный крем нужен для банкета
Луи подписывает каждую ёмкость
Остатки проверяет Лёва после смены
DATA
cat > claude_monet/pastry_station/dessert_menu <<'DATA'
Классический круассан с миндалём
Мильфей с ванильным кремом
Шоколадный торт от Луи
Фирменный десерт Claude Monet
DATA
cat > claude_monet/hall/banquet_orders <<'DATA'
Для банкета приготовить двадцать круассанов
На главный стол подать шоколадный десерт
Гости ждут торт к девятнадцати часам
Вика просит проверить каждый заказ
DATA
cat > claude_monet/hall/guest_wishes <<'DATA'
Постоянный гость просит десерт без орехов
За седьмым столиком ждут мильфей
Детям приготовить небольшие круассаны
Один гость хочет познакомиться с Луи
DATA
cat > claude_monet/office/barinov_comment <<'DATA'
Баринов требует уменьшить количество сахара
Крем должен быть приготовлен перед подачей
Луи отвечает за оформление десертов
Новое меню показать шефу до обеда
DATA
cat > louis_room/louis_diary <<'DATA'
Луи пришёл в кондитерский цех первым
Утром он приготовил любимый десерт Нагиева
После банкета Луи позвонил маме
Вечером весь зал похвалил его торт
DATA
cat > louis_room/work_schedule <<'DATA'
Луи начинает работу в семь часов
До открытия нужно проверить печь
После обеда начинается подготовка банкета
Закрывает кондитерский цех Лёва
DATA
cat > morning_order <<'DATA'
К открытию подготовить свежую выпечку
Вика ждёт список готовых десертов
Баринов проводит проверку в десять часов
Луи передаёт первый заказ официантам
DATA
chmod 755 claude_monet
chmod u=rwx,g=rx,o= claude_monet/pastry_station
chmod 750 claude_monet/pastry_station/oven
chmod u=rw,g=r,o= claude_monet/pastry_station/oven/croissant_plan
chmod 640 claude_monet/pastry_station/oven/millefeuille_plan
chmod u=rwx,g=rx,o= claude_monet/pastry_station/cold_room
chmod 600 claude_monet/pastry_station/cold_room/cream_note
chmod u=rw,g=r,o=r claude_monet/pastry_station/dessert_menu
chmod 755 claude_monet/hall
chmod u=rw,g=rw,o=r claude_monet/hall/banquet_orders
chmod 644 claude_monet/hall/guest_wishes
chmod u=rwx,g=rx,o= claude_monet/office
chmod 640 claude_monet/office/barinov_comment
chmod 750 louis_room
chmod u=r,g=r,o= louis_room/louis_diary
chmod 644 louis_room/work_schedule
chmod u=rwx,g=,o= empty_boxes
chmod u=rw,g=r,o=r morning_order
;;
2)
cp louis_room/louis_diary claude_monet/office/confectioner_report
cp -R claude_monet/hall claude_monet/pastry_station/hall_backup
ln -s ../claude_monet/pastry_station/dessert_menu louis_room/today_menu
ln -s claude_monet/pastry_station dessert_counter
ln morning_order claude_monet/pastry_station/urgent_order
cat claude_monet/pastry_station/oven/croissant_plan claude_monet/pastry_station/oven/millefeuille_plan > claude_monet/pastry_station/baking_plan
cat claude_monet/office/barinov_comment >> claude_monet/pastry_station/dessert_menu
mv claude_monet/hall/guest_wishes claude_monet/office/special_wishes
;;
3)
export LC_ALL=C.UTF-8
printf '\n1. Пять крупнейших файлов без report:\n'
ls -lR . | grep '^-' | grep -v 'report' | sort -k5,5n | tail -n 5
printf '\n2. Строки с луи или десерт без гост:\n'
grep -rhiE 'луи|десерт' claude_monet louis_room | grep -vi 'гост' | sort -r | head -n 5
printf '\n3. Количество файлов с десерт:\n'
grep -li 'десерт' claude_monet/hall/* claude_monet/pastry_station/hall_backup/* | wc -l
printf '\n4. Конец файлов _plan:\n'
tail -q -n 2 claude_monet/pastry_station/oven/*_plan | grep -iE 'десерт|порц' | sort
printf '\n5. Количество слов:\n'
grep -v 'Луи' claude_monet/pastry_station/baking_plan | sort -r | head -n 4 | wc -w
printf '\n6. Файлы с двумя жёсткими ссылками:\n'
ls -lR . | grep '^-' | grep -E '^[^ ]+ +2 ' | sort -k9,9r
printf '\n7. Последняя символическая ссылка:\n'
ls -lR . | grep '^l' | sort -k9,9 | tail -n 1
rm louis_room/louis_diary louis_room/today_menu dessert_counter morning_order claude_monet/pastry_station/urgent_order claude_monet/pastry_station/cold_room/cream_note
rmdir empty_boxes
rm -r claude_monet/pastry_station/hall_backup
;;
*) echo 'Использование: variant7.sh 1|2|3 (этапы по порядку)' >&2; exit 1;;
esac
