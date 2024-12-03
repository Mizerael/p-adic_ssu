#import "../../template.typ": *
#show: SCworks.with(
  title: "Задание № 3",
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

Транзитивна ли заданная функция $h: ZZ_2 -> ZZ_2$?

$ h(x)=(x xor 1) xor (2 (x op("AND")(1 + 2x)op("AND")(3 + 4x)\
                           op("AND")(7 + 8x)op("AND")(15 + 16x)
                           op("AND")(31 + 32x)op("AND")(63+64x))) 
                 xor (4(x^2+30)) $

= Аналитическое решение

Функция $h$ есть композиция арифметических и логическких операций: сложения,
умножения, XOR и AND, следовательно, функция $h$ 1-Липшицева, поскольку
композиция 1-Липшицевых функций --- 1-Липшицева.

Значит, $h$ можно записать в виде ряда:

$ h(x) = sum_(i=0)^infinity psi(x_0, dots, x_i)2^i = psi_0(x_0) 
      &+ psi_1(x_0,x_1) dot 2 + psi_2(x_0,x_1,x_2)dot 2^2 + dots $
где $psi_i:brace.l 0, 1 brace.r^(i+1) -> brace.l 0, 1 brace.r$.

Представим функцию $h$ в виде поразрядной суммы трех функций

$ h(x) = F_0(x) xor 2F_1(x) xor F_2(x), $
где 

$F_0(x) = x xor 1, $

$F_1(x) = x op("AND")(1 + 2x)op("AND")(3 + 4x)op("AND")(7 + 8x)
op("AND")(15 + 16x)\
op("AND")(31 + 32x)op("AND")(63 + 64x) = x dot.circle (1 dot 2^0 + x dot 2^1) \
dot.circle (1 dot 2^0 + 1 dot 2^1 + x dot 2^2) dot.circle 
(1 dot 2^0 + 1 dot 2^1 + 1 dot 2^2 + x dot 2^3)\
dot.circle (1 dot 2^0 + 1 dot 2^1 + 1 dot 2^2 + 1 dot 2^3 + x dot 2^4)\
dot.circle (1 dot 2^0 + 1 dot 2^1 + 1 dot 2^2 + 1 dot 2^3 + 1 dot 2^4 + x dot 2^5)\
dot.circle (1 dot 2^0 + 1 dot 2^1 + 1 dot 2^2 + 1 dot 2^3 + 1 dot 2^4 + 1 dot 2^5 + x dot 2^6),
$

$F_2(x) =x^2 + 30$.

1) координатные функции для $F_0(x)$:

$delta_0(F_0(x)) = delta_0(x) xor 1 = x_0 xor 1, delta_1(F_0(x)) = delta_1(x) = x_1,delta_2(x) = x_2,$и т.д., т.е

$ delta_i (F_0(x)) := cases(
  x_0 xor 1\, &"если" i = 0\
  x_i\,
  &"если" i > 0.\
) $

2) далее координатные функции для $2F_1(x)$:

$delta_0(2F_1(x)) = 0, delta_i(2F_1(x))= delta_(i-1)(F_1(x))$ при $i = 1,2 dots$

$delta_0(F_0 xor (2F_1(x))) = x xor 1$

$delta_i (F_0 xor (2F_1(x))) = delta_(i)(x) xor delta_(i-1)(F_1(x))$ для $i = 1, 2, dots$

3) координатные функции для $F_1(x)$:

$delta_0(F_1(x)) = delta_0(x);\ 
delta_1(F_1(x)) = delta_1(x) dot delta_0(x);\ 
delta_2(F_1(x)) = delta_2(x) dot delta_1(x) dot delta_0(x);\ 
delta_3(F_1(x)) = delta_3(x) dot delta_2(x) dot delta_1(x) dot delta_0(x);\ 
dots\
delta_6(F_1(x)) = delta_6(x) dot dots dot delta_1(x) dot delta_0(x); 
$

В общем виде $d_(i)(F_1(x)) = delta_(i)(x) dot dots dot delta_(max{o, i-6})(x);$

4) Координатные функции для $4F_2(x)$:

$delta_0(4F_2(x)) = delta_1(4F_2(x)) = 0;\ 
delta_(i)(4F_2(x)) = delta_(i-2)(), i = 2,3, dots $ 

Координатные функции для $h$:

$delta_0(h(x)) = delta_0(x) xor 1 = x_0 xor 1;\ 
delta_1(h(x)) = delta_1(x) xor delta_0(x) = x_1 xor x_0;\
delta_(i)(h(x)) = delta_(i)(x) xor bracket.l delta_(i-1)(x) dot delta_(i-2)(x) dot dots dot
delta_(max brace.l 0, i-7 brace.r)(x) bracket.r xor delta_(i-2)(F_2(x)), i = 2, 3, dots
$

Заметим, что $delta(i-2)(F_2(x))$ не зависит от $delta_(i-1)(x)$.

В итоге имеем:

$ h(x) = sum_(i=0)^infinity psi(x_0, dots, x_i)2^i = psi_0(x_0) + psi_1(x_0,x_1) dot 2 + psi_2(x_0,x_1,x_2)dot 2^2 + dots $

Здесь $psi_0(x_0) = delta_0(x) xor 1 = x_0 xor 1,$

$psi_1(x_0,x_1) = delta_1(x) xor delta_0(x) = x_1 xor x_0,$

$psi_(i)(x_0, dots x_i) = delta_i(f(x)) = x_i xor phi.alt_(i)(x_0, dots, x_(i-1))$
где $phi.alt_(i)(x_0, dots, x_(i-1))$ есть АНФ степени $i$ (АНФ $phi.alt_(i)$
содержит моном $x_0 x_1 dots x_(i-1), i = 1,2,dots$) b $phi.alt_0(x_0)=1$.

По теореме 8.5(пособие V. Anashin, The p-adic ergodic theory and applications)
функция $h$ эргодична, следовательно, транзитивна, т.к согласно основной
эргодической теореме, эргодичность 1-Липшицевой функции равносильна её
транзитивности. Из транзитивности вытекает транзитивность по модулю 256.

= Программная реализация

Для решения поставленной задачи был написан код на языке _Python_.

#raw(read("transitive.py"), lang: "py3", block: true,)

= Результат

Результат работы программного кода, представленного выше:

#image("results.png")
