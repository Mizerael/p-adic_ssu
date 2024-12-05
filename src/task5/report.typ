#import "../../template.typ": *
#show: SCworks.with(
  title: "Задание № 5",
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

Построить $beta$-проекции с точностью до заданных $k$ разрядов для функций:

$f(x)= -7 - 17x + 3x^2\ g(x)= frac(11,15)x + frac(12,23)\
h(x)=(x xor 1) xor (2 (x op("AND")(1 + 2x)op("AND")(3 + 4x)\
                           op("AND")(7 + 8x)op("AND")(15 + 16x)
                           op("AND")(31 + 32x)op("AND")(63+64x))) 
                 xor (4(x^2+30)) $
при $beta = 2^frac(1,n)$ (для $n= 50, dots, 100; k = 15, dots, 20$).

= Аналитическое решение

$beta$-представление числа $r$ ($beta >1$ и $r>=0$ действительное число):

$ r = sum_(j=-m)^infinity  r_(j) beta^(-j), "где" r_j in  brace.l 0,1,dots, 
 floor(beta) brace.r, m in ZZ, $

 где $floor(beta)$ -- целая часть числа $beta$.

Далее, пусть $p$ простое число и $floor(beta) = p - 1$. $beta$-проекция
автоматного отображения $f$, реализуемого автоматом с входным/выходным 
алфавитами $brace.l 0,1, dots, p-1 brace.r$ (т.е $beta$-проекция 1-Липшицевой
функции, в частности, $T$-функции (случай $p=2$)) определяются следующим
образом: для каждого натурального $k=1,2,dots$, для каждого бесконечного
входного слова $dots x_2 x_1 x_0$, которое ассоциировано с целым $p$-адическим
числом

$ x = x_0 + x_1 p + x_2 p^2 + dots $

и соответствующего выходного слова $dots y_2 y_1 y_0$(целого $p$-адического
числа $f(x)$)

$ f(x)= y_0 + y_1 p + y_2 p^2 + dots $

определим точки $e_(k)(x)$ еденичного квадрата евклидовой плоскости $bracket.l
0,1 bracket.r times bracket.l 0,1 bracket.r subset RR^2$:

$ e_(k)(x)=
(frac(x_0 + x_1 beta + x_2 beta^2 + dots + x_(k-1)beta^(k-1), beta^k) mod 1,
frac(y_0 + y_1 beta + y_2 beta^2 + dots + y_(k-1)beta^(k-1), beta^k) mod 1
) $

Замыкание (в топологии плоскости $RR_2$) множеста $union.big_(k=1)^infinity
{e_(k)(x): x in ZZ_p}$ определяет $beta$-проекцию автоматного отображения $f$.

Вычислим точку $e_(k)(x)$ для функции $f(x)= -7 - 17x + 3x^2$.

Пусть $x= 10, k = 15, n= 75$, тогда:

$x = 10 = (0)^infinity 1010_2 = 0 + 1 dot 2 + 0 dot 2^2 + 1 dot 2^3 + dots =>\
x_0 = 0, x_1 = 1, x_2 = 0, x_3 = 1, x_i = 0("для" i = 4, 5, dots)\
f(x) = f(10) = -7 - 17 dot 10 + 3 dot 10^2 = 123 = (0)^infinity 1111011 = \
1 + 1 dot 2 + 0 dot 2^2 + 1 dot 2^3 + 1 dot 2^4 + 1 dot 2^5 + 1 dot 2^6 + dots =>\
y_0 = 1, y_1 =1, y_2 = 0, y_3 = 1, y_4 = 1, y_5 = 1, y_6 = 1,
y_i = 0("для" i = 7, 8, dots)$

$beta = 2^frac(1,n)= 2^frac(1,75)$

$ e_(15)(10)=
(frac(x_0 + x_1 beta + x_2 beta^2 + dots + x_(14)beta^(14), beta^15) mod 1,
frac(y_0 + y_1 beta + y_2 beta^2 + dots + y_(14)beta^(14), beta^15) mod 1) =\
(frac(beta + beta^3, beta^15) mod 1,
frac(1 +beta + beta^3 + beta^4 + beta^5 + beta^6, beta^15) mod 1) =\
(frac(2^frac(1,75) + 2^frac(1,75)^3, 2^frac(1,75)^15) mod 1,
frac(1 +2^frac(1,75) + 2^frac(1,75)^3 + 2^frac(1,75)^4 + 2^frac(1,75)^5
+ 2^frac(1,75)^6, 2^frac(1,75)^15) mod 1) =\
(0.7736585231491848, 0.3794544264195805)
$ 


= Программная реализация

Для решения поставленной задачи был написан код на языке _Python_.

#raw(read("./betaproection.py"), lang: "py3", block: true,)

= Результат


$beta$- проекции для функции $f(x):$
#figure(
  grid(
    columns:2,
    image("./images/f/15-50.png"),
    image("./images/f/15-60.png"),
    image("./images/f/15-70.png"),
    image("./images/f/15-80.png"),
    image("./images/f/15-90.png"),
    image("./images/f/15-100.png"),
  )
)

#figure(
  grid(
    columns:2,
    image("./images/f/16-50.png"),
    image("./images/f/16-60.png"),
    image("./images/f/16-70.png"),
    image("./images/f/16-80.png"),
    image("./images/f/16-90.png"),
    image("./images/f/16-100.png"),
  )
)

#figure(
  grid(
    columns:2,
    image("./images/f/17-50.png"),
    image("./images/f/17-60.png"),
    image("./images/f/17-70.png"),
    image("./images/f/17-80.png"),
    image("./images/f/17-90.png"),
    image("./images/f/17-100.png"),
  )
)

#figure(
  grid(
    columns:2,
    image("./images/f/18-50.png"),
    image("./images/f/18-60.png"),
    image("./images/f/18-70.png"),
    image("./images/f/18-80.png"),
    image("./images/f/18-90.png"),
    image("./images/f/18-100.png"),
  )
)

#figure(
  grid(
    columns:2,
    image("./images/f/19-50.png"),
    image("./images/f/19-60.png"),
    image("./images/f/19-70.png"),
    image("./images/f/19-80.png"),
    image("./images/f/19-90.png"),
    image("./images/f/19-100.png"),
  )
)

#figure(
  grid(
    columns:2,
    image("./images/f/20-50.png"),
    image("./images/f/20-60.png"),
    image("./images/f/20-70.png"),
    image("./images/f/20-80.png"),
    image("./images/f/20-90.png"),
    image("./images/f/20-100.png"),

  )
)

$beta$- проекции для функции $h(x):$
#figure(
  grid(
    columns:2,
    image("./images/h/15-50.png"),
    image("./images/h/15-60.png"),
    image("./images/h/15-70.png"),
    image("./images/h/15-80.png"),
    image("./images/h/15-90.png"),
    image("./images/h/15-100.png"),
  )
)

#figure(
  grid(
    columns:2,
    image("./images/h/16-50.png"),
    image("./images/h/16-60.png"),
    image("./images/h/16-70.png"),
    image("./images/h/16-80.png"),
    image("./images/h/16-90.png"),
    image("./images/h/16-100.png"),
  )
)

#figure(
  grid(
    columns:2,
    image("./images/h/17-50.png"),
    image("./images/h/17-60.png"),
    image("./images/h/17-70.png"),
    image("./images/h/17-80.png"),
    image("./images/h/17-90.png"),
    image("./images/h/17-100.png"),
  )
)

#figure(
  grid(
    columns:2,
    image("./images/h/18-50.png"),
    image("./images/h/18-60.png"),
    image("./images/h/18-70.png"),
    image("./images/h/18-80.png"),
    image("./images/h/18-90.png"),
    image("./images/h/18-100.png"),
  )
)

#figure(
  grid(
    columns:2,
    image("./images/h/19-50.png"),
    image("./images/h/19-60.png"),
    image("./images/h/19-70.png"),
    image("./images/h/19-80.png"),
    image("./images/h/19-90.png"),
    image("./images/h/19-100.png"),
  )
)

#figure(
  grid(
    columns:2,
    image("./images/h/20-50.png"),
    image("./images/h/20-60.png"),
    image("./images/h/20-70.png"),
    image("./images/h/20-80.png"),
    image("./images/h/20-90.png"),
    image("./images/h/20-100.png"),

  )
)


$beta$- проекции для функции $g(x):$
#figure(
  grid(
    columns:2,
    image("./images/g/15-50.png"),
    image("./images/g/15-60.png"),
    image("./images/g/15-70.png"),
    image("./images/g/15-80.png"),
    image("./images/g/15-90.png"),
    image("./images/g/15-100.png"),
  )
)

#figure(
  grid(
    columns:2,
    image("./images/g/16-50.png"),
    image("./images/g/16-60.png"),
    image("./images/g/16-70.png"),
    image("./images/g/16-80.png"),
    image("./images/g/16-90.png"),
    image("./images/g/16-100.png"),
  )
)

#figure(
  grid(
    columns:2,
    image("./images/g/17-50.png"),
    image("./images/g/17-60.png"),
    image("./images/g/17-70.png"),
    image("./images/g/17-80.png"),
    image("./images/g/17-90.png"),
    image("./images/g/17-100.png"),
  )
)

#figure(
  grid(
    columns:2,
    image("./images/g/18-50.png"),
    image("./images/g/18-60.png"),
    image("./images/g/18-70.png"),
    image("./images/g/18-80.png"),
    image("./images/g/18-90.png"),
  )
)

#figure(
  grid(
    columns:2,
    image("./images/g/19-50.png"),
    image("./images/g/19-60.png"),
    image("./images/g/19-70.png"),
    image("./images/g/19-80.png"),
    image("./images/g/19-90.png"),
    image("./images/g/19-100.png"),
  )
)

#figure(
  grid(
    columns:2,
    image("./images/g/20-50.png"),
    image("./images/g/20-60.png"),
    image("./images/g/20-70.png"),
    image("./images/g/20-80.png"),
    image("./images/g/20-90.png"),
    image("./images/g/20-100.png"),

  )
)
