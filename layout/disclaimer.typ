#let disclaimer(
  title: "",
  degree: "",
  author: "",
  submissionDate: datetime,
) = {
  set page(
    margin: (left: 30mm, right: 30mm, top: 40mm, bottom: 40mm),
    numbering: none,
    number-align: center,
  )

  let body-font = "New Computer Modern"
  let sans-font = "New Computer Modern Sans"

  set text(
    font: body-font, 
    size: 12pt, 
    lang: "en"
  )

  set par(leading: 1em)

  
  // --- Disclaimer ---  
  v(75%)
  text("Hiermit bestätige ich, dass die eingereichte Projektarbeit mit dem Titel «Edge ML Camera for Citizen Sciene» das Resultat meiner persönlichen Erarbeitung der Themen ist. Ich habe keine anderen als die angegebenen Quellen benutzt.")

  v(15mm)
  grid(
      columns: 2,
      gutter: 1fr,
      "Windisch, " + submissionDate.display("[day].[month].[year]"), author
  )
}
