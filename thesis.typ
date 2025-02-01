#import "/layout/thesis_template.typ": *
#import "/metadata.typ": *

#set document(title: titleEnglish, author: author)

#show: thesis.with(
  title: titleEnglish,
  titleGerman: titleGerman,
  degree: degree,
  program: program,
  supervisor: supervisor,
  advisors: advisors,
  author: author,
  startDate: startDate,
  submissionDate: submissionDate,
  abstract_en: include "/content/abstract_en.typ",
  abstract_de: include "/content/abstract_de.typ",
  //cknowledgement: include "/content/acknowledgement.typ",
)

#include "/content/einleitung.typ"
#include "/content/grundlagen.typ"
#include "/content/analyse.typ"
#include "/content/umsetzung.typ"
#include "/content/validierung.typ"
#include "/content/diskussion.typ"
