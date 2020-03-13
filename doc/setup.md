# Setup tools to develop kozos

## 環境

OS: Ubuntu 18.04.3 LTS (Bionic Beaver)

## 環境構築

次のものをコンパイル(/インストール)する

- binutils 2.19.1 (クロスコンパイル用ツール(アセンブラ,リンカ等))
- gcc 3.4.6 (クロスコンパイラ)
- h8write (H8 3069FのフラッシュROMへの書き込みツール)
- kz_xmodem (xmodemプロトコルによるboot loader向けOS転送ツール)

```sh
git clone https://github.com/basd4g/kozos.git
cd kozos

sudo apt update
sudo apt install gcc cd lrzsz
make
# 各ツールをInstallする
# ./h8write が生成 またbinutilsとgccが /usr/local/bin/ 以下にインストールされる
```

## 備考

環境構築の詳細(`Makefile`の実行内容)は [手動で環境を構築する](setup-manualy.md) に記載した

mac OSで環境を構築する際の注意点は [mac OSで環境を構築する](setup-for-mac.md) に記載した

