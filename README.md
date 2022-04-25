<p align="center">
  <img src="https://raw.githubusercontent.com/UndeadSec/SocialFishMobile/master/content/logo.png" width="200"/>
</a></p>

<h1 align="center">SocialFish Mobile</h1>
<p align="center">
  <a href="https://flutter.dev/">
    <img src="https://img.shields.io/badge/Flutter-1.x-blue.svg">
  </a>
  <a href="https://github.com/UndeadSec/SocialFishMobile/blob/master/LICENSE">
    <img src="https://img.shields.io/badge/License-BSD%203-important.svg">
  </a>
  <a href="https://github.com/UndeadSec/SocialFishMobile/releases">
    <img src="https://img.shields.io/badge/Release-1.0-red.svg">
  </a>
    <a href="https://opensource.org">
    <img src="https://img.shields.io/badge/Open%20Source-%E2%9D%A4-brightgreen.svg">
  </a>
</p>

<p align="center" style="color: gray;">
This app is an open-source project to remote control SocialFish, it does not work independently.
</p>

<br/>

![Screenshot](https://raw.githubusercontent.com/UndeadSec/SocialFishMobile/master/content/screen.png)

## How to build
```bash
# Prepare your Flutter environment
# Go to https://flutter.dev/docs/get-started/install
# After configured go ahead

# Clone this repository
$ git clone https://github.com/UndeadSec/SocialFishMobile.git socialfish

# Go into the repository
$ cd socialfish

# Check issues
$ flutter doctor

# Get dependencies
$ flutter packages get

# Build APK
$ flutter build apk --release
```

## Screenshots

<p align="center">
  <img src="https://raw.githubusercontent.com/UndeadSec/SocialFishMobile/master/content/screenshot-1.png" width="250">
  <img src="https://raw.githubusercontent.com/UndeadSec/SocialFishMobile/master/content/screenshot-2.png" width="250">
  <img src="https://raw.githubusercontent.com/UndeadSec/SocialFishMobile/master/content/screenshot-3.png" width="250">
</p>

## DISCLAIMER

TO BE USED FOR EDUCATIONAL PURPOSES ONLY

The use of the SocialFish is COMPLETE RESPONSIBILITY of the END-USER. Developers assume NO liability and are NOT responsible for any misuse or damage caused by this program.

"DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
Taken from [LICENSE](LICENSE).

## SocialFish
Are you looking for SocialFish? [UndeadSec/SocialFish][sf-web]

## FAQ
> #### Which technology is used to develop the SocialFish Mobile app?
> SocialFish Mobile it's written in [`Dart`](https://www.dartlang.org/) and are build using a Google's framework called [`Flutter`](https://flutter.dev).

> #### Why does SocialFish Mobile request camera permission?
> The camera permission are described in `AndroidManifest.xml` file, it's required to scan the token qrcode.

> #### How can i get an compiled apk?
> Get from a [released](https://github.com/UndeadSec/SocialFishMobile/releases) version.

> #### I didn't found a iOS version, why?
> At the present moment, we don't have a iOS version, maybe on future.

## Maintainers
- **Tiago R. Lampert**, Twitter: [tiagorlampert][tw-tiago], Github: [@tiagorlampert][git-tiago]

## License

>The [BSD 3-Clause License](https://opensource.org/licenses/BSD-3-Clause)
>
>Copyright (c) 2019, UndeadSec
>
>All rights reserved.
>
>Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
>
>* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.
>
>* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
and/or other materials provided with the distribution.
>
>* Neither the name of the copyright holder nor the names of its
  contributors may be used to endorse or promote products derived from
this software without specific prior written permission.
>
>THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

[//]: # (links references)
[sf-web]: <https://github.com/UndeadSec/SocialFish>
[git-tiago]: <https://github.com/tiagorlampert>
[tw-tiago]: <https://twitter.com/tiagorlampert>
