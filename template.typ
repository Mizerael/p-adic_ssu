#let SCworks(
  title: [Название работы],
  worktype: [Тип работы],
  chair: [Кафедра],
  course: [Курс],
  group: [Группа],
  studenttitle: [студента],
  satitle: [должность],
  saname: [И. О. Фамилия],
  author: [Фамилия Имя Отчество],
  speciality: [Направление обучения],
  paper-size: "a4",
  body
) = {
  set document(title: title, author: author)
  set text(font: "Times New Roman", size: 14pt, lang: "ru")
  set page(number-align: center, margin: (left: 25mm, right: 15mm, y: 20mm))

  v(3pt, weak: true)
  align(center, text(14pt, "МИНОБРНАУКИ РОССИИ"))
  align(center, text(14pt, "Федеральное государственное бюджетное образовательное учреждение высшего образования"))
  align(
    center,
    text(
      14pt,
      weight: "bold",
      "«САРАТОВСКИЙ НАЦИОНАЛЬНЫЙ ИССЛЕДОВАТЕЛЬСКИЙ \n ГОСУДАРСТВЕННЫЙ УНИВЕРСИТЕТ \n ИМЕНИ Н. Г. ЧЕРНЫШЕВСКОГО»",
    )
  )
  align(center, text(14pt, chair))
  v(75pt)
  align(center, text(14pt, weight: "bold", upper(title)))
  align(center, text(14pt, worktype))
  v(75pt)

  align(left,
    text(
      studenttitle + " " + course + " курса " + group + " группы\n" +
      "направления " + speciality + "\n" +
      "факультета КНиИТ\n" +
      author
    )
  )

  v(150pt)

  grid(
    columns: (0.3fr, 0.3fr, 0.3fr),
    align(left, text("Проверено:\n" + satitle)),
    align(center, text("\n_______________")),
    align(right, text("\n" + saname)),
  )
  
  v(1fr)
  align(center, text("Саратов " + str(datetime.today().year())))
  
  pagebreak()

  set page(numbering: "1", number-align: center)
  counter(page).update(2)
  
  outline(title: "Содержание", depth: 3, indent: auto)

  pagebreak()

  set heading(numbering: "1.1")
  set par(justify: true, first-line-indent: 1.25cm,
)
  body
  
  pagebreak()
  
}

