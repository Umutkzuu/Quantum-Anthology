Quantum Anthology 🌌

Bridge to Bridge Studio Edition

"Sanat ve Mühendislik arasında köprüler kuruyoruz."

Quantum Anthology, kuantum mekaniği, kozmoloji ve teorik fiziğin karmaşık kavramlarını görselleştiren 5 farklı Generative Art eserinin, akışkan bir deneyim içinde birleştirildiği bir dijital sanat projesidir. Processing (Java) kullanılarak geliştirilen bu proje, matematiksel algoritmaları estetik bir dille yorumlar.

🎨 Eserler (Anthology)

Bu antoloji, mikro kozmostan (atom altı parçacıklar) makro kozmosa (süper kümeler) uzanan bir yolculuğu simgeler.

1. Is This Quantum Computing

Konsept: Sicim Teorisi & Düzensizlik

Açıklama: Spirohedron şeklinden esinlenen bir sicim görselleştirmesidir. Sicimlerin titreşimsel hareketini simüle eder ve Vera Molnár'ın %1 düzensizlik algoritmasına benzer bir rastgelelik unsuru ekleyerek yapıya hafif, sanatsal bozulmalar katar.

2. Hypnotic Gluons Build Everything

Konsept: Kuantum Kromodinamiği (QCD)

Açıklama: Kuarklar ve gluonların karmaşık etkileşimlerinden esinlenilmiştir. Parçacıkların canlı bir 3B uzayda salındığı ve etkileşime girdiği, gluon alanlarının dinamik ve sürekli değişen doğasını temsil eder. (Bu eser, subliminal bir etki yaratmak amacıyla kurguda en kısa süreye sahiptir.)

3. Hypercube

Konsept: 4. Boyut Geometrisi

Açıklama: Dördüncü boyutun (Tesseract) gölgesini üç boyutlu uzayda titreşimli bir iz olarak temsil eder. Zamanla bükülen geometrinin kuantum olasılıklarını görünür kılmayı amaçlar.

4. Orbit

Konsept: Kütleçekimi & Uzay-Zaman Bükülmesi

Açıklama: Evrenin dokusunu eğip bükerek ışığın yolunu yeniden çizen kütleçekim noktalarını simüle eder. Görünmeyen kozmik akışların mimarları olarak sahnede titreşen izler bırakır.

5. Quantum Laniakea

Konsept: Makro Yapılar & Kozmik Ağ

Açıklama: Atom altı parçacıkların kaotik titreşimleriyle Laniakea Süperkümesi’nin devasa akışlarını aynı kozmik nefeste birleştirir. Ölçekler arası rezonansın evrendeki gizli ritmini görünür kılar.

🛠 Teknik Mimari (Engineering)

Bu proje, Bridge to Bridge Studio'nun "Mühendislik tabanlı Sanat" yaklaşımıyla Nesne Yönelimli Programlama (OOP) prensipleri kullanılarak inşa edilmiştir.

Scene Management System: Her eser Scene soyut sınıfından türetilmiştir (Polymorphism). Bu sayede yeni eserler sisteme modüler olarak eklenebilir.

PGraphics Buffering: Her sahne doğrudan ekrana değil, önce sanal bir tuvale (Off-screen buffer) çizilir.

Smooth Transitions: Sahneler arası geçişler, buffer'lanmış görüntülerin alpha kanalları (şeffaflık) manipüle edilerek (tint ve lerp mantığıyla) pürüzsüz bir şekilde gerçekleştirilir.

Dynamic Timing: Her eserin kendine özgü bir süresi (duration) vardır. Örneğin "Gluon" sahnesi daha hızlı bir tempoya sahipken, diğer sahneler izleyicinin detayları görmesi için daha uzun süre ekranda kalır.

🚀 Kurulum ve Çalıştırma

Bu projeyi kendi bilgisayarınızda çalıştırmak için:

Processing IDE'yi indirin ve kurun: processing.org

Bu repodaki .pde dosyasını açın.

Play butonuna basın.
