#import "/utils/todo.typ": TODO

= Grundlagen 
#TODO[
(Dinge die man auf wikipedia lesen kann, was ist schon hier, die Dinge, die ich nachher brauche)
]
== Citizen Science
#TODO[
    - Was ist das?
    - Motivation (Warum machen Leute mit?)
    - Warum ist es wichtig / notwendig?
]
Eine treffende Definition von Citizen Science liefert das Grünbuch Citizen Science Strategie 2020 für Deutschland:
#set quote(block: true)
#show quote: set align(center)
#show quote: set pad(x: 5em)

#quote(attribution: <bonn_grunbuch_2016>)[„Citizen Science beschreibt die Beteiligung von Personen an wissenschaftlichen Prozessen, die nicht in diesem Wissenschaftsbereich institutionell gebunden sind. Dabei kann die Beteiligung in der kurzzeitigen Erhebung von Daten bis hin zu einem intensiven Einsatz von Freizeit bestehen, um sich gemeinsam mit Wissenschaftlerinnen bzw. Wissenschaftlern und/oder anderen Ehrenamtlichen in ein Forschungsthema zu vertiefen. Obwohl viele ehrenamtliche Forscherinnen und Forscher eine akademische Ausbildung aufweisen, ist dies keine Voraussetzung für die Teilnahme an Forschungsprojekten. Wichtig ist allerdings die Einhaltung wissenschaftlicher Standards, wozu vor allem Transparenz im Hinblick auf die Methodik der Datenerhebung und die öffentliche Diskussion der Ergebnisse gehören.“
]

Bürgerinnen und Bürger können also einen Beitrag zur Wissenschaft leisten, indem sie Daten sammeln, analysieren und interpretieren. Dies kann von der einfachen Datenerhebung bis hin zur intensiven Auseinandersetzung mit einem Forschungsthema reichen. Die Beteiligung an Citizen Science Projekten ist nicht an eine akademische Ausbildung gebunden, jedoch ist die Einhaltung wissenschaftlicher Standards unabdingbar.
Es stellt sich die Frage, worin die motivation liegt sich freiwillig solchen Projekten zu widmen. Ein treibender Faktor kann der Wissenszuwachs für ein bestimmtes Thema sein. Die Auseinandersetzung in einem Bereich, für den man sich interessiert.
Das Buch The Science of Citizen Science @vohland_science_2021[p~283] diskutiert die verschiedenen Aspekte des Lernens in einem Citizen Science Projekt. 

#figure(
  image("../figures/citizen_science_learning_map.png", width: 90%),
  caption: [ Erweiterte thematische Karte zum Lernen von Freiwilligen @vohland_science_2021[p~300]
  ],
)

Aus der illustration geht hervor, dass verschiedenste Aspekte die Bürgerinnen und Bürger zu einer aktiven Beteiligung motivieren kann. Nebst den Fachlichen sind auch Soziale Aspekte von Bedeutung. 
Auf der anderen Seite provitieren auch die Projekt initianten. Die Organiation und Zusammenarbeit mit Aussenstehenden kann eine spannende  Aufgabe sein. 


== Biodiversität Monitoring
#TODO[
    (Timeo's Arbeit zitieren - nicht das selbe machen)
    - Sinn und Zweck
    - Mögliche Anwendungszwecke / Szenarien / Perspektiven
    - Mitwelten Pipeline (Von der Kamera zu den Daten)
]
Biodiversitäts Monitoring befasst sich grundsätzlich mit dem Beobachten und Analysieren von Tier - und Pflanzenwelt.

#quote(attribution:  <bdm_verlassliche_nodate>)["Die biologische Vielfalt bildet eine Lebensgrundlage der Schweiz. Deshalb ist es wichtig, ihren Zustand und ihre Entwicklung zu kennen."]
Aus diesem Grund ist es von grosser Bedeutung die Umwelt zu beobachten und Veränderungen festzustellen. Um diese Arbeit zu vereinfachen, sind automatisierte Lösungen für ein Monitoring von gefragt. 

Ein System zur automatisierten Datenerfassung wurde im Rahmen des Projekts Mitwelten entwickelt @wullschleger_data_nodate @wullschleger_automated_nodate. Hierfür wurden verschiedene Sensoren zu einem IoT-Toolkit kombiniert. Dieses Toolkit ermöglicht es, Daten von dezentralen Systemen zu erfassen und an ein zentrales Backend weiterzuleiten.

Das IoT-Toolkit umfasst unter anderem eine Kamera, die in regelmässigen Abständen Fotos von Blumentöpfen aufnimmt. Im Rahmen des Projekts wurden so insgesamt 1,5 Millionen Bilder generiert. Abbildung @pollinator_cam zeigt eine im Feld aufgestellte Kamera.

#figure(
  image("../figures/pollinator_cam.png", width: 50%),
  caption: [Pollinator Kamera im Feld],
)<pollinator_cam>


Das IoT-Toolkit enthält eine Kamera, die regelmäßig Fotos von Blumentöpfen aufnimmt. Während des Projekts erfasste die Kamera insgesamt 1,5 Millionen Bilder.

Die enorme Menge an Bilddaten lässt sich nicht manuell analysieren. Deshalb entwickelte das Projekt-Team eine Machine-Learning-Pipeline, die Bestäuber automatisch erkennt.
Die technische Architektur des Systems verbindet die Kamera mit einem leistungsstarken Backend. Die Kamera, bestehend aus einem Raspberry Pi und einer angeschlossenen Kameraeinheit, erfasst die Bilder und überträgt diese über einen Access Point an das Backend. Auf dem Server führt eine leistungsstarke Machine-Learning-Pipeline die Analyse der empfangenen Bilder durch, um Analysedaten zu generieren.
Die entwickelte Kamera und die zugehörige technische Architektur bieten weit mehr Möglichkeiten als nur die Detektion von Bestäubern. Mit kleinen Anpassungen lässt sich das System auch für andere Biodiversitäts-Monitorings einsetzen, wie etwa die Beobachtung von Vögeln an Futterstellen, die Erkennung von Säugetieren in Waldgebieten oder die Dokumentation des Pflanzenwachstums.



== Machine Learning Grundlagen
#TODO[
    - Frameworks (Unterschiede, Vor- und Nachteile)
    - Anatomie eines Modells
        - Input output tensor
        - Art / Architektur / Performance / Measurements
    - Training, Inferenz, Validierung (Genauigkeit)
]
== Edge Computing / Edge Machine Learning 
#TODO[
    (vllt auch in der AUsgangslage erwähnen)
    - Architektur (Shift von Cloud zu Edge)
    - Konsequenzen und Vorteile (Latenz, Kosten, Privacy)
    - Herausforderungen (Energie, Rechenleistung)
]
== Edge ML
#TODO[
    - Hardware die Edge Computing und ML vereint
    - Pipelines / Datenfluss (herkömmlich, AI-Camera)
]
