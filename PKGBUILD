#Maintainer: Alessandro Bernardello <aleberna at erine dot eu>
# shellcheck shell=bash disable=SC2034,SC2154
pkgname=lazyupdate-git
pkgver=r30.9dc1c65
pkgrel=1
pkgdesc="Automates updating PKGBUILDS"
arch=('any')
url="https://codeberg.org/aleberna/lazyupdate"
license=('GPL-3.0-only')
depends=('glibc' 'bash')
source=("git+https://codeberg.org/aleberna/lazyupdate.git"
        "lazyupdate.conf")
b2sums=('SKIP'
        'e5887cd8dd46cbd15f8cda9f4ed91f010de55478f0099e64e322630f81fbb826da64d909494e54facb2344bfb0530a9f36d0df7ee9bec877454706aca1ec80e6')
provides=("lazyupdate")
conflicts=("lazyupdate")

pkgver() {
  cd "${srcdir}/lazyupdate" || exit 1
  ( set -o pipefail
    git describe --long --abbrev=7 2>/dev/null | sed 's/\([^-]*-g\)/r\1/;s/-/./g' ||
    printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short=7 HEAD)"
  )
}


package() {
    install -Dm755 "$srcdir/lazyupdate.sh" "$pkgdir/usr/bin/lzu"
    install -Dm644 "$srcdir/lazyupdate.conf" "$pkgdir/etc/lazyupdate.conf"
}
