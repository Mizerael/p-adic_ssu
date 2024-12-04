#import "../../template.typ": *
#show: SCworks.with(
  title: "Задание № 4",
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
#let Imagedir = "images"
= Содержание задачи

Построить проекции в еденичном квадрате $II^2 = bracket.l 0, 1 bracket.r times
bracket.l 0,1 bracket.r$ плоскости для функций $f$ и $h$ (задания 2 и 3) с
точностью до $k = 15, dots, 20$ раздядов. Для функции $g$ (задание 2) записать
обмотки тора, построить её график в $II^2$.

$f(x)= -7 - 17x + 3x^2\ g(x)= frac(11,15)x + frac(12,23)\
h(x)=(x xor 1) xor (2 (x op("AND")(1 + 2x)op("AND")(3 + 4x)\
                           op("AND")(7 + 8x)op("AND")(15 + 16x)
                           op("AND")(31 + 32x)op("AND")(63+64x))) 
                 xor (4(x^2+30)) $

= Аналитическое решение

График линейной p-адический функции $f(x) = c x + q$, где $c, g in ZZ_p sect QQ
, c=frac(r,s), g = frac(r^', s^'), r, r^'in ZZ, s, s^'in NN$  и при этом НОД
$(r, s)=$ НОД$(r^',s^')=$ НОД$(s,p)=$НОД$(s^',p)=1$, представляет собой 
зацепление торических узлов и каждый торический узел является обмоткой тора:
$ z_(i) = brace.l (y mod 1, (c y + e) mod 1): y in RR, e in C(q) brace.r, $

где:

$i = 0, 2, dots, "mult"_(m)p-1, m = frac(s^', "НОД"(s, s^')),\ C(q) = brace.l (-p^ell dot frac(r^',s^')))
mod 1 : ell = 0,1,2,dots,"mult"_(m)p-1 brace.r $

Для 2-аддической функции $g(x) = frac(11,15)x + frac(12,23)$ имеем  $r = 11,
s=15, r^' = 12, s^'= 23$, $m = frac(s^', "НОД"(s, s^')) =
frac(23, "НОД"(15,23)) = 23$, $2^ell equiv 1 (mod 23)$ при $ell = 11$ и
мультипликативный порядок $"mult"_(23)2 = ell = 11$. Следовательно, график
функции $g$ будет состоять из 11 обмоток тора $TT^2$:


#figure(
  table(
    columns: 1,
    stroke: none,
    [$z_0 = brace.l (y mod 1, (frac(11,15) y + frac(11, 23)) mod 1): y in RR brace.r$],
    [$z_1 = brace.l (y mod 1, (frac(11,15) y + frac(22, 23)) mod 1): y in RR brace.r$],
    [$z_2 = brace.l (y mod 1, (frac(11,15) y + frac(21, 23)) mod 1): y in RR brace.r$],
    [$z_3 = brace.l (y mod 1, (frac(11,15) y + frac(19, 23)) mod 1): y in RR brace.r$],
    [$z_4 = brace.l (y mod 1, (frac(11,15) y + frac(15, 23)) mod 1): y in RR brace.r$],
    [$z_5 = brace.l (y mod 1, (frac(11,15) y + frac(7, 23)) mod 1): y in RR brace.r$],
    [$z_6 = brace.l (y mod 1, (frac(11,15) y + frac(14, 23)) mod 1): y in RR brace.r$],
    [$z_7 = brace.l (y mod 1, (frac(11,15) y + frac(5, 23)) mod 1): y in RR brace.r$],
    [$z_8 = brace.l (y mod 1, (frac(11,15) y + frac(10, 23)) mod 1): y in RR brace.r$],
    [$z_9 = brace.l (y mod 1, (frac(11,15) y + frac(20, 23)) mod 1): y in RR brace.r$],
    [$z_10 = brace.l (y mod 1, (frac(11,15) y + frac(17, 23)) mod 1): y in RR brace.r$],
  )
)

= Программная реализация

Для решения поставленной задачи был написан код на языке _Python_.

#raw(read("./proection.py"), lang: "py3", block: true,)

= Результат

Результат работы программного кода, представленного выше:

#image("./results.png")

Обмотка тора для $g(x):$

#image("./images/g/thor.png")

Для функции $f(x):$
#image("./images/f/15.png")
#image("./images/f/16.png")
#image("./images/f/17.png")
#image("./images/f/18.png")
#image("./images/f/19.png")
#image("./images/f/19.png")


Для функции $h(x):$
#image("./images/h/15.png")
#image("./images/h/16.png")
#image("./images/h/17.png")
#image("./images/h/18.png")
#image("./images/h/19.png")
#image("./images/h/20.png")

