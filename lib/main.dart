import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(GeriDonusumUygulamasi());
}

class GeriDonusumUygulamasi extends StatefulWidget {
  @override
  _GeriDonusumUygulamasiState createState() => _GeriDonusumUygulamasiState();
}

class _GeriDonusumUygulamasiState extends State<GeriDonusumUygulamasi> {
  bool isDarkTheme = false; // Tema durumu

  void toggleTheme(bool isDark) {
    setState(() {
      isDarkTheme = isDark; // Temayı değiştir
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDarkTheme ? ThemeData.dark() : ThemeData.light(), // Tema ayarı
      home: SplashScreen(toggleTheme: toggleTheme), // Splash ekran
    );
  }
}

class SplashScreen extends StatefulWidget {
  final Function(bool) toggleTheme;

  SplashScreen({required this.toggleTheme});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AnaSayfa(toggleTheme: widget.toggleTheme), // Ana sayfaya geçiş
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Arka plan rengi
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo1.png", width: 400, height: 400), // Logo
            SizedBox(height: 20), // Boşluk
          ],
        ),
      ),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  final Function(bool) toggleTheme;

  AnaSayfa({required this.toggleTheme});

  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  int _selectedIndex = 1; // Seçili sayfa indeksi

  static List<Widget> _pages = <Widget>[
    AtikTurleriSayfasi(), // Atık türleri sayfası
    ProfilSayfasi(), // Profil sayfası
    AyarlarSayfasi(), // Ayarlar sayfası
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Seçili sayfayı değiştir
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0F7E8), // Arka plan rengi
      appBar: AppBar(
        title: _selectedIndex == 1
            ? Text(
          'Eko Rehber', // Ana sayfa başlığı
          style: TextStyle(
            fontWeight: FontWeight.bold, // Başlığı kalın yap
          ),
        )
            : Text(
          _getPageTitle(), // Diğer sayfa başlıkları
          style: TextStyle(
            fontWeight: FontWeight.bold, // Diğer başlıkları kalın yap
          ),
        ),
        centerTitle: true, // Başlığı ortala
      ),
      body: _selectedIndex == 1
          ? SingleChildScrollView(
        child: Column(
          children: [
            _buildGorseller(), // Üst kısım için görseller
            _buildBilgilendiriciKartlar(), // Kartlar
          ],
        ),
      )
          : _pages[_selectedIndex], // Seçilen sayfa
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Atık Türleri', // Atık türleri
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Ana Sayfa', // Ana sayfa
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ayarlar', // Ayarlar
          ),
        ],
        currentIndex: _selectedIndex, // Seçili indeks
        selectedItemColor: Colors.green, // Seçili öğe rengi
        onTap: _onItemTapped, // Tıklama olayı
      ),
    );
  }


  String _getPageTitle() {
    switch (_selectedIndex) {
      case 0:
        return 'Atık Türleri'; // Atık türleri sayfası başlığı
      case 2:
        return 'Ayarlar'; // Ayarlar sayfası başlığı
      default:
        return '';
    }
  }

  Widget _buildGorseller() {
    return Column(
      children: [
        Image.asset(
          'assets/images/3.png',
          width: MediaQuery.of(context).size.width, // Ekranın tam genişliği
          height: 240, // Yükseklik
          fit: BoxFit.cover, // Görselin boyutlandırılma biçimi
        ),
        SizedBox(height: 50), // Boşluk
        Image.asset(
          'assets/images/10.png',
          width: MediaQuery.of(context).size.width, // Ekranın tam genişliği
          height: 250, // Yükseklik
          fit: BoxFit.cover, // Görselin boyutlandırılma biçimi
        ),
        SizedBox(height: 40), // Boşluk
        Image.asset(
          'assets/images/5.png',
          width: MediaQuery.of(context).size.width, // Ekranın tam genişliği
          height: 200, // Yükseklik
          fit: BoxFit.cover, // Görselin boyutlandırılma biçimi
        ),
      ],
    );
  }


  Widget _buildBilgilendiriciKartlar() {
    final List<Map<String, String>> kartlar = [
      {
        "baslik": "Geri Dönüşüm İstatistikleri",
        "icerik": "Dünyada her yıl 2 milyar ton çöp üretiliyor.\n\nGeri dönüşüm, bu atıkların %13'ünün geri kazanılmasını sağlıyor."
      },
      {
        "baslik": "Plastik Atıklar",
        "icerik": "Her yıl okyanuslara yaklaşık 8 milyon ton plastik atık bırakılıyor."
      },
      {
        "baslik": "Kağıt Geri Dönüşümü",
        "icerik": "Geri dönüşümlü kağıt kullanarak, her ağaç başına 17 ağaç kesilmekten kurtarılabilir."
      },
    ];

    return Container(
      padding: EdgeInsets.all(16.0), // İçerik boşluğu
      child: ListView(
        shrinkWrap: true, // ListView'in boyutunu ayarla
        physics: NeverScrollableScrollPhysics(), // Kaydırmayı devre dışı bırak
        children: kartlar.map((kart) {
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0), // Kart aralığı
            child: ListTile(
              title: Text(kart["baslik"]!), // Kart başlığı
              subtitle: Text(kart["icerik"]!), // Kart içeriği
              onTap: () {
                // Kart tıklama olayları
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}

class AtikTurleriSayfasi extends StatefulWidget {
  @override
  _AtikTurleriSayfasiState createState() => _AtikTurleriSayfasiState();
}

class _AtikTurleriSayfasiState extends State<AtikTurleriSayfasi> {
  final List<String> atikTurleri = [
    'Plastik',
    'Cam',
    'Kağıt',
    'Metal',
    'Organik'
  ];
  final List<bool> isLiked = List.generate(5, (index) => false); // Beğenilen atık türleri

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0F7E8), // Arka plan rengi
      body: ListView.builder(
        itemCount: atikTurleri.length, // Atık türü sayısı
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(atikTurleri[index]), // Atık türü başlığı
              trailing: IconButton(
                icon: Icon(
                  isLiked[index] ? Icons.favorite : Icons.favorite_border, // Beğenme simgesi
                  color: isLiked[index] ? Colors.red : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isLiked[index] = !isLiked[index]; // Beğenme durumunu değiştir
                  });
                },
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AtikDetaySayfasi(atikTurleri[index]), // Atık detay sayfasına geç
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class AtikDetaySayfasi extends StatelessWidget {
  final String atikTuru; // Seçilen atık türü

  AtikDetaySayfasi(this.atikTuru); // Yapıcı fonksiyon

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0F7E8), // Arka plan rengi
      appBar: AppBar(
        title: Text('$atikTuru Hakkında Bilgiler'), // Atık türü başlığı
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // İçerik boşluğu
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Sola yasla
          children: [
            Text(_getAtikBilgisi(atikTuru), style: TextStyle(fontSize: 16)), // Atık bilgisi
            SizedBox(height: 20), // Boşluk
            _getAtikResmi(atikTuru), // Atık resmi
          ],
        ),
      ),
    );
  }

  String _getAtikBilgisi(String atikTuru) {
    switch (atikTuru) {
      case 'Plastik':
        return '   Plastik, pek çok tüketici ürününün bir bileşeni olup, imalat sanayinin çıktı ve nihai ürünlerinin çoğunu oluşturur... \n\n   Plastik malzemeler gerek günlük yaşamda gerekse de endüstriyel anlamda sıklıkla kullanılan ve neredeyse hayatın her alanında bulunan malzemelerdir. Plastikten yapılmış nesnelerin bazıları, uzun yıllar boyunca kullanılmak üzere tasarlanmaktadır. Çok büyük bir bölümü ise kısa süreli kullanım için tasarlanıp üretilmekte ve tüketilmektedir. Örneğin; alışveriş poşetleri, şişeler, kaplar, gazeteler bu kapsamda değerlendirilebilmektedir. Ancak plastik, doğada yüzyıllarca bozulmadan kalabilmesi özelliği ile çevreyi tehdit edici bir yapıdadır. Günümüzde çevremizde ve dünyanın en uzak köşelerinde bile plastik atıklar bulunmaktadır. Plastikten elde edilen ve artık kullanılamayan her türlü plastik temelli öğe plastik atık olarak değerlendirilmektedir ve geri dönüştürülmesi mümkündür.';
      case 'Cam':
        return '   Cam şişeler ve kavanozlar geri dönüştürülebilir. Kırık camlar dikkatli bir şekilde geri dönüşüm kutularına atılmalıdır. \n\n   Cam atık, kullanım ömrünü tamamlamış cam ürünlerin çeşitli kaynaklardan ortaya çıkan atık cam malzemeleridir. Bu atıklar genellikle cam ambalaj malzemeleri, pencere camları, cam şişeler, cam kaplar ve cam eşyalar gibi çeşitli kaynaklardan gelir. Cam atıkları genellikle geri dönüştürülerek yeniden kullanılır veya cam ürünlerinin üretiminde hammadde olarak kullanılır. \n Cam geri dönüşümü, cam atıkların toplanması, ayrıştırılması, işlenmesi ve yeniden kullanılabilir hale getirilmesi sürecini içerir. Bu süreçte, cam atıkları öncelikle toplanır ve belirli tiplere göre ayrıştırılır. Ardından, cam atıkları kırılır, temizlenir ve eritilir. Eritilmiş cam, çeşitli yöntemlerle şekillendirilerek yeni cam ürünleri haline getirilir.';
      case 'Kağıt':
        return '   Kağıt ve karton geri dönüştürülebilir. Gazete, dergi ve karton kutular bu kategoriye girer. \n\n   Kağıt atıklar, kullanılmış kağıtların, kartonların ve diğer kağıt ürünlerinin, tükendikten sonra atık olarak değerlendirilen kısmını oluşturur. Bu atıklar genellikle ofislerden, evlerden ve endüstriyel tesislerden gelir. Kağıt atıklar yanlış yönetildiğinde çevresel sorunlara yol açarlar. Ancak doğru bir şekilde işlendiğinde değerli bir geri dönüşüm kaynağı haline gelir.';
      case 'Metal':
        return '   Metal Atıkların Geri Dönüşümü Neden önemlidir? \n \n   1 ton metal atığın geri kazanımı sonucu; 1.300 kg hammadde tasarrufu sağlanır. Yalnızca tek bir metal içecek kutusunun geri dönüşümünden elde edilen enerji ile 100 wattlık bir ampulü 20 saat çalıştırabiliyoruz. \n \n  Metal atıklar (alüminyum kutular, teneke kutular) geri dönüştürülebilir.';
      case 'Organik':
        return '   Geri dönüştürülen atıkların içerdikleri maddeler, işlem sürecinde dikkat edilmesi gereken unsurların başında gelir.Organik atıkların geri dönüşümü bu süreçte en kolay şekilde gerçekleşen ve yüksek verim elde edilen bir işlemdir. \n\n   Evsel atıklar, ticari atıklara oranla daha az oluşur. Genellikle yiyecek artıkları ve bitki parçalarından ortaya çıkan evsel organik atıklar, kompostlaştırılarak gübre olarak kullanılabilir.';
      default:
        return '  Bu kategori hakkında bilgi yok.';
    }
  }


  Widget _getAtikResmi(String atikTuru) {
    switch (atikTuru) {
      case 'Plastik':
        return Image.asset('assets/images/plastik.png'); // Plastik resmi
      case 'Cam':
        return Image.asset('assets/images/cam.png'); // Cam resmi
      case 'Kağıt':
        return Image.asset('assets/images/kagit.png'); // Kağıt resmi
      case 'Metal':
        return Image.asset('assets/images/metal.png'); // Metal resmi
      case 'Organik':
        return Image.asset('assets/images/organik.png'); // Organik resmi
      default:
        return Container(); // Boş konteyner
    }
  }
}

class AyarlarSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0F7E8), // Arka plan rengi
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start, // Yukarı yasla
        crossAxisAlignment: CrossAxisAlignment.start, // Sola yasla
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 16.0), // Boşluk
            child: SwitchListTile(
              title: Text(
                'Karanlık Mod',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold, // Kalın yazı
                ),
              ),
              value: Theme.of(context).brightness == Brightness.dark, // Karanlık mod durumu
              onChanged: (bool value) {
                (context
                    .findAncestorStateOfType<_GeriDonusumUygulamasiState>()
                    ?.toggleTheme(value)); // Tema değişimi
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 270.0, left: 30.0), // Boşluk
            child: Text(
              'İletişim Bilgileri',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold, // Kalın yazı
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 30.0), // Boşluk
            child: Text('➡ Nursema Akpirinç \n📫 nursemakprnc@gmail.com', style: TextStyle(color: Colors.black)), // İletişim bilgisi
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 30.0), // Boşluk
            child: Text('➡ Zümrüt Kazar \n📫 zumrutkazar@gmail.com', style: TextStyle(color: Colors.black)), // İletişim bilgisi
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 30.0), // Boşluk
            child: Text('➡ Başak Hatice Cesur \n📫 basakcess@gmail.com', style: TextStyle(color: Colors.black)), // İletişim bilgisi
          ),
        ],
      ),
    );
  }
}

class ProfilSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0F7E8), // Arka plan rengi
      body: Center(
        child: Image.asset(
          "assets/images/anasayfa.png", // Profil resmi
          width: 300,
          height: 300,
        ),
      ),
    );
  }
}
