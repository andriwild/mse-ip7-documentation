#import "/utils/todo.typ": TODO

#pagebreak()

= Validierung
In diesem Kapitel werden die implementierten Prototypen bezüglich ihrer Resultate und Praxistauglichkeit bewertet. Dabei stehen Aspekte wie Inferenzgeschwindigkeit, Energieverbrauch und Flexibilität im Fokus. Anschliessend werden zwei interessante Konkurrenzprodukte vorgestellt.

== Bewertung der Prototypen
Die in @prototyp_1 vorgestellten Prototypen zeigen, dass die Mitwelten-Bestäuber-Analyse erfolgreich auf einem Edge-Device umgesetzt werden kann. Eine solche Verarbeitung war mit Hardware im gleichen Preissegment bisher nicht realisierbar. Besonders der Hailo-Beschleuniger hat sich als gute Lösung für die Mitwelten-Analyse erwiesen. Die folgenden Vergleiche zeigen, welche Vorteile und Herausforderungen die verschiedenen Ansätze mit sich bringen und inwieweit sie sich für das Biodiversitätsmonitoring eignen.

=== Mitwelten-Analyse
Mit einem Bild- resp. Analyseintervall von 15 Sekunden sind alle der vorgestellten Varianten umsetzbar. Im Folgenden wird davon ausgegangen, dass dieses Intervall beibehalten wird, auch wenn die Bildrate aufgrund des Systems schneller sein könnte. In Anwendung auf die Mitwelten-Bestäuberanalysen gäben höhere Bildraten neue Herausforderungen, die adressiert werden müssten. Ein Bestäuber sollte pro Sichtung nur einmal gezählt werden, beispielsweise.

Die folgende @test_img zeigt das Bild mit 27 Blüten, welches für den Test verwendet wurde, mit und ohne Detektionen:


#figure(
    grid(
        columns: 2,
        grid.cell(
            colspan: 1,
            image("../figures/test_image.jpg", width: 100%),
        ),
        grid.cell(
            colspan: 1,
            image("../figures/test_image_detections.png", width: 100%),
        ),
    ),
  caption: [Testbild mit und ohne Inferenzresultate \
    (Quelle: https://github.com/sony/model_optimization, aufgerufen am 20.01.2025)],
)<test_img>


==== CPU Inferenz
Die Versuche mit Inferenzen auf der CPU zeigen während der Berechnungen eine sehr hohe Auslastung des Systems. Dies führt zu einem hohen Energiebedarf. 

Besonders mit ONNX und vielen Blüten ist das System praktisch dauerhaft ausgelastet. Die Pausen zwischen den Inferenzen sind nur sehr kurz, wie @onnx_15s verdeutlicht. Die CPU-Auslastung wurde während des Prozessierens des Testbildes mit 500 ms Abtastrate aufgenommen.

#figure(
  image("../figures/onnx_15s.png", width: 100%),
  caption: [System Auslastung: ONNX-Inferenz mit 15 Sekunden Intervall\
    (Quelle: Screenshot eigene Darstellung, Andri Wild, 2025)
],
)<onnx_15s>

Mit den schnelleren Inferenzen des NCNN-Frameworks werden schon deutlich längere Pausen zwischen den Inferenzen sichtbar.
@ncnn_15s visualisiert den selben Versuch.

#figure(
  image("../figures/ncnn_15s.png", width: 100%),
  caption: [System Auslastung: NCNN-Inferenz mit 15 Sekunden Intervall\
    (Quelle: Screenshot eigene Darstellung, Andri Wild, 2025)
],
)<ncnn_15s>

In beiden Fällen ist jedoch der Energiebedarf erhöht. Für Anwendungen, gerade im Bereich des Biodiversitätsmonitorings, kann ein energieeffizientes Setup wichtig sein. Zudem stellt der erhöhte Energiebedarf auch zusätzliche Anforderungen an ein entsprechend belüftetes Gehäuse. Dies kann im Einsatz auf dem Feld zu weiteren Herausforderungen führen.

Vorteile dieser Umsetzung sind die geringen Anschaffungskosten und die geringe Komplexität, da die Modelle einfach in das jeweilige Format zu konvertieren sind.

==== Hailo Inferenz
Die Tests mit den Hailo-Beschleunigern zeigen auf ganzer Linie gute Resultate. Die Inferenzzeiten sind extrem kurz, wodurch die Möglichkeit entsteht, wesentlich präzisere Modelle zu verwenden. Die Auslastung des Systems sinkt praktisch gegen Null, wie @hailo_15s eindrücklich zeigt. Die kurzen Spitzen entstehen durch die Pre- und Postprocessing-Funktionen der Pipeline. In den langen Pausen zwischen den Inferenzen sinkt der Energiebedarf auf unter 4 Watt.

#figure(
  image("../figures/hailo_15s.png", width: 100%),
  caption: [System Auslastung: Hailo8l-Inferenz mit 15 Sekunden Intervall\
    (Quelle: Screenshot eigene Darstellung, Andri Wild, 2025)
],
)<hailo_15s>

Die gute Performance ist zu einem akzeptablen Preis erhältlich und das System überzeugt in allen Aspekten. Besonders für energiesparsame Applikationen ist dieses Setup sehr interessant. Diese Tests wurden mit dem Hailo8l 13 TOPS Beschleuniger gemacht. Für noch bessere Performance könnte man den etwas teureren Hailo8 mit 26 TOPS einsetzen. Einziger Nachteil ist die etwas komplizierte Konvertierung der Modelle, für welche ein gewisses Verständnis von ML-Modellen notwendig ist und die Zeit für Einarbeitung beansprucht.

=== AI-Kamera
Die AI-Kamera zeichnet sich durch einen niedrigen Energiebedarf aus. Zusätzlich ist das Host-System gut entlastet. Für die Mitwelten-Analyse kann diese Hardware nicht optimal eingesetzt werden, da nur eine Inferenz auf der Kamera ausgeführt werden kann. Dies hätte zur Folge, dass der Grossteil der Inferenzen auf der CPU oder einem zusätzlichen Beschleuniger betrieben werden muss. In beiden Varianten wäre es naheliegend, gerade alle Inferenzen auf derselben Recheneinheit auszuführen. Jedoch ist die Kamera für Biodiversitätsmonitoring sehr interessant, sofern nur eine Inferenz pro Bild notwendig ist. Besonders für energieeffiziente Systeme, beispielsweise solarbetriebene, könnte die Kamera in Kombination mit einem leistungsschwächeren und dadurch energieeffizienten Host-System zum Einsatz kommen.


== Konkurrenzprodukte
Die Möglichkeit, Analysen direkt auf einem Edge-Device auszuführen, ist eine vielversprechende Anwendung, was durch die Verfügbarkeit von Produkten auf dem Markt bestätigt wird. Zwei besonders interessante Geräte sind die reCamera @noauthor_recamera_nodate und die EcoEye-Kamera @noauthor_ecoeye_nodate, die beide über SeeedStudio erhältlich sind.

Die reCamera lässt sich mithilfe von Node-Red konfigurieren, wodurch die Konfiguration von Applikationen ohne Programmierkenntnisse möglich ist. Dies bietet insbesondere für Projekte ohne Informatik-affine Mitarbeitende oder für Citizen-Science-Anwendungen einen erheblichen Vorteil. Die Kamera ist äusserst kompakt, jedoch nicht wasserdicht und erfordert daher einen zusätzlichen Schutz für den Ausseneinsatz.

Die EcoEye-Kamera wurde speziell für den Ausseneinsatz entwickelt und verfügt über einen grossen Akku, der den Betrieb in Gebieten ohne externe Stromversorgung ermöglicht. Ihre Bauweise ähnelt der einer herkömmlichen Wildkamera, bietet jedoch zusätzliche Rechenleistung, um Analysen direkt auf dem Gerät durchzuführen. Dadurch können Daten bereits vor Ort verarbeitet werden.
