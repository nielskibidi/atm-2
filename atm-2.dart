import 'dart:io';

int sisaSaldo = 1000000; // Saldo awal

void main() {
  bool isRunning = true;

  // Sesi utama ATM (berjalan terus sampai user memilih keluar)
  while (isRunning) {
    print('==============================');
    print('       Bank Serba Ada         ');
    print('==============================');
    stdout.write('Masukan PIN Anda: ');
    String? password = stdin.readLineSync();

    if (password == '112233') {
      bool inMenu = true;

      // Perulangan menu interaktif menggunakan while
      while (inMenu) {
        print('\n==============================');
        print('        Menu Utama ATM        ');
        print('==============================');
        print('1. Cek Saldo');
        print('2. Setor Tunai');
        print('3. Tarik Tunai');
        print('4. Keluar');
        print('==============================');
        stdout.write('Pilih Menu (1/2/3/4): ');
        String? pilihan = stdin.readLineSync();

        if (pilihan == '1') {
          cekSaldo();
        } else if (pilihan == '2') {
          setorTunai();
        } else if (pilihan == '3') {
          tarikTunai();
        } else if (pilihan == '4') {
          print('\nTerima kasih telah menggunakan Bank Serba Ada.');
          inMenu = false; // Menghentikan perulangan menu
          isRunning = false; // Menghentikan perulangan utama ATM
        } else {
          print('Pilihan tidak valid, silakan coba lagi.');
        }
      }
    } else {
      print('Kata sandi salah, silakan coba lagi.\n');
    }
  }
}

void cekSaldo() {
  print('\n------------------------------');
  print('Saldo Anda Saat Ini: Rp $sisaSaldo');
  print('------------------------------');
}

// Fungsi otomatis untuk menghitung rincian pecahan lembaran uang
void hitungPecahan(int nominal) {
  List<int> pecahan = [100000, 50000, 20000, 10000, 5000, 2000, 1000];
  int sisaNominal = nominal;

  print('Rincian lembaran:');
  for (int p in pecahan) {
    int jumlahLembar = sisaNominal ~/ p;
    if (jumlahLembar > 0) {
      print('- Rp $p x $jumlahLembar lembar');
      sisaNominal %= p;
    }
  }

  if (sisaNominal > 0) {
    print('- Sisa non-pecahan: Rp $sisaNominal');
  }
}

void setorTunai() {
  print('\n==============================');
  print('          Setor Tunai         ');
  print('==============================');
  stdout.write('Masukkan nominal setor: Rp ');
  String? input = stdin.readLineSync();
  int? nominal = int.tryParse(input ?? '');

  if (nominal != null && nominal > 0) {
    sisaSaldo += nominal;
    print('\nSetor tunai berhasil!');
    hitungPecahan(nominal);
    print('Saldo Anda sekarang: Rp $sisaSaldo');
  } else {
    print('Nominal tidak valid.');
  }
}

void tarikTunai() {
  print('\n==============================');
  print('          Tarik Tunai         ');
  print('==============================');
  stdout.write('Masukkan nominal tarik: Rp ');
  String? input = stdin.readLineSync();
  int? nominal = int.tryParse(input ?? '');

  if (nominal != null && nominal > 0) {
    if (nominal <= sisaSaldo) {
      sisaSaldo -= nominal;
      print('\nTarik tunai berhasil!');
      hitungPecahan(nominal);
      print('Sisa saldo Anda: Rp $sisaSaldo');
    } else {
      print('Saldo Anda tidak mencukupi.');
    }
  } else {
    print('Nominal tidak valid.');
  }
}
