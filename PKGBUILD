#Maintainer: Alessandro Bernardello <aleberna at erine dot eu>
# shellcheck shell=bash disable=SC2034,SC2154
pkgname=lazyupdater
pkgver=0.0.1
pkgrel=1
pkgdesc="I am really lazy"
arch=('any')
url="https://github.com/glanceapp/glance"
license=('GPL-3.0-only')
depends=('glibc' 'bash')
source=("lazyupdater.sh" "lazyupdater.conf")
b2sums=('0ead197dbc1f5b0c06638f88a9c6f805f4a4993e706ada41125e880adc76d154a9ac876407ca381c915d9badba13325b4c3850240828e28e08c0a98170343fcf'
        'b77fe55b9e2cd0a1ac42cb5f2bb0503e62215269286dc112a352a7b8d8de7cfbb8c38a36a2bc7263315ee1966872eb8b55f1ff7a1593c4e59785965207a3ff57')

package() {
    install -Dm755 "$srcdir/lazyupdater.sh" "$pkgdir/usr/bin/lzu"
    install -Dm644 "$srcdir/lazyupdater.conf" "$pkgdir/etc/lazyupdater.conf"
}
