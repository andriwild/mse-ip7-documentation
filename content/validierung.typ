#import "/utils/todo.typ": TODO

#pagebreak()

= Validierung
Der in @prototyp_1 vorgestellte Prototyp zeigt, dass die Mitwelten-Bestäuber-Analyse auch auf einem Edge-Device realisierbar ist. Eine solche Umsetzung war mit Hardware im gleichen Preissegment bisher nicht möglich.
Die Entwicklung einer Applikation für unterschiedliche Einsatzbereiche hat deutlich gemacht, dass sich im Bereich der Edge-ML-Hardware und ‑Software einiges bewegt. Dank der Weiterentwicklung spezialisierter Machine-Learning-Hardware können immer mehr Anwendungen direkt an der Edge realisiert werden, sodass die Leistungsfähigkeit moderner Edge-Computer zunehmend weniger als limitierender Faktor wirkt.

== Versuchsaufbau und Temperaturentwicklung
Besonders hervorzuheben ist der Einsatz von Beschleunigern, wie etwa den Komponenten von Hailo, die nicht nur für schnellere Inferenzzeiten sorgen, sondern auch die Wärmeentwicklung signifikant reduzieren. Die @versuchsaufbau_temp zeigt einen einfachen Versuchsaufbau, um die Temperaturentwicklung in einem Gehäuse zu untersuchen. Während das Gehäuse bei Einsatz der Hailo-Inferenz konstant auf einem niedrigen Temperaturniveau bleibt, führt die CPU-Inferenz zu einem rapiden Temperaturanstieg. 

#figure(
  image("../figures/versuchsaufbau_temp.jpg", width: 40%),
    caption: [Versuchsaufbau Temperatur Messung\
    (Quelle: Eigene Aufnahme, Andri Wild, 2025)
]
)<versuchsaufbau_temp>

Mit der CPU betriebenen Inferenz erhöhte sich die Temperatur im geschlossenen Gehäuse innerhalb einer Stunde auf 40 Grad, steigend. Die CPU-Temperatur lag bei ca. 85 Grad, womit die Drosselung aktiviert wird und die Rechenleistung sinkt.

Die optimierte Energieeffizienz der Beschleuniger hat positive Auswirkungen auf das Gehäusedesign – insbesondere bei Anwendungen wie Biodiversitätsanalysen, bei denen das Gerät oft im Freien und in wasserdichten Gehäusen eingesetzt wird. Der Wegfall von aktiver Belüftung eröffnet hier wesentliche Konstruktionsvorteile.

Ein Punkt beim Umgang mit dem Hailo-Beschleuniger, welcher nochmals untersucht werden muss, ist die Stabilität im Betrieb. Während länger laufenden Betriebstests kam es mehrfach zu Segmentation faults. Dieser Umstand ist zum Zeitpunkt dieser Arbeit noch nicht geklärt und bedarf weiterer Untersuchungen.

== Bewertung der Prototypen

Ein limitierender Faktor der AI-Kamera ist, dass nur eine Inferenz auf dem Beschleuniger ausgeführt werden kann. In vielen Anwendungen wäre dies eine optimale Lösung. Für die Umsetzung der Mitwelten Bestäuber Analyse hätte dies jedoch zur Folge, dass für jede detektierte Blüte eine Inferenz auf der CPU oder einem zusätzlichen Beschleuniger nötig wäre. Somit kann in beiden Fällen auf die AI-Kamera verzichtet werden, weil die Blüten-Erkennung mit nur einer Inferenz im System kaum ins Gewicht fällt.

Vielversprechender ist die Umsetzung mit Hailo-Beschleuniger oder mittels NCNN-Modellen auf der CPU. Abgesehen von den Kosten sprechen alle Aspekte für eine Umsetzung mit Hailo-Beschleuniger. Durch den grossen Geschwindigkeitsgewinn lassen sich auch wesentlich grössere Modelle verwenden, um die Detektion weiter zu verbessern. Problematisch hingegen ist der grosse Energiebedarf der NCNN-Inferenz auf der CPU. Hier kann man argumentieren, dass durch die Reduktion auf ein 15-Sekunden-Intervall die Belastung abnimmt. Jedoch büsst man dadurch bei der Flexibilität ein, weil man darauf angewiesen ist, dass durch Ruhepausen zwischen den Inferenzen für Abkühlung gesorgt ist.

== Konkurrenzprodukte
Die Möglichkeit, Analysen direkt auf einem Edge-Device auszuführen, ist eine vielversprechende Anwendung, was durch die Verfügbarkeit von Produkten auf dem Markt bestätigt wird. Zwei besonders interessante Geräte sind die reCamera @noauthor_recamera_nodate und die EcoEye-Kamera @noauthor_ecoeye_nodate, die beide über SeeedStudio erhältlich sind.

Die reCamera lässt sich mithilfe von Node-Red konfigurieren, wodurch die Konfiguration von Applikationen ohne Programmierkenntnisse möglich ist. Dies bietet insbesondere für Projekte ohne informatikaffine Mitarbeitende oder für Citizen-Science-Anwendungen einen erheblichen Vorteil. Die Kamera ist äusserst kompakt, jedoch nicht wasserdicht und erfordert daher einen zusätzlichen Schutz für den Ausseneinsatz.

Die EcoEye-Kamera wurde speziell für den Ausseneinsatz entwickelt und verfügt über einen grossen Akku, der den Betrieb in Gebieten ohne externe Stromversorgung ermöglicht. Ihre Bauweise ähnelt der einer herkömmlichen Wildkamera, bietet jedoch zusätzliche Rechenleistung, um Analysen direkt auf dem Gerät durchzuführen. Dadurch können Daten bereits vor Ort verarbeitet werden, was den Bedarf an externer Infrastruktur reduziert.


