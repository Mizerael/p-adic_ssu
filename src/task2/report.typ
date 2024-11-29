#import "../../template.typ": *
#show: SCworks.with(
  title: "Задание № 2",
  chair: "",
  worktype: "Отчет",
  course: "1",
  group: "173",
  speciality: "02.04.03 — Математическое обеспечение и администрирование информационных систем",
  author: "Ковешникова Даниила Вадимовича",
  satitle: "доцент, к.ф.-м.н.",
  saname: "Л.Б.Тяпаев",
)

// Enable line numbering in code blocks
#show raw.where(block: true): it => {
  set par(justify: false);
  set text(size: 10pt);
  grid(
    columns: (100%, 100%),
    column-gutter: -100% - 1em,
    block(width: 100%, inset: 1em, for (i, line) in it.text.split("\n").enumerate() {
      box(width: 0pt, align(right, str(i + 1) + h(2em)))
      hide(line)
      linebreak()
    }),
    block(width: 100%, inset: 1em, it),
  )
}
#let colred(x) = text(fill: red, x)
#let colgreen(x) = text(fill:green, x)
= Содержание задачи

Проверить на биективность/транзитивность полиномы $f(x)$ и $g(x)$ на $ZZ_2$.
Решить задачу аналитически, затем проверить с помощью программной реализации.
Вариант N вычисляется так: если $n < 20$, то $N = n mod 20$; в противном
случае, $N = n mod 20+1$. Здесь n есть \<\<номер\>\> студента из единого списка
групп 171 и 173.

Вариант 11: $f(x)= -7 - 17x + 3x^2, g(x)= frac(11,15)x + frac(12,23)$

= Аналитическое решение

Для решения задачи требуется найти редукции
#figure(
  table(
    columns: 2,
    stroke: none,
    [$f mod 4;$], [$g mod 4;$],
    [$f mod 8;$], [$g mod 8;$],
  )
)
Для $f(x)= -7 - 17x + 3x^2$ редукция $f mod 4 = 1 + 3x + 3x^2$, в силу того,
что $-7 = (1)^infinity 001, -17 = (1)^infinity 01111, 3 = (0)^infinity 011$.

Имеем
#figure(
  table(
    columns: 1,
    stroke: none,
    [$f(0) mod 4 = 1;$],
    [$f(1) mod 4 = 3;$],
    [$f(2) mod 4 = 3;$],
    [$f(3) mod 4 = 1;$],
  )
)
следовательно редукция $f mod 4$ не является биекцией и с помощью теоремы
Ларина делаем вывод, что функция $f(x)$ небиективна. А поскольку транзитивные
функции лежат в классе биективных, функция $f(x)$ не будет и транзитивной.

Для $g(x) = frac(11,15)x + frac(12,23)$ редукции такие: $g mod 4 = x$;
$g mod 8 = 5x + 4$, т.к $frac(11,15) = (0110)^infinity 1$ и
$frac(11,15) = 01 = 1$, $frac(11,15) mod 8 = 101 = 5$;
$frac(12,23) = ...010100$ и $frac(12,23) mod 4 = 0$,
$frac(12,23) mod 8 = 100 = 4$.

Здесь разложение дробей $frac(x,y)$ в виде целого p-адического числа строим
следующим образом:

#table(
    columns: 1,
    stroke: none,
    align:left,
    [$frac(11,15) = colred(1) + 2 dot frac(-2,15) => colred(x_0 = 1) \
    colgreen(frac(-2,15)) = colred(0) + 2 dot frac(-1,15) => colred(x_1 = 0) \
    frac(-1,15) = colred(1) + 2 dot frac(-7,15) => colred(x_2 = 1) \
    frac(-7,15) = colred(1) + 2 dot frac(-4,15) => colred(x_3 = 1) \
    frac(-4,15) = colred(0) + 2 dot colgreen(frac(-2,15)) => colred(x_4 = 0) \
    dots
    $],
)
для дроби $ frac(11,15)$; и

#table(
    columns: 1,
    stroke: none,
    align:left,
    [$frac(12,23) = colred(0) + 2 dot frac(6,23) => colred(x_0 = 0) \
    frac(6,23) = colred(0) + 2 dot frac(3,23) => colred(x_1 = 0) \
    frac(3,23) = colred(1) + 2 dot frac(-10,23) => colred(x_2 = 1) \
    frac(-10,23) = colred(0) + 2 dot frac(-5,23) => colred(x_3 = 0) \
    frac(-5,23) = colred(1) + 2 dot frac(-14,23) => colred(x_4 = 1) \
    frac(-14,23) = colred(0) + 2 dot frac(-7,23) => colred(x_5 = 0) \
    dots
    $],
)

для дроби $frac(12,23)$.

Редукция $x|->x$ является перестановкой по модулю 4: (1,1)(2,2)(3,3)(4,4);
следовательно, функция $g(x)= frac(11,15)x + frac(12,23)$ биективна по модулю 4.
Редукция $x|->5x + 4$ не является одноцикловой перестановкой по модулю 8:
(0,4)(4,0)(1,1)(2,6)(6,2)(3,3)(5,5)(7,7); следовательно, функция $g(x) = frac(11,15)x + frac(12,23)$ не является транзитивной по модулю 8.

Согласно критерию биективности/транзитивности полинома(теорема Ларина), функция
$g(x)= frac(11,15)x + frac(12,23)$ биективна, но не транзитивнана $ZZ_2$.

= Программная реализация

Для решения поставленной задачи был написан код на языке _Python_.

#raw(read("bee_tran_poly.py"), lang: "py3", block: true,)

= Результат

Результат работы программного кода, представленного выше:

#image("results.png")
