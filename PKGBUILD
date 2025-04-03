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
b2sums=('0b20aa87c31835d161aa1997f7b9ee282e6735041ece1944c810955d11546cae4cb3f3e403e79c6664bd0f628fb10a4c683160874a629c6d35904e7eb3fd5c04')

package() {
    install -Dm644 "$srcdir/lazyupdater.sh" "$pkgdir/etc/lzu"
    install -Dm644 "$srcdir/lazyupdater.conf" "$pkgdir/etc/lazyupdater.conf"
}
