#import "/utils/todo.typ": TODO
#pagebreak()

= Grundlagen 
Dieses Kapitel beschreibt den theoretischen Inhalt dieser Arbeit. Um die späteren Analysen und Evaluationen verstehen zu können, werden die grundlegenden Konzepte, Technologien und Frameworks vorgestellt, die in diesem Projekt zum Einsatz kommen. Dazu gehören die Prinzipien des Machine Learnings, die Rolle von Edge Computing sowie die eingesetzten Hardware- und Softwarekomponenten.

== Citizen Science
Das grundlegende Ziel dieser Arbeit ist die Entwicklung eines Systems, welches im Bereich von Citizen Science eingesetzt werden kann. Daher soll als erstes der Begriff erläutert werden.
Eine treffende Definition von Citizen Science liefert das Grünbuch Citizen Science Strategie 2020 für Deutschland:
#set quote(block: true)
#show quote: set align(center)
#show quote: set pad(x: 5em)

#quote(attribution: <bonn_grunbuch_2016>)[„Citizen Science beschreibt die Beteiligung von Personen an wissenschaftlichen Prozessen, die nicht in diesem Wissenschaftsbereich institutionell gebunden sind. Dabei kann die Beteiligung in der kurzzeitigen Erhebung von Daten bis hin zu einem intensiven Einsatz von Freizeit bestehen, um sich gemeinsam mit Wissenschaftlerinnen bzw. Wissenschaftlern und/oder anderen Ehrenamtlichen in ein Forschungsthema zu vertiefen. Obwohl viele ehrenamtliche Forscherinnen und Forscher eine akademische Ausbildung aufweisen, ist dies keine Voraussetzung für die Teilnahme an Forschungsprojekten. Wichtig ist allerdings die Einhaltung wissenschaftlicher Standards, wozu vor allem Transparenz im Hinblick auf die Methodik der Datenerhebung und die öffentliche Diskussion der Ergebnisse gehören.“
]

Bürgerinnen und Bürger können also einen Beitrag zur Wissenschaft leisten, indem sie Daten sammeln, analysieren und interpretieren. Dies kann von der einfachen Datenerhebung bis hin zur intensiven Auseinandersetzung mit einem Forschungsthema reichen. Die Beteiligung an Citizen Science Projekten ist nicht an eine akademische Ausbildung gebunden, jedoch ist die Einhaltung wissenschaftlicher Standards unabdingbar.
Es stellt sich die Frage, worin die Motivation liegt, sich freiwillig solchen Projekten zu widmen. Ein treibender Faktor ist meistens der Wissenszuwachs für ein bestimmtes Thema. Die Auseinandersetzung in einem Bereich, für den man sich interessiert.
Das Buch The Science of Citizen Science @vohland_science_2021[p~283] diskutiert die verschiedenen Aspekte des Lernens in einem Citizen Science Projekt. 

#figure(
  image("../figures/citizen_science_learning_map.png", width: 90%),
  caption: [Erweiterte thematische Karte zum Lernen von Freiwilligen \
    (Quelle: The Science of Citizen Science, S.300)
  ],
)

Aus der Illustration geht hervor, dass verschiedenste Aspekte die Bürgerinnen und Bürger zu einer aktiven Beteiligung motivieren können. Neben den fachlichen sind auch soziale Themen von Bedeutung. 

Auf der anderen Seite profitieren auch die Projektinitianten. Die Organisation und Zusammenarbeit mit Aussenstehenden kann eine spannende Aufgabe sein. Es stellt die Projektverantwortlichen vor neue Herausforderungen, die Freiwilligen motivierend in das Projekt miteinzubeziehen. Ein Grundstein dieser Angelegenheit ist die Zugänglichkeit zu Projektinstrumenten. In Bezug auf ein Projekt mit Edge-ML kann es besonders wichtig sein, dass die Freiwilligen verstehen, wie das Setup und die damit verbundene Technik funktionieren und somit Faszination entfachen können. Aus diesem Grund ist es von besonderer Bedeutung, die technischen Hürden möglichst niedrig zu halten und die notwendigen fachlichen Kenntnisse zu minimieren.


== Machine Learning Grundlagen

=== Frameworks
Ein Machine-Learning-Framework, kurz ML-Framework, bildet die Grundlage für die Entwicklung, das Training und die Bereitstellung von Modellen. Es bietet Werkzeuge und Bibliotheken, die den gesamten ML-Workflow unterstützen. Im Gegensatz dazu ist ein Machine-Learning-Modell das konkrete Ergebnis des Trainingsprozesses, das spezifische Aufgaben wie Klassifikation oder Objekterkennung ausführt. Wird ein Modell nach dem Training benutzt, um zum Beispiel Objekte zu erkennen, spricht man von Inferenz. Dies beschreibt den Prozess der Ausführung des Modells auf ungesehenen Daten.

Das Training sowie die Inferenz eines Modells können mit unterschiedlichen Frameworks vollzogen werden. Jedes Framework hat ihr eigenes Modellformat. So lassen sich beispielsweise PyTorch-Modelle nicht ohne Weiteres mit TensorFlow ausführen. Folgend sind diejenigen vorgestellt, welche in dieser Arbeit zum Einsatz kamen.

==== TensorFlow
TensorFlow @noauthor_tensorflow_nodate wurde ursprünglich von Google entwickelt und ist inzwischen ein Open Source Projekt. Das Framework ist eher für Systeme in Produktion gedacht.
- Vorteile: Weit verbreitet mit grosser Community und umfangreicher Dokumentation. Stellt viele Features zur Verfügung.
- Nachteile: Steile Lernkurve, insbesondere für Einsteiger. Komplex durch die vielen Features.

==== TensorFlow Lite
Stellt die für Edge-Devices optimierte Variante des TensorFlow-Frameworks dar.
- Vorteile: Speziell für den Betrieb auf ressourcenbeschränkten Geräten optimiert. Reduzierte Speicher- und Rechenanforderungen für Echtzeitanwendungen.
- Nachteile: Eine Kompression ist für die Ausführung erforderlich.

==== PyTorch
PyTorch @noauthor_pytorch_nodate ist ein Open-Source Framework und hat seinen Ursprung im Forschungsteam für künstliche Intelligenz von Facebook. Das Framework eignet sich für Experimente, kann aber auch für Systeme in Produktion eingesetzt werden. ChatGPT von OpenAI arbeitet beispielsweise im Hintergrund mit dem Pytorch-Framework @noauthor_openai_nodate.

- Vorteile: Hat eine gute Community und eine ausführliche Dokumentation. Beinhaltet auch viele Features und Tutorials.

- Nachteile: Steile Lernkurve, insbesondere für Einsteiger.

==== ONNX<onnx>
ONNX (Open Neural Network Exchange) @noauthor_onnx_nodate ist ein generalisiertes Format von Deep-Learning Modellen. Dies ermöglicht den Austausch von Modellen zwischen verschiedenen Frameworks. ONNX wurde ursprünglich von Facebook und Microsoft entwickelt. Zurzeit wird das Framework von mehreren Partnern als Open-Source Projekt weiterentwickelt.

- Vorteile: Austauschformat, das Modelle zwischen verschiedenen Frameworks kompatibel macht. Optimierte Laufzeitumgebungen, die speziell für Ausführungen auf der CPU geeignet sind.

- Nachteile: Begrenzte Funktionalität für Modelltraining, primär für den Einsatz trainierter Modelle gedacht. Kleinere Community im Vergleich zu TensorFlow und PyTorch.

Eine Spezialität des ONNX-Frameworks ist die Fähigkeit, Modelle von anderen Formaten in das ONNX-Format zu konvertieren. Ebenso lassen sich ONNX-Modelle wieder in andere Formate exportieren. Dies führt dazu, dass ONNX als eine Art Drehscheibe zwischen den verschiedenen Frameworks fungiert @ultralytics_onnx_nodate wie auf @onnx_model_convertion dargestellt.


#figure(
  image("../figures/onnx_model_convertion.png", width: 50%),
  caption: [ \
    (Quelle: https://docs.ultralytics.com/integrations/onnx/, aufgerufen am 02.02.2025)
  ],
)<onnx_model_convertion>

==== NCNN<ncnn>
NCNN @ni_ncnn_2017 ist eine high performance computing platform für mobile Endgeräte. Dieses Framework wird oft auf Smartphones verwendet, weil es optimiert für Geräte mit beschränkter Rechenleistung ist.
- Vorteile: Schnelle Inferenzzeiten auf der CPU.
- Nachteile: Im Vergleich zu anderen Frameworks weniger ausführlich dokumentiert.

==== Hailo
Hailo, gegründet im Jahr 2017, hat sich als führendes Unternehmen im Bereich leistungsfähiger KI-Prozessoren für Edge-Anwendungen etabliert. Mit ihrer eigens entwickelten Hardware-Architektur verfolgt Hailo das Ziel, Machine Learning auch ausserhalb von Rechenzentren zugänglich und effizient nutzbar zu machen @noauthor_fuhrende_nodate. Die Nutzung der Hailo-Chips erfordert eine Konvertierung der Modelle, wofür das Unternehmen eine umfassende Software-Suite bereitstellt. Diese Suite enthält alle notwendigen Werkzeuge, um Modelle auf die spezifischen Anforderungen der Hailo-Hardware abzustimmen.
- Vorteile: Ermöglicht sehr schnelle Inferenzen. Hailo bietet eine gute Dokumentation und ein grosses Ökosystem.
- Nachteile: Eine intensive Einarbeitung ist notwendig und der Konvertierungsprozess erfordert modellspezifisches Wissen.

==== Ultralytics
Ultralytics @ultralytics_home_nodate ist ein auf PyTorch basierendes Open-Source-Framework, das vor allem für die Entwicklung von Modellen zur Objekterkennung bekannt ist. Es wurde durch die Implementierung von YOLOv5 (You Only Look Once) populär und bietet eine benutzerfreundliche Umgebung für das Training und die Bereitstellung von Objekterkennungsmodellen. Inzwischen sind neuere Implementierungen der YOLO-Familie verfügbar und mit Ultralytics anwendbar.
- Vorteile: Die Verwendung des Frameworks ist sehr einfach und dadurch geeignet für Einsteiger. Modelle können in andere Formate exportiert werden. Inferenzen werden für PyTorch-Modelle angeboten.
- Nachteile: Die Flexibilität ist im Vergleich zu anderen Frameworks eingeschränkt. Zudem verwendet Ultralytics eine AGPL-3.0-Lizenz, was bei der Open-Source Community nicht gut ankommt.

=== Anatomie von Machine Learning Modellen
Ein Machine-Learning-Modell besteht aus einer Architektur, die dessen Aufbau und Funktionsweise definiert, und einem Satz von Parametern, die während des Trainings optimiert werden. Die Architektur eines Modells legt grundlegende Eigenschaften fest, wie die Struktur der Neuronen und Layer, die Verbindungen zwischen ihnen sowie Eingabe- und Ausgabetensoren. Die Eingabetensoren bestimmen, welche Form und Dimensionen die Daten haben müssen (z. B. die Grösse von Bildern), während die Ausgabetensoren das Ergebnis des Modells beschreiben, etwa Koordinaten für erkannte Objekte.

Es gibt verschiedene Typen von Machine-Learning-Modellen, die je nach Anwendungsfall eingesetzt werden. Zu den wichtigsten gehören Modelle für Objekterkennung, die Objekte in einem Bild lokalisieren und klassifizieren, Bildsegmentierung, die jedem Pixel eines Bildes eine Klasse zuordnet, und Posenschätzung, die die Körperhaltung von Personen oder Tieren analysiert. Die folgende @ml_tasks zeigt eine Visualisierung der verschiedenen Disziplinen.
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
Diese Arbeit konzentriert sich auf die Objekterkennung, sodass alle folgenden Erwähnungen von Machine Learning in diesem Kontext zu verstehen sind.
Für die Objekterkennung werden verschiedene Metriken verwendet, um die Modellleistung zu bewerten. Dazu zählen die Intersection over Union (IoU), die angibt, wie gut vorhergesagte und tatsächliche Detektionsfläche übereinstimmen, und die Mean Average Precision (mAP), die die Präzision über verschiedene Schwellenwerte hinweg aggregiert. Zusätzlich spielen Leistungskennzahlen wie die Inferenzzeit eine wichtige Rolle, insbesondere bei Echtzeitanwendungen.

Das Training eines Modells umfasst die Anpassung der Parameter auf Basis eines grossen Datensatzes, um Muster und Zusammenhänge zu lernen. Diese Art des Trainings wird in der Fachsprache Supervised Learning genannt. Dabei kommen Optimierungsalgorithmen wie Gradient Descent zum Einsatz, die das Modell iterativ verbessern. Nach dem Training wird das Modell in der Inferenzphase genutzt.

Ein Modell hat definierte Input und Output Tensoren. Das heisst, dass die Daten für das Training und die Inferenz dem Input Tensor entsprechen müssen. Diesen Vorgang nennt man preprocessing. Arbeitet das Modell mit Bildern beinhaltet dieser Schritt das modifizieren des Bildes auf die Input Grösse des Modells. Ebenso variiert der Output Tensor je nach Modell und Framework. Die Output Daten im Falle von Object Detection beschreiben dabei den Ort des Objekts und die Confidence, also wie sicher sich das Modell ist, dass dieses Objekt zu einer bestimmten Klasse gehört. 
Je nach Datenformat müssen die Ergebnisse konvertiert und nach Bedarf der Anwendung unter Berücksichtigung des Preprocessing auf das Originalbild zurückgerechnet werden. Dieser Prozess wird als Postprocessing bezeichnet.

=== Geschwindigkeit einer Inferenz

Die Dauer einer Inferenz hängt massgeblich von den Berechnungen des Modells und der Leistungsfähigkeit des Systems ab, auf dem sie ausgeführt wird. Die benötigte Anzahl an Berechnungen wird durch die Neuronenanzahl im neuronalen Netz bestimmt. Mit zunehmender Anzahl an Neuronen – sei es durch mehr oder grössere Hidden Layers – steigt der Rechenaufwand. Die @neuronal_net illustriert den symbolischen Aufbau eines neuronalen Netzes mit drei Hidden Layers. Ein Netz mit mehr als einem Hidden Layer wird als "Deep Neural Network" bezeichnet.

#figure( image("../figures/deepLearn.png", width: 100%), 
    caption: [Symbolbild neuronales Netzwerk \
    (Quelle: lamarr-institute.org/blog/deep-neural-networks, abgerufen am 23.01.2025)]
)<neuronal_net>

Je mehr Hidden Layers und trainierte Gewichte ein Modell besitzt, desto präziser werden seine Vorhersagen. Allerdings steigt damit auch der Rechenaufwand. Aus diesem Grund existieren Yolo-Modelle in verschiedenen Dimensionen, resp. Grössen @ultralytics_yolov5_nodate.

Ein weiterer entscheidender Faktor ist die Hardware, auf der die Berechnungen durchgeführt werden. Durch das Parallelisieren von Berechnungen lassen sich erhebliche Geschwindigkeitsvorteile erzielen. Besonders geeignet sind GPUs (Graphics Processing Unit), TPUs (Tensor Processing Unit) und NPUs (Neural Processing Unit). Diese Komponenten werden in @hw_accel näher beschrieben. 

Während auf eine GPU grundsätzlich keine Vorbedingungen an das Modell gestellt werden, ist dies bei der TPU und NPU durchaus notwendig. Dabei spielen zwei Strategien eine wichtige Rolle: Quantisieren und Pruning @noauthor_sparsification_nodate. Beim Quantisieren werden die Fliesskommazahlen der Gewichte zu Ganzzahlen konvertiert, wodurch die Präzision abnimmt. Die reduziert den Speicherbedarf und ermöglicht eine schnellere Ausführung, weil weniger Rechenoperationen nötig sind. Beim Pruning werden unwesentliche Verbindungen im Modellnetz entfernt, wodurch sich wiederum die Anzahl der Rechenoperationen reduziert. Die Ansätze werden auch kombiniert angewendet.

== Edge Computing
Edge Computing und Edge Machine Learning markieren einen Paradigmenwechsel in der Systemarchitektur, indem die Datenverarbeitung von zentralen Backend-Servern oder Cloud-Systemen hin zu Geräten am Rand des Netzwerks (Edge) verlagert wird. Diese Architektur ermöglicht es, Berechnungen und Analysen direkt vor Ort durchzuführen, anstatt die Daten für die Verarbeitung zu versenden.

Dies bringt mehrere Vorteile mit sich. So ermöglicht die lokale Verarbeitung eine geringere Latenz, was vor allem für Echtzeitanwendungen entscheidend ist. Zudem reduziert sich der Datenverkehr zu einem Backend, was nicht nur die Betriebskosten senkt, sondern auch die Abhängigkeit von einer stabilen Internetverbindung minimiert. Neben der Datenübertragung ist auch die Komplexität eines Systems von Bedeutung. Eine Systemarchitektur mit zentraler Einheit bedeutet nebst zusätzlichen Technologien auch einen erhöhten Wartungsaufwand, welcher gerade bei langer Projektdauer nicht zu unterschätzen ist. Ein weiterer wesentlicher Vorteil liegt im Bereich der Datensicherheit. Sensible Informationen bleiben vor Ort und müssen nicht über Netzwerke übertragen werden, wodurch die Privatsphäre der Nutzer besser geschützt wird.

Allerdings bringt dieser Ansatz auch Herausforderungen mit sich. Edge-Geräte verfügen häufig über eingeschränkte Rechenleistung und Speicherressourcen, was die Ausführung komplexer Machine-Learning-Modelle erschweren kann. Darüber hinaus ist die Energieeffizienz ein zentraler Aspekt, da viele Edge-Geräte batteriebetrieben sind und die Optimierung des Energieverbrauchs entscheidend für den Betrieb sein kann. Schliesslich kann die Verwaltung und Skalierung einer Vielzahl von verteilten Geräten ohne zentrale Steuerung zusätzlichen Aufwand erfordern.

=== Edge Intelligence
Edge Intelligence kombiniert die Prinzipien des Edge Computing mit den Anforderungen moderner Machine-Learning-Algorithmen, indem die Rechenleistung direkt auf die Endgeräte verlagert wird. Man spricht in diesem Falle auch von AI on Edge @deng_edge_2020. Diese Algorithmen werden entweder auf der CPU ausgeführt oder durch spezialisierte Hardware beschleunigt. Diese ist darauf ausgelegt, Machine Learning Tasks performant, effizient und ressourcenschonend auszuführen. Beschleuniger-Hardware ist dann erforderlich, wenn die Inferenz auf der CPU zu viel Zeit oder Ressourcen in Anspruch nimmt. Diese Hardware wird typischerweise mit einem Host-System verbunden, welches mit der Beschleuniger-Hardware kommunizieren kann.

Die Weiterentwicklung der kompakten Computer (Edge-Device) sowie die auf ML spezialisierte Hardware öffnet neue Möglichkeiten im Bereich des Edge-Computing.

Zum Zeitpunkt dieser Arbeit sind die Entwicklungen im vollen Gange. Nicht nur auf der Seite der Hardware, sondern auch im Umfeld des Machine Learning wird zurzeit erforscht und entwickelt. Somit kann in diesem Projekt unter anderem neueste Hardware eingesetzt werden, welche sich in der Industrie möglicherweise erst in der kommenden Zeit etablieren wird. Die im Projekt eingesetzte Hardware ist im Folgenden aufgeführt.

=== Hostsysteme
Der einfachste Weg, Machine Learning im Bereich Edge zu betreiben, ist die CPU eines Edge-Computers. Um Erfahrungen zu sammeln, sind verschiedene Einplatinencomputer evaluiert worden. Hauptsächlich hat sich die Verwendung von Raspberry Pi Computer durchgesetzt. Sie weisen ein gutes Preis-Leistungs-Verhältnis auf und sind durch Dokumentation und Community extrem gut unterstützt.

==== Raspberry Pi 4
Das Raspberry Pi 4 8 GB ist für rund 85 Fr. @noauthor_raspberry_nodate-3 erhältlich. Mit einer CPU-Taktfrequenz von 1,5 GHz lassen sich schon viele Anwendungen realisieren. Nachteil des Modells 4 ist, dass keine PCI-Schnittstelle vorhanden ist.

==== Raspberry Pi 5
Das Raspberry Pi 5 stellt den Nachfolger vom Model 4 dar und ist mit 8 GB RAM und einer CPU-Taktfrequenz von 2,4 GHz ausgerüstet. Ebenso ist eine PCI-Schnittstelle verfügbar, wodurch das anschliessen von leistungsstarker Beschleuniger-Hardware möglich wird. Dieses Setup ist für ca. 86 Fr. @noauthor_raspberry_nodate-4 erhältlich.

#figure(
  image("../figures/rpi5.png", width: 40%),
  caption: [
    Raspberry Pi 5 \
    (Quelle: https://www.pi-shop.ch/raspberry-pi-5-16gb-ram?src=raspberrypi, aufgerufen am 23.01.2025)
],
)

==== BeagleY-AI
Das BeagleY-AI Board hat eine CPU-Taktfrequenz von 1,5 GHz und 4 GB RAM. Das Besondere an diesem Board ist der integrierte AI-Accelerator mit 4 TOPS (Terra Operations per Second). Das Board ist für run 70 Fr. @noauthor_beagley-ai_nodate erhältlich. 

=== Hardware-Beschleuniger <hw_accel>
Machine-Learning-Beschleuniger sind spezialisierte Hardwarekomponenten, die entwickelt wurden, um die Ausführung von Machine-Learning-Modellen zu optimieren. Sie sind insbesondere für rechenintensive Aufgaben wie Matrixmultiplikationen und Tensorberechnungen ausgelegt, die in vielen ML-Algorithmen eine zentrale Rolle spielen. 

Eine GPU wurde ursprünglich für die Verarbeitung von Grafikanwendungen entwickelt, hat sich jedoch aufgrund ihrer Fähigkeit zur parallelen Verarbeitung von Operationen gleichzeitig als ideal für Machine-Learning-Aufgaben erwiesen. GPUs kommen häufig bei grossen Modellen und im Training von neuronalen Netzwerken zum Einsatz, da sie eine hohe Rechenleistung bieten.

Eine TPU @noauthor_tpu_nodate ist ein speziell entwickelter Prozessor, der ausschliesslich für Machine-Learning-Workloads optimiert wurde. Die TPU wurde von Google entwickelt und ist besonders effizient bei der Verarbeitung von Tensoroperationen, wie sie in Frameworks wie TensorFlow genutzt werden. TPUs sind für das Training und die Inferenz geeignet, wobei sie bei letzterem aufgrund ihrer geringen Latenz und Effizienz eine herausragende Rolle spielen.

Die NPU @noauthor_what_2024 kann ML-Tasks hochgradig parallelisieren und effizient ausführen. In bestimmten Szenarien kann eine NPU eine GPU in Sachen Geschwindigkeit deutlich übertreffen @noauthor_npu_2024.

Die NPU basiert auf der Funktionsweise neuronaler Netzwerke, ähnlich wie im menschlichen Gehirn, und simuliert das Verhalten von Neuronen und Synapsen.


==== Coral USB Accelerator
Der USB-Dongle von Google, Coral USB Accelerator, hat eine dedizierte TPU (Tensor Processing Unit). Solche Geräte lassen sich leicht in bestehende Systeme integrieren und ermöglichen die schnelle Ausführung von ML-Algorithmen ohne signifikante Anpassungen der Infrastruktur. Der Preis bewegt sich um 89.90Fr.@noauthor_coral_nodate.  

==== Coral PCI-Beschleuniger
Nebst den USB-Dongles stellt Google auch über die PCI-Schnittstelle angeschlossene Beschleuniger her. Diese sind als Single oder Dual-TPU erhältlich. Der Preis für die Single-Lösung mit 4 TOPS liegt bei 47,90. @noauthor_pineboards_nodate, für die Dual-Lösung mit 8 TOPS bezahlt man 96,90 Fr. @noauthor_pineboards_nodate-1.

#figure(
  image("../figures/coral_M2_accel.png", width: 40%),
  caption: [Coral PCI Accelerator\
 (Quelle: https://www.coral.ai/products/m2-accelerator-dual-edgetpu, aufgerufen am 22.01.2025)],
)

==== Hailo-NPU
Die Hailo-Beschleunigermodule sind moderner als die Lösungen von Google und erreichen eine höhere Leistungsfähigkeit. Die in diesem Projekt verwendeten Beschleuniger haben 13 und 26 TOPS zu 79,90 Fr.@noauthor_raspberry_nodate-1 resp. zu 122,90 Fr.@noauthor_raspberry_nodate. Die folgende @hailo_on_rpi5 zeigt einen Hailo-Beschleuniger auf einem Raspberry Pi.

#figure(
    image("../figures/hailo_accel.png", width: 40%),
    caption: [Hailo Accelerator \
    (Quelle: https://www.pi-shop.ch/raspberry-pi-ai-hat-13t, aufgerufen am 22.01.2025)
],
)<hailo_on_rpi5>

==== AI-Kamera
Eine weitere Kategorie sind AI-Kameras, die mit integrierten ML-Chips ausgestattet sind. Diese Kameras, wie auf @ai_cam dargestellt, können nicht nur Bilder aufnehmen, sondern auch direkt auf der Kamera Inferenzdaten bereitstellen, beispielsweise durch die Erkennung und Klassifikation von Objekten. Raspberry Pi stellt eine solche Kamera zur Verfügung für 77,90 Fr. @noauthor_raspberry_nodate-2.

#figure(
    image("../figures/ai_camera.png", width: 30%),
    caption: [
    Raspberry Pi AI Camera \
    (Quelle: https://www.berrybase.ch/raspberry-pi-ai-camera, aufgerufen am 22.01.25)
]
)<ai_cam>

Dieser Ansatz verlagert die intensiven Berechnungen auf die Kamera, womit der Edge-Computer weniger Ressourcen bereitstellen muss. Die @ai_cam_arch verdeutlicht, wie die Architektur eines solchen Systems aufgebaut ist. Die linke Seite zeigt den Aufbau herkömmlicher Kamera-Architekturen, während rechts die Lösung mittels ML-Beschleuniger dargestellt ist.

#figure(
  image("../figures/ai_camera_arch.png", width: 60%),
  caption: [Raspberry Pi AI Camera Architektur\
(Quelle: https://www.raspberrypi.com/documentation/accessories/ai-camera.html, aufgerufen am 20.01.2025)],
)<ai_cam_arch>

Beim Sensor handelt es sich um einen Sony IMX500 Chip @noauthor_ai_nodate-1, welcher das Bild erfasst. Die Daten gelangen als RAW-Image zum ISP, einem kleinen Image Signal Prozessor. Dieser wandelt das RAW-Image zu einem Input-Tensor, welcher vom AI-Accelerator als Input-Grösse entgegengenommen wird. Nach Durchführen der Inferenz gelangen die Resultate, in diesem Fall der Output-Tensor, zum Prozessor des Host-Systems. Gleichzeitig gelangt auch das Image auf das Host-System, um, wenn nötig, die Resultate anzuzeigen oder weiterverarbeitet zu werden. Die Bilder können wahlweise mit 10 FPS bei einer Auflösung von 4056 × 3040 oder bei 30 FPS mit 2028 × 1520 aufgenommen werden.

== Mitwelten Biodiversitäts Monitoring

Biodiversitätsmonitoring befasst sich grundsätzlich mit dem Beobachten und Analysieren der Tier- und Pflanzenwelt.

#quote(attribution:  <bdm_verlassliche_nodate>)["Die biologische Vielfalt bildet eine Lebensgrundlage der Schweiz. Deshalb ist es wichtig, ihren Zustand und ihre Entwicklung zu kennen."]

Aus diesem Grund ist es von grosser Bedeutung, die Umwelt zu beobachten und Veränderungen festzustellen. Um diese Arbeit zu vereinfachen, sind automatisierte Lösungen für ein Monitoring gefragt. 

Ein System zur automatisierten Datenerfassung wurde im Rahmen des Projekts Mitwelten entwickelt @wullschleger_data_nodate @wullschleger_automated_nodate. Hierfür wurden verschiedene Sensoren zu einem IoT-Toolkit kombiniert. Dieses Toolkit ermöglicht es, Daten von dezentralen Systemen zu erfassen und an ein zentrales Backend weiterzuleiten.

Das IoT-Toolkit umfasst unter anderem eine Kamera, die in regelmässigen Abständen Fotos von Blüten aufnimmt. Im Rahmen des Projekts wurden so insgesamt 1,5 Millionen Bilder generiert. @pollinator_cam zeigt eine im Feld aufgestellte IoT-Kamera.

#figure(
  image("../figures/pollinator_cam.jpg", width: 50%),
  caption: [
    IoT Kamera im Feld\
    (Quelle: mitwelten.ch, aufgerufen am 23.01.2025)
],
)<pollinator_cam>

Die enorme Menge an Bilddaten lässt sich nicht manuell analysieren. Deshalb entwickelte das Projektteam eine Machine-Learning-Pipeline, die Bestäuber automatisch erkennt.

Die technische Architektur des Systems verbindet die Kamera mit einem leistungsstarken Backend. Die Kamera, bestehend aus einem Raspberry Pi und einer angeschlossenen Kameraeinheit, erfasst die Bilder und überträgt diese über einen Access Point an das Backend. Auf dem Backend-Server laufen die rechenintensiven Analysen, welche die empfangenen Bilder nach Bestäuber untersuchen. 

=== Bestäuberanalyse <referenz_use_case>
Die Bestäuberdetektion erfolgt in den folgenden Schritten. Ein Foto von mehreren Blüten, zum Beispiel von einem Blumentopf, durchläuft in einem ersten Schritt eine Machine Learning Analyse zur Detektion von Blüten. Die auf dem Bild detektierten Blüten auf @mw_pipeline in Rot gekennzeichnet, werden anschliessen ausgeschnitten und somit zu einzelnen kleinen Bildern. Jedes dieser Bilder wird anschliessend mit einer weiteren Analyse und einem anderen Machine Learning Modell auf Bestäuber untersucht. Eine grosse Herausforderung in diesem Setup ist, dass die Anzahl Bestäuberanalysen mit der Anzahl detektierter Blüten steigt. Dies kann bei grossen Blütenzahlen zu langen Inferenzzeiten eines einzigen Bildes führen.

#figure(
  image("../figures/mw_pipeline.png", width: 100%),
  caption: [Vorgang Mitwelten Bestäuber Analyse \ 
    (Quelle: Automated Analysis for Urban Biodiversity Monitoring, Timeo Wullschleger)
],
)<mw_pipeline>

Mit eine Intervall von 15 Sekunden bestehen gute Chancen, einen Bestäuber auf der Blüte zu erfassen.

=== Edge Architektur<mw_edge_architektur>

Im Kontext dieser Entwicklung wurden verschiedene Architekturen untersucht @wullschleger_automated_nodate[p~58]. Unter anderem ein System, auf dem die Machine-Learning-Pipeline auf einem Raspberry Pi 3 ausgeführt wird. Der Edge-Computer analysiert die Bilder vor Ort und schickt nur die Resultate an das Backend. Die Problematik mit der steigenden Anzahl an Inferenzen pro detektierter Blüte kommt aber in diesem Setup besonders zur Geltung. Die @mw_analyse_rpi3 zeigt das Verhältnis der detektierten Blüten zur Analysezeit auf. 

#figure(
  image("../figures/mw_analyse_rpi3.png", width: 100%),
  caption: [
    Mitwelten Analyse auf Raspberry Pi 3\
    (Quelle: Automated Analysis for Urban Biodiversity Monitoring S.61, Timeo Wullschleger)
],
)<mw_analyse_rpi3>

Mit wachsender Anzahl Blüten auf dem Bild steigt die Zeit für die Bestäuberanalyse stark an. Da eine Kamera typischerweise immer dieselben Blüten untersucht, würde eine Perspektive mit vielen Blüten bei gleichbleibendem Bildintervall von 15 Sekunden, immer mehr in Verzögerung geraten. Selbst wenn die Zeiten ohne Aufnahmen aufgrund ungenügender Lichtverhältnisse für die Bildanalyse genutzt würden, bleibt diese Architektur in diesem Setup nicht realisierbar. Bei einem Bildintervall von 15 Sekunden und 12 Stunden genügenden Lichtverhältnissen dürfte die Analyse maximal doppelt so lange, also 30 Sekunden für alle Blüten in Anspruch nehmen. Das Machine Learning Model wurde mit einer `max_detection` von 30 Blüten trainiert. Wie aus @mw_analyse_rpi3 ersichtlich, reicht die Zeit nicht, die Analyse auf der Kamera, also dem Raspberry Pi auszuführen.

