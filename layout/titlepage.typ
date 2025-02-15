#let titlepage(
  title: "",
  titleGerman: "",
  degree: "",
  program: "",
  supervisor: "",
  advisors: (),
  author: "",
  startDate: datetime,
  submissionDate: datetime,
) = {
  // Quality checks
  //assert(degree in ("Bachelor", "Master"), message: "The degree must be either 'Bachelor' or 'Master'")
  
  set page(
    margin: (left: 20mm, right: 20mm, top: 30mm, bottom: 30mm),
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

  set par(leading: 0.5em)

  
  // --- Title Page ---
  v(1cm)
  align(center, image("/figures/logo.jpg", width: 26%))

  v(5mm)
  align(center, text(font: sans-font, 2.2em, weight: 700, "Fachhochschule Nordwestschweiz"))
  align(center, text(font: sans-font, 2em, weight: 700, "Hochschule für Informatik"))
  //align(center, text(font: sans-font, 2em, weight: 700, "University of Applied Sciences and Arts Northwestern Switzerland FHNW"))

  //v(5mm)
  //align(center, text(font: sans-font, 1.5em, weight: 100, "School of Computation, Information and Technology \n -- Informatics --"))
  
  v(15mm)

  align(center, text(font: sans-font, 1.3em, weight: 100, degree + program))
  v(8mm)
  

  align(center, text(font: sans-font, 2em, weight: 700, title))
  

  align(center, text(font: sans-font, 2em, weight: 500, titleGerman))

  let entries = ()
  entries.push(("Author: ", author))
  // Only show advisors if there are any
  if advisors.len() > 0 {
    entries.push(("Advisor: ", advisors.join(", ")))
  }
  entries.push(("Start Date: ", startDate.display("[day].[month].[year]")))
  entries.push(("Submission Date: ", submissionDate.display("[day].[month].[year]")))

  v(1cm)
  align(
    center,
    grid(
      columns: 2,
      gutter: 1em,
      align: left,
      ..for (term, desc) in entries {
        (strong(term), desc)
      }
    )
  )
}
