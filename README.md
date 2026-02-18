# swift-lab1

## Как запустить

### Вариант 1: Xcode (самый простой)
1. Открой проект в Xcode.
2. Выбери схему запуска (target) с консольным приложением.
3. Нажми **Run** (▶).
4. Вводи команды в консоли (Debug area).

### Вариант 2: Swift Package Manager (если проект как SPM)
```bash
swift main
```
## Поддерживаемые команды:
### Команды:
  > help
  > add -a "author" -t "title" -g genre [-y year] [-tag tag]
  > list
  > remove -id UUID
  > search [-a "author] [-t "title"] [-g genre] [-y year] [-tag tag]
  > exit


### Пример:
```
  add -a "Dostoevsky" -t "Crime and Punishment" -g classic -y 1866 -tag philosophy
```

## Пример команд
```
> help
...список команд...

> add -a "meow" -t "kittens always win" -g mystery
Книга добавлена: kittens always win

> add -a "kuprin" -t "granatoviy braslet" -g biography -y 1817 -tag women
Книга добавлена: granatoviy braslet

> list
- granatoviy braslet — kuprin [biography] 1817 id=...
- kittens always win — meow [mystery]  id=...

> search -g mystery
- kittens always win — meow [mystery]  id=...

> remove -id ...
Удалено: kittens always win

> exit
Program ended with exit code: 0
```
