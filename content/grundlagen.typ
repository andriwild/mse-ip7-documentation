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
Aus diesem Grund ist es von grosser Bedeutung die Umwelt zu beobachten und Veränderungen festzustellen. Um diese Arbeit zu vereinfachen, sind automatisierte Lösungen für ein Monitoring gefragt. 

Ein System zur automatisierten Datenerfassung wurde im Rahmen des Projekts Mitwelten entwickelt @wullschleger_data_nodate @wullschleger_automated_nodate. Hierfür wurden verschiedene Sensoren zu einem IoT-Toolkit kombiniert. Dieses Toolkit ermöglicht es, Daten von dezentralen Systemen zu erfassen und an ein zentrales Backend weiterzuleiten.

Das IoT-Toolkit umfasst unter anderem eine Kamera, die in regelmässigen Abständen Fotos von Blumentöpfen aufnimmt. Im Rahmen des Projekts wurden so insgesamt 1,5 Millionen Bilder generiert. Abbildung @pollinator_cam zeigt eine im Feld aufgestellte Kamera.

#figure(
  image("../figures/pollinator_cam.png", width: 50%),
  caption: [Pollinator Kamera im Feld],
)<pollinator_cam>

Die enorme Menge an Bilddaten lässt sich nicht manuell analysieren. Deshalb entwickelte das Projekt-Team eine Machine-Learning-Pipeline, die Bestäuber automatisch erkennt.
Die technische Architektur des Systems verbindet die Kamera mit einem leistungsstarken Backend. Die Kamera, bestehend aus einem Raspberry Pi und einer angeschlossenen Kameraeinheit, erfasst die Bilder und überträgt diese über einen Access Point an das Backend. Auf dem Server führt eine Machine-Learning-Pipeline die Analyse der empfangenen Bilder durch, um Bestäuber zu erkennen.
Im Kontext dieser Entwicklung wurden ebenfalls alternative Architekturen untersucht. Under anderem ein System, auf dem die Machine-Learning-Pipeline auf einem Raspberry Pi 3 ausgeführt wurde. Aufgrund der zu langen Analysezeiten wurde jedoch ein Server basierter Ansatz gewählt.


== Machine Learning Grundlagen
#TODO[
    - Frameworks (Unterschiede, Vor- und Nachteile)
    - Anatomie eines Modells
        - Architektur 
            - welche parameter eines modells werden beider Erstellung definiert
                - Input output tensor
        - Art: typen von ML modellen (object detection, segmentation, pose)
        - welche messdaten gibt es für object detection (iou, mAP, perfomance / inferentzeit)
        - training eines models (sehr oberflächlich)
        - infernz, was ist das ?
]
=== ML Frameworks
Ein Machine-Learning-Framework bildet die Grundlage für die Entwicklung, das Training und die Bereitstellung von Modellen. Es bietet Werkzeuge und Bibliotheken, die den gesamten ML-Workflow unterstützen. Im Gegensatz dazu ist ein Machine-Learning-Modell das konkrete Ergebnis des Trainingsprozesses, das spezifische Aufgaben wie Klassifikation oder Objekterkennung ausführt. Während ein Framework die Infrastruktur bereitstellt, ist das Modell die fertige Anwendung innerhalb dieser Infrastruktur.


==== TensorFlow
TensorFlow @noauthor_tensorflow_nodate wurde ursprünglich von Google entwickelt und ist inzwischen ein Open Source Projekt. Das Framework ist eher für Systeme in Produktion gedacht.
- Vorteile: Weit verbreitet mit grosser Community und umfangreicher Dokumentation. Stellt viele Features zu Verfügung.
- Nachteile: Steile Lernkurve, insbesondere für Einsteiger. Komplex durch die vielen Features.

==== TensorFlow Lite
- Vorteile: Speziell für den Betrieb auf ressourcenbeschränkten Geräten optimiert. Reduzierte Speicher- und Rechenanforderungen für Echtzeit-Anwendungen.
- Nachteile: Eingeschränkte Unterstützung für komplexe Modelle, Quantisierung erforderlich.


==== PyTorch
PyTorch @noauthor_pytorch_nodate ist ebenfalls Open Source und hat seinen Ursprung im Forschungsteam für künstliche Intelligenz von Facebook. Das Framework eignet sich für Experimente kann aber auch für Systeme in Produktion eingesetzt werden. ChatGPT von OpenAI arbeitet im Hintergrund mit dem Pytorch Framework @noauthor_openai_nodate.
- Vorteile: Hat eine gute Community und eine ausführliche Dokumentation. Viele Features und viele Tutorials.
- Nachteile: Für Einsteiger 

==== ONNX<onnx>
ONNX (Open Neural Network Exchange) @noauthor_onnx_nodate ist ein generalisiertes Format von Deep-Learning Modellen. Dies ermöglicht den Austausch von Modellen zwischen verschiedenen Frameworks. ONNX wird von Microsoft, Amazon, Facebook und weiteren Partners als Open-Source Projekt entwickelt.
- Vorteile: Austauschformat, das Modelle zwischen verschiedenen Frameworks kompatibel macht. Optimierte Laufzeitumgebungen, die speziell für Edge-Geräte geeignet sind.
- Nachteile: Begrenzte Funktionalität für Modelltraining, primär für den Einsatz trainierter Modelle gedacht. Kleinere Community im Vergleich zu TensorFlow und PyTorch.

==== NCNN<ncnn>
NCNN @ni_ncnn_2017 ist eine high performance computing platform für mobile Endgeräte. Dieses Framework wird of auf Smartphone verwendet, weil es optimiert für Geräte mit beschränkter Rechenleistung ist.
- Vorteile: Schnelle Inferenzzeiten auf der CPU.
- Nachteile: Im Vergleich zu anderen Frameworks weniger ausführlich dokumentiert.

==== Hailo


==== Ultralytics
Das Ultralytics @ultralytics_home_nodate Framework ist ein auf PyTorch basierendes Open-Source-Framework, das vor allem für die Entwicklung von Modellen zur Objekterkennung bekannt ist. Es wurde durch die Implementierung von YOLOv5 (You Only Look Once) populär und bietet eine benutzerfreundliche Umgebung für das Training und die Bereitstellung von Objekterkennungsmodellen. Inzwischen sind neuere Implementierungen der YOLO Familie verfügbar und mit Ultralytics anwendbar.
- Vorteile: Die Verwendung des Framework ist sehr einfach und dadurch geeignet für Einsteiger. Modelle können in andere Formate exportiert werden. Inferenzen werden für PyTorch Modelle angeboten.
- Nachteile: Die Flexibilität im Vergleich zu anderen Frameworks ist eingeschränkt.


==== Trade-Off's
- Flexibilität vs. Spezialisierung: Frameworks wie TensorFlow und PyTorch bieten umfassende Funktionen, benötigen jedoch mehr Ressourcen. Edge-spezifische Frameworks sind dagegen ressourcenschonender, aber eingeschränkter in ihrer Funktionalität.
- Einsatzgebiet: Die Wahl des Frameworks sollte sich an den spezifischen Anforderungen orientieren, wie etwa der Zielplattform (Cloud vs. Edge), der Modellkomplexität und der Verfügbarkeit von Ressourcen.

=== Anatomie von Machine Learning Modellen
Ein Machine-Learning-Modell besteht aus einer Architektur, die dessen Aufbau und Funktionsweise definiert, und einem Satz von Parametern, die während des Trainings optimiert werden. Die Architektur eines Modells legt grundlegende Eigenschaften fest, wie die Struktur der Neuronen und Layer, die Verbindungen zwischen ihnen sowie Eingabe- und Ausgabetensoren. Die Eingabetensoren bestimmen, welche Form und Dimensionen die Daten haben müssen (z. B. die Größe von Bildern), während die Ausgabetensoren das Ergebnis des Modells beschreiben, etwa Klassenetiketten oder Koordinaten für erkannte Objekte.

Es gibt verschiedene Typen von Machine-Learning-Modellen, die je nach Anwendungsfall eingesetzt werden. Zu den wichtigsten gehören Modelle für Objekterkennung, die Objekte in einem Bild lokalisieren und klassifizieren, Bildsegmentierung, die jedem Pixel eines Bildes eine Klasse zuordnet, und Posenschätzung, die die Körperhaltung von Personen oder Tieren analysiert. Für die Objekterkennung werden verschiedene Metriken verwendet, um die Modellleistung zu bewerten. Dazu zählen die Intersection over Union (IoU), die angibt, wie gut vorhergesagte und tatsächliche Begrenzungsrahmen übereinstimmen, und die Mean Average Precision (mAP), die die Präzision über verschiedene Schwellenwerte hinweg aggregiert. Zusätzlich spielen Leistungskennzahlen wie die Inferenzzeit eine wichtige Rolle, insbesondere bei Echtzeitanwendungen.

Das Training eines Modells umfasst die Anpassung der Parameter auf Basis eines großen Datensatzes, um Muster und Zusammenhänge zu lernen. Dabei kommen Optimierungsalgorithmen wie Gradient Descent zum Einsatz, die das Modell iterativ verbessern. Nach dem Training wird das Modell in der Inferenzphase genutzt. Inferenz bezeichnet den Prozess, bei dem ein trainiertes Modell neue Eingaben verarbeitet und Vorhersagen generiert.


== Edge Computing
#TODO[
    (vllt auch in der AUsgangslage erwähnen)
    - Architektur (Shift von Cloud zu Edge)
    - Konsequenzen und Vorteile (Latenz, Kosten, Privacy)
    - Herausforderungen (Energie, Rechenleistung)
]
Edge Computing und Edge Machine Learning markieren einen Paradigmenwechsel in der Systemarchitektur, indem die Datenverarbeitung von zentralen Backend Server oder Cloud-Systemen hin zu Geräten am Rand des Netzwerks (Edge) verlagert wird. Diese Architektur ermöglicht es, Berechnungen und Analysen direkt vor Ort durchzuführen, anstatt die Daten für die Verarbeitung  zu versenden.

Dies bringt mehrere Vorteile mit sich. So ermöglicht die lokale Verarbeitung eine geringere Latenz, was vor allem für Echtzeitanwendungen entscheidend ist. Zudem reduziert sich der Datenverkehr zu einem Backend, was nicht nur die Betriebskosten senkt, sondern auch die Abhängigkeit von einer stabilen Internetverbindung minimiert. Nebst der Datenübertragung ist auch die Komplexität eines Systems von Bedeutung. Eine Systemarchitektur mit zentraler Einheit bedeutet nebst zusätzlichen Technologien auch einen erhöhten Wartungsaufwand, welcher gerade bei grosser Projektdauer nicht zu unterschätzen ist. Ein weiterer wesentlicher Vorteil liegt im Bereich der Datensicherheit. Sensible Informationen bleiben vor Ort und müssen nicht über Netzwerke übertragen werden, wodurch die Privatsphäre der Nutzer besser geschützt wird.

Allerdings bringt dieser Ansatz auch Herausforderungen mit sich. Edge-Geräte verfügen häufig über eingeschränkte Rechenleistung und Speicherressourcen, was die Ausführung komplexer Machine-Learning-Modelle erschweren kann. Darüber hinaus ist die Energieeffizienz ein zentraler Aspekt, da viele Edge-Geräte batteriebetrieben sind und die Optimierung des Energieverbrauchs entscheidend für den Betrieb sein kann. Schliesslich erfordert die Verwaltung und Skalierung einer Vielzahl von verteilten Geräten ohne zentrale Steuerung zusätzlichen Aufwand. 

=== Edge ML
#TODO[
    - Hardware die Edge Computing und ML vereint
        - Coral
        - hailo
        - ai camera
    - Pipelines / Datenfluss (herkömmlich, AI-Camera)
]
Edge Machine Learning kombiniert die Prinzipien des Edge Computing mit den Anforderungen moderner Machine-Learning-Modelle, indem die Rechenleistung direkt auf die Endgeräte verlagert wird. Dieser Ansatz wird durch spezialisierte Hardware ermöglicht, die darauf ausgelegt ist, ML-Modelle effizient und ressourcenschonend auszuführen.

Ein Beispiel für solche Hardware sind USB-Dongles wie der Coral USB Accelerator von Google, der eine dedizierte TPU (Tensor Processing Unit) enthält. Diese Geräte lassen sich leicht in bestehende Systeme integrieren und ermöglichen die schnelle Ausführung von ML-Algorithmen ohne signifikante Anpassungen der Infrastruktur. Für Anwendungen, die mehr Rechenleistung benötigen, gibt es leistungsstärkere Lösungen wie die Hailo-TPU, die über eine PCIe-Schnittstelle mit dem Edge-Gerät verbunden wird. Diese Hardware eignet sich für Szenarien mit komplexeren ML-Modellen, da sie eine deutlich höhere Verarbeitungsrate bietet.

Eine weitere Kategorie sind AI-Kameras, die mit integrierten ML-Chips ausgestattet sind. Diese Kameras können nicht nur Bilder aufnehmen, sondern auch direkt auf der Kamera Inferenzdaten bereitstellen, beispielsweise durch die Erkennung und Klassifikation von Objekten. Dieser Ansatz verlagert die intensiven Berechnungen womit der Edge Computer weniger Ressourcen bereitstellen muss.
