# Лабораторная работа 1 — вариант 7

`variant7.sh` выполняет три этапа варианта 7: создание дерева и прав, копирование и создание ссылок, поиск и удаление.

Запускать из отдельного каталога Debian-контейнера:

```bash
git init
bash /путь/к/variant7.sh 1
git add . && git commit -m "Create initial directory tree"
bash /путь/к/variant7.sh 2
git add . && git commit -m "Copy files and create links"
bash /путь/к/variant7.sh 3
git add . && git commit -m "Filter data and remove requested files"
```

Перед каждым коммитом можно выполнить `git status`. Для VS Code Dev Containers используется `.devcontainer/devcontainer.json`.
