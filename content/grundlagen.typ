#import "/utils/todo.typ": TODO
#pagebreak()
#TODO[RPi5 mit 16GB wäre verfügbar]

= Grundlagen 
#TODO[
(Dinge die man auf wikipedia lesen kann, was ist schon hier, die Dinge, die ich nachher brauche)
]
Dieses Kapitel beschreibt den Theoretischen Inhalt dieser Arbeit. Um die späteren Analysen und Evaluationen verstehen zu können, werden die grundlegenden Konzepte, Technologien und Frameworks vorgestellt, die in diesem Projekt verwendet werden. Dazu gehören die Prinzipien des Machine Learnings, die Rolle von Edge Computing sowie die eingesetzten Hardware- und Softwarekomponenten. Ebenso werden relevante Metriken und Methoden erläutert, die zur Bewertung der entwickelten Systeme herangezogen werden.

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
  caption: [Erweiterte thematische Karte zum Lernen von Freiwilligen \
    (Quelle: The Science of Citizen Science, S.300)
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
  image("../figures/pollinator_cam.jpg", width: 50%),
  caption: [
    Pollinator Kamera im Feld\
    (Quelle: mitwelten.ch, aufgerufen am 23.01.2025)
],
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
Hailo, gegründet im Jahr 2017, hat sich als führendes Unternehmen im Bereich leistungsfähiger KI-Prozessoren für Edge-Anwendungen etabliert. Mit ihrer eigens entwickelten Hardware-Architektur verfolgt Hailo das Ziel, Machine Learning auch ausserhalb von Rechenzentren zugänglich und effizient nutzbar zu machen @noauthor_fuhrende_nodate. Die Nutzung der Hailo-Chips erfordert eine Konvertierung der Modelle, wofür das Unternehmen eine umfassende Software-Suite bereitstellt. Diese Suite enthält alle notwendigen Werkzeuge, um Modelle auf die spezifischen Anforderungen der Hailo-Hardware abzustimmen.

- Vorteil: Ermöglicht sehr schnelle Inferenzen und Hailo bietet eine gute Dokumentation und  ein grosses Ökosystem
- Nachteil: Eine Intensive Einarbeitung ist notwendig und der konvertierungsprozess erfordert Modulspezifisches Wissen


==== Ultralytics
Das Ultralytics @ultralytics_home_nodate Framework ist ein auf PyTorch basierendes Open-Source-Framework, das vor allem für die Entwicklung von Modellen zur Objekterkennung bekannt ist. Es wurde durch die Implementierung von YOLOv5 (You Only Look Once) populär und bietet eine benutzerfreundliche Umgebung für das Training und die Bereitstellung von Objekterkennungsmodellen. Inzwischen sind neuere Implementierungen der YOLO Familie verfügbar und mit Ultralytics anwendbar.
- Vorteile: Die Verwendung des Framework ist sehr einfach und dadurch geeignet für Einsteiger. Modelle können in andere Formate exportiert werden. Inferenzen werden für PyTorch Modelle angeboten.
- Nachteile: Die Flexibilität im Vergleich zu anderen Frameworks ist eingeschränkt.


==== Trade-Off's
- Flexibilität vs. Spezialisierung: Frameworks wie TensorFlow und PyTorch bieten umfassende Funktionen, benötigen jedoch mehr Ressourcen. Edge-spezifische Frameworks sind dagegen ressourcenschonender, aber eingeschränkter in ihrer Funktionalität.
- Einsatzgebiet: Die Wahl des Frameworks sollte sich an den spezifischen Anforderungen orientieren, wie etwa der Zielplattform (Cloud vs. Edge), der Modellkomplexität und der Verfügbarkeit von Ressourcen.

=== Anatomie von Machine Learning Modellen
Ein Machine-Learning-Modell besteht aus einer Architektur, die dessen Aufbau und Funktionsweise definiert, und einem Satz von Parametern, die während des Trainings optimiert werden. Die Architektur eines Modells legt grundlegende Eigenschaften fest, wie die Struktur der Neuronen und Layer, die Verbindungen zwischen ihnen sowie Eingabe- und Ausgabetensoren. Die Eingabetensoren bestimmen, welche Form und Dimensionen die Daten haben müssen (z. B. die Größe von Bildern), während die Ausgabetensoren das Ergebnis des Modells beschreiben, etwa Klassenetiketten oder Koordinaten für erkannte Objekte.

Es gibt verschiedene Typen von Machine-Learning-Modellen, die je nach Anwendungsfall eingesetzt werden. Zu den wichtigsten gehören Modelle für Objekterkennung, die Objekte in einem Bild lokalisieren und klassifizieren, Bildsegmentierung, die jedem Pixel eines Bildes eine Klasse zuordnet, und Posenschätzung, die die Körperhaltung von Personen oder Tieren analysiert. 
#figure(
    grid(
        columns: 4,
        grid.cell(
            colspan: 2,
            image("../figures/Classification.png", width: 100%),
        ),
        grid.cell(
            colspan: 2,
            image("../figures/ObjDet.png", width: 100%),
        ),
        grid.cell(
            colspan: 2,
            image("../figures/SemSeg.png", width: 100%),
        ),
        grid.cell(
            colspan: 2,
            image("../figures/PoseEst.png", width: 100%),
        ),
    ),
  caption: [Machine Learning Tasks \
    (Quelle: https://github.com/sony/model_optimization, aufgerufen am 20.01.2025)],
)<ml_tasks>

\
Für die Objekterkennung werden verschiedene Metriken verwendet, um die Modellleistung zu bewerten. Dazu zählen die Intersection over Union (IoU), die angibt, wie gut vorhergesagte und tatsächliche Direktionsfläche übereinstimmen, und die Mean Average Precision (mAP), die die Präzision über verschiedene Schwellenwerte hinweg aggregiert. Zusätzlich spielen Leistungskennzahlen wie die Inferenzzeit eine wichtige Rolle, insbesondere bei Echtzeitanwendungen.

Das Training eines Modells umfasst die Anpassung der Parameter auf Basis eines grossen Datensatzes, um Muster und Zusammenhänge zu lernen. Dabei kommen Optimierungsalgorithmen wie Gradient Descent zum Einsatz, die das Modell iterativ verbessern. Nach dem Training wird das Modell in der Inferenzphase genutzt. Inferenz bezeichnet den Prozess, bei dem ein trainiertes Modell neue Eingaben verarbeitet und Vorhersagen generiert.

=== Geschwindigkeit einer Inferenz

Die Dauer einer Inferenz hängt massgeblich von den Berechnungen des Modells und der Leistungsfähigkeit des Systems ab, auf dem sie ausgeführt wird. Die benötigte Anzahl an Berechnungen wird durch die Neuronenanzahl im neuronalen Netz bestimmt. Mit zunehmender Anzahl an Neuronen – sei es durch mehr oder grössere Hidden Layers – steigt der Rechenaufwand. Die @neuronal_net illustriert den symbolischen Aufbau eines neuronalen Netzes mit drei Hidden Layers. Ein Netz mit mehr als einem Hidden Layer wird als "Deep Neural Network" bezeichnet.

#figure( image("../figures/deepLearn.png", width: 100%), 
    caption: [Symbolbild Neuronales Netzwerk \
    (Quelle: lamarr-institute.org/blog/deep-neural-networks, abgerufen am 23.01.2025)]
)<neuronal_net>

Je mehr Hidden Layers und trainierte Gewichte ein Modell besitzt, desto präziser werden seine Vorhersagen. Allerdings steigt damit auch der Rechenaufwand. Aus diesem Grund existieren YOLO-Modelle, wie sie in dieser Arbeit verwendet wurden, in verschiedenen Größen @ultralytics_yolov5_nodate.

Ein weiterer entscheidender Faktor ist die Hardware, auf der die Berechnungen durchgeführt werden. Durch das Parallelisieren von Berechnungen lassen sich erhebliche Geschwindigkeitsvorteile erzielen. Besonders geeignet sind GPUs (Graphics Processing Units), TPUs (Tensor Processing Units) und NPUs (Neural Processing Units). Da die Berechnungen in neuronalen Netzen denen in der Bildverarbeitung ähneln, sind diese Hardwarelösungen sowohl für das Training als auch für die Anwendung von ML-Modellen optimal.

TPUs, von Google für das TensorFlow-Framework entwickelt @noauthor_tpu_nodate, sind speziell für die benötigten Matrixoperationen optimiert. Ebenso wurde die NPU @noauthor_what_2024 entwickelt, um ML-Tasks hochgradig parallelisiert und effizient auszuführen. In bestimmten Szenarien kann eine NPU eine GPU in Sachen Geschwindigkeit deutlich übertreffen @noauthor_npu_2024.


== Edge Computing
#TODO[ (vllt auch in der AUsgangslage erwähnen) ]
Edge Computing und Edge Machine Learning markieren einen Paradigmenwechsel in der Systemarchitektur, indem die Datenverarbeitung von zentralen Backend Server oder Cloud-Systemen hin zu Geräten am Rand des Netzwerks (Edge) verlagert wird. Diese Architektur ermöglicht es, Berechnungen und Analysen direkt vor Ort durchzuführen, anstatt die Daten für die Verarbeitung  zu versenden.

Dies bringt mehrere Vorteile mit sich. So ermöglicht die lokale Verarbeitung eine geringere Latenz, was vor allem für Echtzeitanwendungen entscheidend ist. Zudem reduziert sich der Datenverkehr zu einem Backend, was nicht nur die Betriebskosten senkt, sondern auch die Abhängigkeit von einer stabilen Internetverbindung minimiert. Nebst der Datenübertragung ist auch die Komplexität eines Systems von Bedeutung. Eine Systemarchitektur mit zentraler Einheit bedeutet nebst zusätzlichen Technologien auch einen erhöhten Wartungsaufwand, welcher gerade bei grosser Projektdauer nicht zu unterschätzen ist. Ein weiterer wesentlicher Vorteil liegt im Bereich der Datensicherheit. Sensible Informationen bleiben vor Ort und müssen nicht über Netzwerke übertragen werden, wodurch die Privatsphäre der Nutzer besser geschützt wird.

Allerdings bringt dieser Ansatz auch Herausforderungen mit sich. Edge-Geräte verfügen häufig über eingeschränkte Rechenleistung und Speicherressourcen, was die Ausführung komplexer Machine-Learning-Modelle erschweren kann. Darüber hinaus ist die Energieeffizienz ein zentraler Aspekt, da viele Edge-Geräte batteriebetrieben sind und die Optimierung des Energieverbrauchs entscheidend für den Betrieb sein kann. Schliesslich erfordert die Verwaltung und Skalierung einer Vielzahl von verteilten Geräten ohne zentrale Steuerung zusätzlichen Aufwand. 

=== Edge ML
Edge Machine Learning kombiniert die Prinzipien des Edge Computing mit den Anforderungen moderner Machine-Learning-Modelle, indem die Rechenleistung direkt auf die Endgeräte verlagert wird. Dieser Ansatz wird entweder auf der CPU ausgeführt oder durch spezialisierte Hardware beschleunigt. Diese ist darauf ausgelegt, ML-Modelle performant, effizient und ressourcenschonend auszuführen. Beschleuniger Hardware ist dann erforderlich, wenn die Inferenz auf der CPU zu viel Zeit oder Ressourcen in Anspruch nimmt. Diese Hardware wird typischerweise mit einem Host System verbunden, welches mit der Beschleuniger Hardware kommunizieren kann.

Die Weiterentwicklung der kompakten Computer sowie die auf ML spezialiserte Hardware öffnet neue Möglichkeiten im Bereich des Edge ML.
Zum Zeitpunkt dieser Arbeit sind die Entwicklungen im vollen Gange. Nicht nur auf Seite der Hardware, sondern auch im Umfeld des Machine Learning wird zur Zeit geforscht und entwickelt. Somit kann in diesem Projekt unter Anderem neuste Hardware eingesetzt werden, welche sich in der Industrie möglicherweise erst in der kommenden Zeit etablieren wird. Die im Projekt eingesetze Hardware ist im folgenden aufgeführt.

=== Host Systeme
Der einfachste Weg Machine Learning im Bereich Edge zu betreiben ist die CPU eines Edge Computers. Um Erfahrungen zu sammeln sind verschiedene Einplatinen Computer evaluiert worden. Hauptsächlich hat sich die Verwendung von Raspberry Pi Computer durchgesetzt. Sie weisen ein gutes Preis Leistungsverhältnis auf und sind durch Dokumentation und Community extrem gut unterstütz.

==== Raspberry Pi 4
Das Raspberry Pi 4 8 GB ist für rund 85Fr. @noauthor_raspberry_nodate-3 erhältlich. Mit einer CPU Taktfrequenz von 1.5GHz lassen sich schon viele Anwendungen realisieren. Nachteil des Model 4 ist, dass keine PCI Schnittstelle vorhanden ist.

#figure(
  image("../figures/rpi4.png", width: 40%),
  caption: [
    Raspberry Pi 4 \
    (Quelle: https://www.pi-shop.ch/raspberry-pi-4-model-b-4gb, aufgerufen am 23.01.2025)
],
)

==== Raspberry Pi 5
Das Raspberry Pi 5 stellt den Nachfolger vom Model 4 dar und ist mit 8 GB RAM und einer CPU Taktfrequenz von 2.4GHz ausgerüstet. Ebenso ist eine PCI Schnittstelle verfügbar, wodurch das anschliessen von leistungsstarker Beschleuniger Hardware möglich wird. Dieses Setup ist für ca. 85 Fr. @noauthor_raspberry_nodate-4 Erhältlich.

#figure(
  image("../figures/rpi5.png", width: 40%),
  caption: [
    Raspberry Pi 5 \
    (Quelle: https://www.pi-shop.ch/raspberry-pi-5-16gb-ram?src=raspberrypi, aufgerufen am 23.01.2025)
],
)

==== BeagleY-AI
Das BeagleY-AI Board hat eine CPU Taktfrequenz von 1.5GHz und 4 GB RAM. Das besondere an diesem Board ist der integrierte AI Accelerator mit 4 TOPS (Terra Operation per Second). Das Board ist für run 70 Fr. @noauthor_beagley-ai_nodate Erhältlich. 

#figure(
  image("../figures/beagle.png", width: 40%),
  caption: [BeagleY-AI Board\
    (Quelle: https://www.seeedstudio.com/BeagleYr-AI-beagleboard-orgr-4-TOPS-AI-Acceleration-powered-by-TI-AM67A.html, aufgerufen am 23.01.2025)
],
)

=== Hardware Beschleuniger
Machine-Learning-Beschleuniger sind spezialisierte Hardwarekomponenten, die entwickelt wurden, um die Ausführung von Machine-Learning-Modellen zu optimieren. Sie sind insbesondere für rechenintensive Aufgaben wie Matrixmultiplikationen und Tensorberechnungen ausgelegt, die in vielen ML-Algorithmen eine zentrale Rolle spielen. Zu den bekanntesten Typen solcher Beschleuniger gehören GPUs (Graphics Processing Units) und TPUs (Tensor Processing Units).

Eine GPU wurde ursprünglich für die Verarbeitung von Grafikanwendungen entwickelt, hat sich jedoch aufgrund ihrer Fähigkeit zur parallelen Verarbeitung tausender Operationen gleichzeitig als ideal für Machine-Learning-Aufgaben erwiesen. GPUs kommen häufig bei grossen Modellen und im Training von neuronalen Netzwerken zum Einsatz, da sie eine hohe Rechenleistung bieten.

Eine TPU ist ein speziell entwickelter Prozessor, der ausschliesslich für Machine-Learning-Workloads optimiert wurde. Sie wurde von Google entwickelt und ist besonders effizient bei der Verarbeitung von Tensoroperationen, wie sie in Frameworks wie TensorFlow genutzt werden. TPU's unterscheiden sich von GPUs durch ihre Fokussierung auf deterministische Operationen, die typischerweise in ML-Modellen vorkommen, was sie besonders leistungsstark und energieeffizient macht. TPU's sind für das Training und die Inferenz geeignet, wobei sie bei letzterem aufgrund ihrer geringen Latenz und Effizienz eine herausragende Rolle spielen.

==== Coral USB Accelerator
Der USB-Dongle von Google, Coral USB Accelerator, hat eine dedizierte TPU (Tensor Processing Unit). Solche Geräte lassen sich leicht in bestehende Systeme integrieren und ermöglichen die schnelle Ausführung von ML-Algorithmen ohne signifikante Anpassungen der Infrastruktur. Der Preis bewegt sich um 89.90Fr.@noauthor_coral_nodate.  

#figure(
  image("../figures/coral_usb_accel.png", width: 30%),
  caption: [Coral USB Accelerator \
(Quelle: https://www.coral.ai/products/accelerator, aufgerufen am 22.01.2025)],
)

==== Coral PCI Accelerator
Nebst den USB-Dongles stellt Google auch über die PCI Schnittstelle angeschlossene Beschleuniger her. Diese sind als single oder dual TPU erhältlich. Der Preis für die signle Lösung mit 4TOPS liegt bei 47.90Fr. @noauthor_pineboards_nodate, für die dual Lösung mit 8 TOPS bezahlt man 96.90 Fr.@noauthor_pineboards_nodate-1.

#figure(
  image("../figures/coral_M2_accel.png", width: 40%),
  caption: [Coral PCI Accelerator\
 (Quelle: https://www.coral.ai/products/m2-accelerator-dual-edgetpu, aufgerufen am 22.01.2025)],
)

==== Hailo TPU
Hailo ist eine Firma die sich auf Edge-KI Prozessoren spezialisiert hat. Diese sind moderner als die Lösungen von Google und erreichen eine höhere Leistungsfähigkeit. Die in diesem Projekt verwendeten Beschleuniger haben 13 und 26 TOPS zu 79.90 Fr.@noauthor_raspberry_nodate-1 resp. zu 122.90 Fr.@noauthor_raspberry_nodate. Die folgende Abbildung zeigt ein Hailo Brschleuniger auf einem Raspberry Pi @hailo_on_rpi5.

#figure(
    image("../figures/hailo_accel.png", width: 40%),
    caption: [Hailo Accelerator \
    (Quelle: https://www.pi-shop.ch/raspberry-pi-ai-hat-13t, aufgerufen am 22.01.2025)
],
)<hailo_on_rpi5>

==== AI-Kamera
Eine weitere Kategorie sind AI-Kameras, die mit integrierten ML-Chips ausgestattet sind. Diese Kameras, wie auf @ai_cam dargestellt, können nicht nur Bilder aufnehmen, sondern auch direkt auf der Kamera Inferenzdaten bereitstellen, beispielsweise durch die Erkennung und Klassifikation von Objekten. Raspberry Pi stellt eine solche Kamera zur Verfügung für 77.90 Fr. @noauthor_raspberry_nodate-2.

#figure(
    image("../figures/ai_camera.png", width: 30%),
    caption: [
    Raspberry Pi AI Camera \
    (Quelle: https://www.berrybase.ch/raspberry-pi-ai-camera, aufgerufen am 22.01.25)
]
)<ai_cam>

Dieser Ansatz verlagert die intensiven Berechnungen womit der Edge Computer weniger Ressourcen bereitstellen muss. Die @ai_cam_arch verdeutlicht, wie die Architektur eines solchen Systems aufgebaut ist. Die linke Seite zeigt den Aufbau herkömmlicher Kamera Architekturen, während rechts die Lösung mittels AI Accelerator dargestellt ist.

#figure(
  image("../figures/ai_camera_arch.png", width: 90%),
  caption: [Raspberry Pi AI Camera Architektur\
(Quelle: https://www.raspberrypi.com/documentation/accessories/ai-camera.html, aufgerufen am 20.01.2025)],
)<ai_cam_arch>

Beim Sensor handelt es sich um einen Sony IMX500 Chip @noauthor_ai_nodate-1, welcher ein Bild aufnehmen kann. Die Daten gelangen dann als RAW-Image zum ISP, einem kleinen Image Signal Processor. Dieser wandelt das RAW-Image zu einem Input Tensor, welcher vom AI-Accelerator als Input Grösse entgegen genommen wird. Nach durchführen der Inferenz gelangen die Resultate, in diesem Fall der Output Tensor zum Processor des Host Systems. Gleichzeitig gelangt auch das Image auf das Host-System, um wenn nötig die Resultate anzuzeigen oder weiterverarbeitet zu werden. Die Bilder können wahlweise mit 10 FPS bei einer Auflösung von 4056x3040 oder bei 30 FPS mit 2028x1520 aufgenommen werden.
