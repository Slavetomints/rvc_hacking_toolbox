# Usage Guide

This is the in-depth guide for using this program, this is not meant to be a readme file. For that you can look at [the README file](README.md).

> ## Table of Contents
>
>  - [Usage Guide](#usage-guide)
>  - [Table of Contents](#table-of-contents)
>  - [Toolbox](#toolbox)
>  - [Cryptography](#cryptography)
>    - [A1Z26](#a1z26)
>    - [Atbash](#atbash)
>    - [Base32](#base-32)
>    - [Base64](#base-64)
>    - [Binary](#binary)
>    - [Caesar](#caesar)
>    - [Decimal](#decimal)
>    - [Hexadecimal](#hexadecimal)
>    - [Morse](#morse-code)
>    - [Rail Fence](#rail-fence)
>    - [RSA](#rsa)
>    - [SHA1](#sha1)
>    - [Vigenère](#vigenère)
>  - [Enumeration and Exploitation](#enumeration-and-exploitation)
>  - [Forensics](#forensics)
>  - [Log Analysis](#log-analysis)
>  - [Network Traffic Analysis](#network-traffic-analysis)
>  - [Open Source Intelligence](#open-source-intelligence)
>  - [Password Cracking](#password-cracking)
>  - [Scanning and Reconnaissance](#scanning-and-reconnaissance)
>  - [Web Application Exploitation](#web-application-exploitation)
>  - [Wireless Access Exploitation](#wireless-access-exploitation)

## Toolbox/main.rb
These files are the base class for the project. 
When you run the main file it creates a new Toolbox class, from there you can select the mode that you wish to enter

#### Example
Running
```sh
rvc_hacking_toolbox$ ruby main.rb
```

Gives you
```
┌ RVC Hacking Toolbox ──────────────────────────────────────────┐
│                                                               │
│  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⡠⢤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
│  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡴⠟⠃⠀⠀⠙⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀│
│  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⠋⠀⠀⠀⠀⠀⠀⠘⣆⠀⠀⠀⠀⠀⠀⠀⠀│
│  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠾⢛⠒⠀⠀⠀⠀⠀⠀⠀⢸⡆⠀⠀⠀⠀⠀⠀⠀│
│  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣶⣄⡈⠓⢄⠠⡀⠀⠀⠀⣄⣷⠀⠀⠀⠀⠀⠀⠀│
│  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣷⠀⠈⠱⡄⠑⣌⠆⠀⠀⡜⢻⠀⠀⠀⠀⠀⠀⠀│
│  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⡿⠳⡆⠐⢿⣆⠈⢿⠀⠀⡇⠘⡆⠀⠀⠀⠀⠀⠀│
│  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢿⣿⣷⡇⠀⠀⠈⢆⠈⠆⢸⠀⠀⢣⠀⠀⠀⠀⠀⠀│
│  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣧⠀⠀⠈⢂⠀⡇⠀⠀⢨⠓⣄⠀⠀⠀⠀│
│ ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⣿⣦⣤⠖⡏⡸⠀⣀⡴⠋⠀⠈⠢⡀⠀⠀ │
│  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣾⠁⣹⣿⣿⣿⣷⣾⠽⠖⠊⢹⣀⠄⠀⠀⠀⠈⢣⡀│
│  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡟⣇⣰⢫⢻⢉⠉⠀⣿⡆⠀⠀⡸⡏⠀⠀⠀⠀⠀⠀⢇│
│  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢨⡇⡇⠈⢸⢸⢸⠀⠀⡇⡇⠀⠀⠁⠻⡄⡠⠂⠀⠀⠀⠘│
│  ⢤⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠛⠓⡇⠀⠸⡆⢸⠀⢠⣿⠀⠀⠀⠀⣰⣿⣵⡆⠀⠀⠀⠀│
│  ⠈⢻⣷⣦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⡿⣦⣀⡇⠀⢧⡇⠀⠀⢺⡟⠀⠀⠀⢰⠉⣰⠟⠊⣠⠂⠀⡸│
│  ⠀⠀⢻⣿⣿⣷⣦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⢧⡙⠺⠿⡇⠀⠘⠇⠀⠀⢸⣧⠀⠀⢠⠃⣾⣌⠉⠩⠭⠍⣉⡇│
│  ⠀⠀⠀⠻⣿⣿⣿⣿⣿⣦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣞⣋⠀⠈⠀⡳⣧⠀⠀⠀⠀⠀⢸⡏⠀⠀⡞⢰⠉⠉⠉⠉⠉⠓⢻⠃│
│  ⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣿⡄⣷⠀⠀⢀⣀⠠⠤⣤⣤⠤⠞⠓⢠⠈⡆⠀⢣⣸⣾⠆⠀⠀⠀⠀⠀⢀⣀⡼⠁⡿⠈⣉⣉⣒⡒⠢⡼⠀│
│  ⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣿⣿⣿⣎⣽⣶⣤⡶⢋⣤⠃⣠⡦⢀⡼⢦⣾⡤⠚⣟⣁⣀⣀⣀⣀⠀⣀⣈⣀⣠⣾⣅⠀⠑⠂⠤⠌⣩⡇⠀│
│  ⠀⠀⠀⠀⠀⠀⠘⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡁⣺⢁⣞⣉⡴⠟⡀⠀⠀⠀⠁⠸⡅⠀⠈⢷⠈⠏⠙⠀⢹⡛⠀⢉⠀⠀⠀⣀⣀⣼⡇⠀│
│  ⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⣿⣿⣿⣿⣿⣿⣽⣿⡟⢡⠖⣡⡴⠂⣀⣀⣀⣰⣁⣀⣀⣸⠀⠀⠀⠀⠈⠁⠀⠀⠈⠀⣠⠜⠋⣠⠁⠀│
│  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣿⣿⡟⢿⣿⣿⣷⡟⢋⣥⣖⣉⠀⠈⢁⡀⠤⠚⠿⣷⡦⢀⣠⣀⠢⣄⣀⡠⠔⠋⠁⠀⣼⠃⠀⠀│
│  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠻⣿⣿⡄⠈⠻⣿⣿⢿⣛⣩⠤⠒⠉⠁⠀⠀⠀⠀⠀⠉⠒⢤⡀⠉⠁⠀⠀⠀⠀⠀⢀⡿⠀⠀⠀│
│  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠙⢿⣤⣤⠴⠟⠋⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⠤⠀⠀⠀⠀⠀⢩⠇⠀⠀⠀│
│  ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀│
└────────────────────────────────────────────────────── version ┘
Please select your mode 
✘ Open Source Intelligence (In Development)
‣ Cryptography
  Password Cracking
  Forensics
  Log Analysis
✘ Network Traffic Analysis (In Development)
✘ Scanning & Reconnaissance (In Development)
  Web Application Exploitation
✘ Wireless Access Exploitation (In Development)
✘ Enumeration & Exploitation (In Development)
  Quit Program
```

From there you can move the pointer (On Cryptography in the example) using the arrow keys, and use enter to select your option.

&nbsp;

&nbsp;

&nbsp;

## Cryptography

Once you enter Cryptography, you'll see this

```
┌ RVC Hacking Toolbox ─────────────────────────────────────────────────┐
│   ______                 __                               __         │
│  / ____/______  ______  / /_____  ____ __________ _____  / /_  __  __│
│ / /   / ___/ / / / __ \/ __/ __ \/ __ `/ ___/ __ `/ __ \/ __ \/ / / /│
│/ /___/ /  / /_/ / /_/ / /_/ /_/ / /_/ / /  / /_/ / /_/ / / / / /_/ / │
│\____/_/   \__, / .___/\__/\____/\__, /_/   \__,_/ .___/_/ /_/\__, /  │
│          /____/_/              /____/          /_/          /____/   │
└───────────────────────────────────────────────────────────── version ┘
Please select your mode (Press ↑/↓ arrow to move and Enter to select)
‣ A1Z26
  Atbash
  Base32
  Base64
  Binary
  Caesar
  Decimal
  Hexadecimal
  Morse Code
  Rail Fence
  RSA
  SHA1
  Vigenère
  Go to Main Menu
  Quit Program
```
Using the arrow keys and enter, you can select your mode.

&nbsp;

&nbsp;

### A1Z26

```
┌ RVC Hacking Toolbox - Cryptography┐
│    ___   ________  ___   _____    │
│   /   | <  /__  / |__ \ / ___/    │
│  / /| | / /  / /  __/ // __ \     │
│ / ___ |/ /  / /__/ __// /_/ /     │
│/_/  |_/_/  /____/____/\____/      │
└────────────────────────── version ┘
Please select your mode (Press ↑/↓ arrow to move and Enter to select)
‣ Encode string
  Decode string
  Go to previous menu
  Go to Main Menu
  Quit Program

```

&nbsp;

This uses the A1Z26 cipher, where each letter of the alphabet is given a number.

>**Key**
>
> | Alphabet | A  | B  | C  | D  | E  | F  | G  | H  | I  | J  | K  | L  | M  | N  | O  | P  | Q  | R  | S  | T  | U  | V  | W  | X  | Y  | Z  |
> |----------|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|
> | Numbers  | 1  | 2  | 3  | 4  | 5  | 6  | 7  | 8  | 9  | 10 | 11 | 12 | 13 | 14 | 15 | 16 | 17 | 18 | 19 | 20 | 21 | 22 | 23 | 24 | 25 | 26 |

&nbsp;

#### Encode String

The encode string option takes in a string, and turns all characters into their numerical counterparts.

**Example**

```
┌ RVC Hacking Toolbox - Cryptography┐
│    ___   ________  ___   _____    │
│   /   | <  /__  / |__ \ / ___/    │
│  / /| | / /  / /  __/ // __ \     │
│ / ___ |/ /  / /__/ __// /_/ /     │
│/_/  |_/_/  /____/____/\____/      │
└────────────────────────── version ┘
Please enter only letters with no spaces
Hello World!

 Your result is: 8,5,12,12,15,-64,23,15,18,12,4,-63
```

&nbsp;

#### Decode String

The decode string option takes in numbers that are separated by a comma, and then outputs a string with the decoded text

**Example**

```
┌ RVC Hacking Toolbox - Cryptography┐
│    ___   ________  ___   _____    │
│   /   | <  /__  / |__ \ / ___/    │
│  / /| | / /  / /  __/ // __ \     │
│ / ___ |/ /  / /__/ __// /_/ /     │
│/_/  |_/_/  /____/____/\____/      │
└────────────────────────── version ┘
Please enter only numbers separated by a comma
8,5,12,12,15,-64,23,15,18,12,4,-63

 Your result is: 
hello world!
```

&nbsp;

&nbsp;

### Atbash

```
┌ RVC Hacking Toolbox - Cryptography┐
│    ___   __  __               __  │
│   /   | / /_/ /_  ____ ______/ /_ │
│  / /| |/ __/ __ \/ __ `/ ___/ __ \│
│ / ___ / /_/ /_/ / /_/ (__  ) / / /│
│/_/  |_\__/_.___/\__,_/____/_/ /_/ │
└────────────────────────── version ┘
Please select your mode (Press ↑/↓ arrow to move and Enter to select)
‣ Reverse string
  Go to previous menu
  Go to Main Menu
  Quit Program
```

&nbsp;

This uses the [Atbash cipher](https://www.wikipedia.org/wiki/atbash), which uses a reversed alphabet for its cipher.

>**Key**
>
> | Alphabet | A  | B  | C  | D  | E  | F  | G  | H  | I  | J  | K  | L  | M  | N  | O  | P  | Q  | R  | S  | T  | U  | V  | W  | X  | Y  | Z  |
> |----------|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|----|
> | Numbers  | Z  | Y  | X  | W  | V  | U  | T  | S  | R  | Q | P | O | N | M | L | K | J  | I | H | G | F | E | D | C | B | A |

&nbsp;

#### Reverse String

The reverse string option takes in a string, and reverses it outputting it transformed. Since this encodes and decodes the string depending on its starting position, there aren't separate encode and decode modes


**Example**
```
┌ RVC Hacking Toolbox - Cryptography┐
│    ___   __  __               __  │
│   /   | / /_/ /_  ____ ______/ /_ │
│  / /| |/ __/ __ \/ __ `/ ___/ __ \│
│ / ___ / /_/ /_/ / /_/ (__  ) / / /│
│/_/  |_\__/_.___/\__,_/____/_/ /_/ │
└────────────────────────── version ┘

Please enter the string you want to encode
Hello World!

Your result is: svool dliow!
```

&nbsp;

&nbsp;


### Base32

```
┌ RVC Hacking Toolbox - Cryptography────┐
│    ____                      ________ │
│   / __ )____ _________      |__  /__ \│
│  / __  / __ `/ ___/ _ \      /_ <__/ /│
│ / /_/ / /_/ (__  )  __/    ___/ / __/ │
│/_____/\__,_/____/\___/    /____/____/ │
└────────────────────────────── version ┘
Please select your mode (Press ↑/↓ arrow to move and Enter to select)
‣ Encrypt
  Decrypt
  Go to previous menu
  Go to Main Menu
  Quit Program
```

&nbsp;

This uses [Base32](https://wikipedia.org/wiki/base-32) as its encoding system, and can encrypt and decrypt it.

&nbsp;

#### Encrypt

This takes in a string of characters, and converts it to Base32


**Example**
```
┌ RVC Hacking Toolbox - Cryptography────┐
│    ____                      ________ │
│   / __ )____ _________      |__  /__ \│
│  / __  / __ `/ ___/ _ \      /_ <__/ /│
│ / /_/ / /_/ (__  )  __/    ___/ / __/ │
│/_____/\__,_/____/\___/    /____/____/ │
└────────────────────────────── version ┘
Please enter your data to be encoded
Hello World!

Your result is: JBSWY3DPEBLW64TMMQQQ====
```

&nbsp;

#### Decrypt

This takes in a Base32 string and converts it back to plaintext.


**Example**
```
┌ RVC Hacking Toolbox - Cryptography────┐
│    ____                      ________ │
│   / __ )____ _________      |__  /__ \│
│  / __  / __ `/ ___/ _ \      /_ <__/ /│
│ / /_/ / /_/ (__  )  __/    ___/ / __/ │
│/_____/\__,_/____/\___/    /____/____/ │
└────────────────────────────── version ┘
Please enter your data to be encoded
JBSWY3DPEBLW64TMMQQQ====

Your result is: Hello World!
```

&nbsp;

&nbsp;

### Base64

```
┌ RVC Hacking Toolbox - Cryptography──────┐
│    ____                      _____ __ __│
│   / __ )____ _________      / ___// // /│
│  / __  / __ `/ ___/ _ \    / __ \/ // /_│
│ / /_/ / /_/ (__  )  __/   / /_/ /__  __/│
│/_____/\__,_/____/\___/    \____/  /_/   │
└──────────────────────────────── version ┘
Please select your mode (Press ↑/↓ arrow to move and Enter to select)
‣ Encode
  Decode
  Go to previous menu
  Go to Main Menu
  Quit Program
```

&nbsp;

This uses [Base64](https://www.wikipedia.org/wiki/base-64) as its encoding system, and can encode and decode it.

&nbsp;

#### Encode

This takes in a string of characters, and converts it to Base64


**Example**
```
┌ RVC Hacking Toolbox - Cryptography──────┐
│    ____                      _____ __ __│
│   / __ )____ _________      / ___// // /│
│  / __  / __ `/ ___/ _ \    / __ \/ // /_│
│ / /_/ / /_/ (__  )  __/   / /_/ /__  __/│
│/_____/\__,_/____/\___/    \____/  /_/   │
└──────────────────────────────── version ┘
Please enter your data to be encoded
Hello World!

Your result is: SGVsbG8gV29ybGQh
```

&nbsp;

#### Decode

This takes in a Base64 string and converts it back to plaintext.


**Example**
```
┌ RVC Hacking Toolbox - Cryptography──────┐
│    ____                      _____ __ __│
│   / __ )____ _________      / ___// // /│
│  / __  / __ `/ ___/ _ \    / __ \/ // /_│
│ / /_/ / /_/ (__  )  __/   / /_/ /__  __/│
│/_____/\__,_/____/\___/    \____/  /_/   │
└──────────────────────────────── version ┘
Please enter your data to be encoded
SGVsbG8gV29ybGQh

Your result is: Hello World!
```

&nbsp;

&nbsp;

### Binary

```
┌ RVC Hacking Toolbox - Cryptography┐
│    ____  _                        │
│   / __ )(_)___  ____ ________  __ │
│  / __  / / __ \/ __ `/ ___/ / / / │
│ / /_/ / / / / / /_/ / /  / /_/ /  │
│/_____/_/_/ /_/\__,_/_/   \__, /   │
│                         /____/    │
└────────────────────────── version ┘
Please select your mode (Press ↑/↓ arrow to move and Enter to select)
‣ Text to binary
  Binary to text
  Go to previous menu
  Go to Main Menu
  Quit Program
```

&nbsp;

This uses [Binary](https://www.wikipedia.org/wiki/binary) as its encoding system, and can transfer between text and binary

&nbsp;

#### Encode

This takes in a string of characters, and converts it to binary. It uses spaces as the delimiter and has 8-bit bytes


**Example**
```
┌ RVC Hacking Toolbox - Cryptography┐
│    ____  _                        │
│   / __ )(_)___  ____ ________  __ │
│  / __  / / __ \/ __ `/ ___/ / / / │
│ / /_/ / / / / / /_/ / /  / /_/ /  │
│/_____/_/_/ /_/\__,_/_/   \__, /   │
│                         /____/    │
└────────────────────────── version ┘
Please enter your string to be encoded
Hello World!

Your result is: 01001000 01100101 01101100 01101100 01101111 00100000 01010111 01101111 01110010 01101100 01100100 00100001
```

&nbsp;

#### Decode

Enter a binary message with each byte separated by spaces, and it will give back the message in plaintext.


**Example**
```
┌ RVC Hacking Toolbox - Cryptography┐
│    ____  _                        │
│   / __ )(_)___  ____ ________  __ │
│  / __  / / __ \/ __ `/ ___/ / / / │
│ / /_/ / / / / / /_/ / /  / /_/ /  │
│/_____/_/_/ /_/\__,_/_/   \__, /   │
│                         /____/    │
└────────────────────────── version ┘
Please enter your string to be decoded, please separate by spaces
01001000 01100101 01101100 01101100 01101111 00100000 01010111 01101111 01110010 01101100 01100100 00100001

Your result is: Hello World!
```

&nbsp;

&nbsp;

### Caesar

```
┌ RVC Hacking Toolbox - Cryptography─────────────────────────────────┐
│   ______                              _______       __             │
│  / ____/___ ____  _________ ______   / ____(_)___  / /_  ___  _____│
│ / /   / __ `/ _ \/ ___/ __ `/ ___/  / /   / / __ \/ __ \/ _ \/ ___/│
│/ /___/ /_/ /  __(__  ) /_/ / /     / /___/ / /_/ / / / /  __/ /    │
│\____/\__,_/\___/____/\__,_/_/      \____/_/ .___/_/ /_/\___/_/     │
│                                          /_/                       │
└─────────────────────────────────────────────────────────── version ┘
Please select your mode (Press ↑/↓ arrow to move and Enter to select)
‣ Shift string
  Go to previous menu
  Go to Main Menu
  Quit Program
```

&nbsp;

This uses the [Caesar cipher](https://www.wikipedia.org/wiki/caesar_cipher) as its encoding system, and shifts the characters that many spaces to create the encoded message. Since the same method is used to encode and decode messasges, the only option is to shift the string.

&nbsp;

#### Shift String

This takes in a string of characters, and then asks for the shift, which should be a number. It then gives you back your text with the shift applied


**Example**
```
┌ RVC Hacking Toolbox - Cryptography─────────────────────────────────┐
│   ______                              _______       __             │
│  / ____/___ ____  _________ ______   / ____(_)___  / /_  ___  _____│
│ / /   / __ `/ _ \/ ___/ __ `/ ___/  / /   / / __ \/ __ \/ _ \/ ___/│
│/ /___/ /_/ /  __(__  ) /_/ / /     / /___/ / /_/ / / / /  __/ /    │
│\____/\__,_/\___/____/\__,_/_/      \____/_/ .___/_/ /_/\___/_/     │
│                                          /_/                       │
└─────────────────────────────────────────────────────────── version ┘
What would you like to be encoded?
Hello World!
How much of a shift do you want?
3

Your result is: Khoor Zruog!
```

&nbsp;

&nbsp;


### Decimal

```
┌ RVC Hacking Toolbox - Cryptography─────┐
│    ____            _                 __│
│   / __ \___  _____(_)___ ___  ____ _/ /│
│  / / / / _ \/ ___/ / __ `__ \/ __ `/ / │
│ / /_/ /  __/ /__/ / / / / / / /_/ / /  │
│/_____/\___/\___/_/_/ /_/ /_/\__,_/_/   │
└─────────────────────────────── version ┘
Please select your mode (Press ↑/↓ arrow to move and Enter to select)
‣ Encode string
  Decode string
  Go to previous menu
  Go to Main Menu
  Quit Program
```

&nbsp;

This uses the [Decimal](https://www.wikipedia.org/wiki/decimal) system (aka base10) as its encoding system, and can transfer between text and decimal numbers.

&nbsp;

#### Encode

This takes in a string of characters, and converts it to decimal.


**Example**
```
┌ RVC Hacking Toolbox - Cryptography─────┐
│    ____            _                 __│
│   / __ \___  _____(_)___ ___  ____ _/ /│
│  / / / / _ \/ ___/ / __ `__ \/ __ `/ / │
│ / /_/ /  __/ /__/ / / / / / / /_/ / /  │
│/_____/\___/\___/_/_/ /_/ /_/\__,_/_/   │
└─────────────────────────────── version ┘
Please enter the string you wish to have encoded
Hello World!

Your result is: 72 101 108 108 111 32 87 111 114 108 100 33
```

&nbsp;

#### Decode

Enter a message with each number separated by spaces, and it will give back the message in plaintext.


**Example**
```
┌ RVC Hacking Toolbox - Cryptography─────┐
│    ____            _                 __│
│   / __ \___  _____(_)___ ___  ____ _/ /│
│  / / / / _ \/ ___/ / __ `__ \/ __ `/ / │
│ / /_/ /  __/ /__/ / / / / / / /_/ / /  │
│/_____/\___/\___/_/_/ /_/ /_/\__,_/_/   │
└─────────────────────────────── version ┘
Please enter what you wish to decode separated by spaces
72 101 108 108 111 32 87 111 114 108 100 33

Your result is: Hello World!
```

&nbsp;

&nbsp;


### Hexadecimal

```
┌ RVC Hacking Toolbox - Cryptography───────────────────────────┐
│    __  __                    __          _                 __│
│   / / / /__  _  ______ _____/ /__  _____(_)___ ___  ____ _/ /│
│  / /_/ / _ \| |/_/ __ `/ __  / _ \/ ___/ / __ `__ \/ __ `/ / │
│ / __  /  __/>  </ /_/ / /_/ /  __/ /__/ / / / / / / /_/ / /  │
│/_/ /_/\___/_/|_|\__,_/\__,_/\___/\___/_/_/ /_/ /_/\__,_/_/   │
└───────────────────────────────────────────────────── version ┘
Please select your mode (Press ↑/↓ arrow to move and Enter to select)
‣ String to Hex
  Hex to String
  Go to previous menu
  Go to Main Menu
  Quit Program
```

&nbsp;

This uses [Hexadecimal](https://www.wikipedia.org/wiki/hexadecimal) to encode and decode messages.

&nbsp;

#### String to Hex

This takes in a string of characters, and converts it to Hexadecimal.


**Example**
```
┌ RVC Hacking Toolbox - Cryptography───────────────────────────┐
│    __  __                    __          _                 __│
│   / / / /__  _  ______ _____/ /__  _____(_)___ ___  ____ _/ /│
│  / /_/ / _ \| |/_/ __ `/ __  / _ \/ ___/ / __ `__ \/ __ `/ / │
│ / __  /  __/>  </ /_/ / /_/ /  __/ /__/ / / / / / / /_/ / /  │
│/_/ /_/\___/_/|_|\__,_/\__,_/\___/\___/_/_/ /_/ /_/\__,_/_/   │
└───────────────────────────────────────────────────── version ┘
Please enter your string to be converted
Hello World!

Your result is: 48 65 6c 6c 6f 20 57 6f 72 6c 64 21
```

&nbsp;

#### Hex to String

Enter a message with each number separated by spaces, and it will give back the message in plaintext.


**Example**
```
┌ RVC Hacking Toolbox - Cryptography───────────────────────────┐
│    __  __                    __          _                 __│
│   / / / /__  _  ______ _____/ /__  _____(_)___ ___  ____ _/ /│
│  / /_/ / _ \| |/_/ __ `/ __  / _ \/ ___/ / __ `__ \/ __ `/ / │
│ / __  /  __/>  </ /_/ / /_/ /  __/ /__/ / / / / / / /_/ / /  │
│/_/ /_/\___/_/|_|\__,_/\__,_/\___/\___/_/_/ /_/ /_/\__,_/_/   │
└───────────────────────────────────────────────────── version ┘
Please enter hexadecimal(Base16) digits separated by spaces
48 65 6c 6c 6f 20 57 6f 72 6c 64 21

Your result is: Hello World!
```

&nbsp;

&nbsp;


### Morse Code

```
┌ RVC Hacking Toolbox - Cryptography──────────────────────┐
│    __  ___                         ______          __   │
│   /  |/  /___  _____________      / ____/___  ____/ /__ │
│  / /|_/ / __ \/ ___/ ___/ _ \    / /   / __ \/ __  / _ \│
│ / /  / / /_/ / /  (__  )  __/   / /___/ /_/ / /_/ /  __/│
│/_/  /_/\____/_/  /____/\___/    \____/\____/\__,_/\___/ │
└──────────────────────────────────────────────── version ┘
Please select your mode (Press ↑/↓ arrow to move and Enter to select)
‣ Encode
  Decode
  Go to previous menu
  Go to Main Menu
  Quit Program
```

&nbsp;

This uses [Morse Code](https://www.wikipedia.org/wiki/morse-code) to encode and decode messages.

&nbsp;

#### Encode

This takes in a string of characters, and converts it to Morse Code.


**Example**
```
┌ RVC Hacking Toolbox - Cryptography──────────────────────┐
│    __  ___                         ______          __   │
│   /  |/  /___  _____________      / ____/___  ____/ /__ │
│  / /|_/ / __ \/ ___/ ___/ _ \    / /   / __ \/ __  / _ \│
│ / /  / / /_/ / /  (__  )  __/   / /___/ /_/ / /_/ /  __/│
│/_/  /_/\____/_/  /____/\___/    \____/\____/\__,_/\___/ │
└──────────────────────────────────────────────── version ┘
Please enter your message to be encoded
Hello World!

Your result is: .... . .-.. .-.. ---       .-- --- .-. .-.. -..
```

&nbsp;

#### Decode

Enter a message with each 'letter' separated by spaces, and words separated by 7 spaces. It will give back the message in plaintext without capitalization/special characters.


**Example**
```
┌ RVC Hacking Toolbox - Cryptography──────────────────────┐
│    __  ___                         ______          __   │
│   /  |/  /___  _____________      / ____/___  ____/ /__ │
│  / /|_/ / __ \/ ___/ ___/ _ \    / /   / __ \/ __  / _ \│
│ / /  / / /_/ / /  (__  )  __/   / /___/ /_/ / /_/ /  __/│
│/_/  /_/\____/_/  /____/\___/    \____/\____/\__,_/\___/ │
└──────────────────────────────────────────────── version ┘
Please enter your message to be decoded, separate letters by spaces and words by 7 spaces
.... . .-.. .-.. ---       .-- --- .-. .-.. -..

Your result is: hello world
```

&nbsp;

&nbsp;


### Rail Fence

```
┌ RVC Hacking Toolbox - Cryptography─────────────┐
│    ____        _ __   ______                   │
│   / __ \____ _(_) /  / ____/__  ____  ________ │
│  / /_/ / __ `/ / /  / /_  / _ \/ __ \/ ___/ _ \│
│ / _, _/ /_/ / / /  / __/ /  __/ / / / /__/  __/│
│/_/ |_|\__,_/_/_/  /_/    \___/_/ /_/\___/\___/ │
└─────────────────────────────────────── version ┘
Please select your mode (Press ↑/↓ arrow to move and Enter to select)
‣ Encrypt string
  Decrypt string
  Go to previous menu
  Go to Main Menu
  Quit Program
```

&nbsp;

This uses [Rail Fence](https://www.wikipedia.org/wiki/morse-code) to encode and decode messages.

**Example**

This example encodes "Hello World!" using three rails
>| Rail 1 | H |   |   |   | o |   |   |   | r |   |   |   |
>|--------|---|---|---|---|---|---|---|---|---|---|---|---|
>| Rail 2 |   | e |   | l |   |   |   | o |   | l |   | ! |
>| Rail 3 |   |   | l |   |   |   | W |   |   |   | d |   |

After adding the rails together, you get Horel ol!lWd


&nbsp;

#### Encrypt String

This takes in a string of characters, and an amount of rails, and encodes it.


**Example**
```
┌ RVC Hacking Toolbox - Cryptography─────────────┐
│    ____        _ __   ______                   │
│   / __ \____ _(_) /  / ____/__  ____  ________ │
│  / /_/ / __ `/ / /  / /_  / _ \/ __ \/ ___/ _ \│
│ / _, _/ /_/ / / /  / __/ /  __/ / / / /__/  __/│
│/_/ |_|\__,_/_/_/  /_/    \___/_/ /_/\___/\___/ │
└─────────────────────────────────────── version ┘
Please enter the plaintext
Hello World!
Please enter the amount of rows you want
3

Your result is: Horel ol!lWd
```

&nbsp;

#### Decode

It will give you back plaintext after you provide the ciphertext and the amount of rails used for encoding.


**Example**
```
┌ RVC Hacking Toolbox - Cryptography─────────────┐
│    ____        _ __   ______                   │
│   / __ \____ _(_) /  / ____/__  ____  ________ │
│  / /_/ / __ `/ / /  / /_  / _ \/ __ \/ ___/ _ \│
│ / _, _/ /_/ / / /  / __/ /  __/ / / / /__/  __/│
│/_/ |_|\__,_/_/_/  /_/    \___/_/ /_/\___/\___/ │
└─────────────────────────────────────── version ┘
Please enter the ciphertext
Horel ol!lWd
Please enter the amount of rows used for encryption
3

Your result is: Hello World!
```

&nbsp;

&nbsp;


### RSA

```
┌ RVC Hacking Toolbox - Cryptography───────────────────────────────────────────┐
│    ____  _____ ___          ____                             __  _           │
│   / __ \/ ___//   |        / __ \___  ____________  ______  / /_(_)___  ____ │
│  / /_/ /\__ \/ /| |       / / / / _ \/ ___/ ___/ / / / __ \/ __/ / __ \/ __ \│
│ / _, _/___/ / ___ |      / /_/ /  __/ /__/ /  / /_/ / /_/ / /_/ / /_/ / / / /│
│/_/ |_|/____/_/  |_|     /_____/\___/\___/_/   \__, / .___/\__/_/\____/_/ /_/ │
│                                              /____/_/                        │
└───────────────────────────────────────────────────────────────────── version ┘
Please select your mode (Press ↑/↓ arrow to move and Enter to select)
‣ Decrypt
  Find factors
  Go to previous menu
  Go to Main Menu
  Quit Program
```

&nbsp;

This uses [RSA Encryption](https://www.wikipedia.org/wiki/RSA_(cryptosystem)) to decode messages.


&nbsp;

#### Decrypt

This takes in the ciphertext, parts of the public key, and parts of the private key, and outputs legible text


**Example**
```
┌ RVC Hacking Toolbox - Cryptography───────────────────────────────────────────┐
│    ____  _____ ___          ____                             __  _           │
│   / __ \/ ___//   |        / __ \___  ____________  ______  / /_(_)___  ____ │
│  / /_/ /\__ \/ /| |       / / / / _ \/ ___/ ___/ / / / __ \/ __/ / __ \/ __ \│
│ / _, _/___/ / ___ |      / /_/ /  __/ /__/ /  / /_/ / /_/ / /_/ / /_/ / / / /│
│/_/ |_|/____/_/  |_|     /_____/\___/\___/_/   \__, / .___/\__/_/\____/_/ /_/ │
│                                              /____/_/                        │
└───────────────────────────────────────────────────────────────────── version ┘

What is the first factor?
13

What is the second factor?
83

What is e?
43

What is the message? (please separate by space ex: 1 2 3)
996 894 379 631 894 82 379 852 631 677 677 194 893

Your result is: SKY-KRYG-5530
```

&nbsp;

#### Find factors

It will give you back the factors of whatever number you give it, note, that with large numbers this can take a while


**Example**
```
┌ RVC Hacking Toolbox - Cryptography───────────────────────────────────────────┐
│    ____  _____ ___          ____                             __  _           │
│   / __ \/ ___//   |        / __ \___  ____________  ______  / /_(_)___  ____ │
│  / /_/ /\__ \/ /| |       / / / / _ \/ ___/ ___/ / / / __ \/ __/ / __ \/ __ \│
│ / _, _/___/ / ___ |      / /_/ /  __/ /__/ /  / /_/ / /_/ / /_/ / /_/ / / / /│
│/_/ |_|/____/_/  |_|     /_____/\___/\___/_/   \__, / .___/\__/_/\____/_/ /_/ │
│                                              /____/_/                        │
└───────────────────────────────────────────────────────────────────── version ┘
What is the number you want to find the factors of?
1079
The factors are 
 [[1, 1079], [13, 83]]
```

&nbsp;

&nbsp;


### SHA1

```
┌ RVC Hacking Toolbox - Cryptography┐
│   _____ __  _____   ___           │
│  / ___// / / /   | <  /           │
│  \__ \/ /_/ / /| | / /            │
│ ___/ / __  / ___ |/ /             │
│/____/_/ /_/_/  |_/_/              │
└────────────────────────── version ┘
Please select your mode (Press ↑/↓ arrow to move and Enter to select)
‣ Encrypt string
  Go to previous menu
  Go to Main Menu
  Quit Program
```

&nbsp;

This uses [SHA1](https://www.wikipedia.org/wiki/sha1) to encode messages.

&nbsp;

#### Encrypt String

This takes in a string of characters, and outputs the hashed value.


**Example**
```
┌ RVC Hacking Toolbox - Cryptography┐
│   _____ __  _____   ___           │
│  / ___// / / /   | <  /           │
│  \__ \/ /_/ / /| | / /            │
│ ___/ / __  / ___ |/ /             │
│/____/_/ /_/_/  |_/_/              │
└────────────────────────── version ┘
Please enter your data to be encoded
Hello World!

Your result is: 2ef7bde608ce5404e97d5f042f95f89f1c232871
```

&nbsp;

&nbsp;


### Vigenère

```
┌ RVC Hacking Toolbox - Cryptography────────────────────────────────────────┐
│ _    ___                  __                 _______       __             │
│| |  / (_)___ ____  ____  _\_\ ________      / ____(_)___  / /_  ___  _____│
│| | / / / __ `/ _ \/ __ \/ _ \/ ___/ _ \    / /   / / __ \/ __ \/ _ \/ ___/│
│| |/ / / /_/ /  __/ / / /  __/ /  /  __/   / /___/ / /_/ / / / /  __/ /    │
│|___/_/\__, /\___/_/ /_/\___/_/   \___/    \____/_/ .___/_/ /_/\___/_/     │
│      /____/                                     /_/                       │
└────────────────────────────────────────────────────────────────── version ┘
Please select your mode (Press ↑/↓ arrow to move and Enter to select)
‣ Encrypt string
  Decrypt string
  Go to previous menu
  Go to Main Menu
  Quit Program
```

```
┌ RVC Hacking Toolbox - Cryptography─────────────┐
│    ____        _ __   ______                   │
│   / __ \____ _(_) /  / ____/__  ____  ________ │
│  / /_/ / __ `/ / /  / /_  / _ \/ __ \/ ___/ _ \│
│ / _, _/ /_/ / / /  / __/ /  __/ / / / /__/  __/│
│/_/ |_|\__,_/_/_/  /_/    \___/_/ /_/\___/\___/ │
└─────────────────────────────────────── version ┘
Please select your mode (Press ↑/↓ arrow to move and Enter to select)
‣ Encrypt string
  Decrypt string
  Go to previous menu
  Go to Main Menu
  Quit Program
```

&nbsp;

This uses the [Vigenère cipher](https://www.wikipedia.org/wiki/Vigenère_cipher) to encode and decode messages.

#### Encrypt String

This takes in a string of characters, and a key, and then encrypts it.


**Example**
```
┌ RVC Hacking Toolbox - Cryptography────────────────────────────────────────┐
│ _    ___                  __                 _______       __             │
│| |  / (_)___ ____  ____  _\_\ ________      / ____(_)___  / /_  ___  _____│
│| | / / / __ `/ _ \/ __ \/ _ \/ ___/ _ \    / /   / / __ \/ __ \/ _ \/ ___/│
│| |/ / / /_/ /  __/ / / /  __/ /  /  __/   / /___/ / /_/ / / / /  __/ /    │
│|___/_/\__, /\___/_/ /_/\___/_/   \___/    \____/_/ .___/_/ /_/\___/_/     │
│      /____/                                     /_/                       │
└────────────────────────────────────────────────────────────────── version ┘
Please enter the plaintext
Hello World
Please enter the key
abc

Your result is: Hfnlp Yosnd
```

&nbsp;

#### Decode

It will give you back plaintext after you provide the ciphertext and the key phrase.


**Example**
```
┌ RVC Hacking Toolbox - Cryptography────────────────────────────────────────┐
│ _    ___                  __                 _______       __             │
│| |  / (_)___ ____  ____  _\_\ ________      / ____(_)___  / /_  ___  _____│
│| | / / / __ `/ _ \/ __ \/ _ \/ ___/ _ \    / /   / / __ \/ __ \/ _ \/ ___/│
│| |/ / / /_/ /  __/ / / /  __/ /  /  __/   / /___/ / /_/ / / / /  __/ /    │
│|___/_/\__, /\___/_/ /_/\___/_/   \___/    \____/_/ .___/_/ /_/\___/_/     │
│      /____/                                     /_/                       │
└────────────────────────────────────────────────────────────────── version ┘
Please enter the ciphertext
Hfnlp Yosnd
Please enter the key
abc

Your result is: Hello World
```

&nbsp;

&nbsp;


## Enumeration and Exploitation

&nbsp;

&nbsp;

&nbsp;

## Forensics

```
┌ RVC Hacking Toolbox ───────────────────────────┐
│    ______                           _          │
│   / ____/___  ________  ____  _____(_)_________│
│  / /_  / __ \/ ___/ _ \/ __ \/ ___/ / ___/ ___/│
│ / __/ / /_/ / /  /  __/ / / (__  ) / /__(__  ) │
│/_/    \____/_/   \___/_/ /_/____/_/\___/____/  │
└─────────────────────────────────────── version ┘
Please select your mode (Press ↑/↓ arrow to move and Enter to select)
‣ File Metadata
  2
  3
  4
  5
  Go to Main Menu
  Quit Program
```

&nbsp;

&nbsp;

### File Metadata

```
┌ RVC Hacking Toolbox - Forensics───────────────────────────────────┐
│    _______ __          __  ___     __            __      __       │
│   / ____(_) /__       /  |/  /__  / /_____ _____/ /___ _/ /_____ _│
│  / /_  / / / _ \     / /|_/ / _ \/ __/ __ `/ __  / __ `/ __/ __ `/│
│ / __/ / / /  __/    / /  / /  __/ /_/ /_/ / /_/ / /_/ / /_/ /_/ / │
│/_/   /_/_/\___/    /_/  /_/\___/\__/\__,_/\__,_/\__,_/\__/\__,_/  │
└────────────────────────────────────────────────────────── version ┘
```

This mode will open an interactive CLI file explorer, navigate the directories and select the file you want. If your file type isn't offered, and you believe that it should be offered, raise an issue on Github.

&nbsp;

&nbsp;

&nbsp;

## Log Analysis

```
┌ RVC Hacking Toolbox ───────────────────────────────────────────┐
│    __                    ___                __           _     │
│   / /   ____  ____ _    /   |  ____  ____ _/ /_  _______(_)____│
│  / /   / __ \/ __ `/   / /| | / __ \/ __ `/ / / / / ___/ / ___/│
│ / /___/ /_/ / /_/ /   / ___ |/ / / / /_/ / / /_/ (__  ) (__  ) │
│/_____/\____/\__, /   /_/  |_/_/ /_/\__,_/_/\__, /____/_/____/  │
│            /____/                         /____/               │
└─────────────────────────────────────────────────────── version ┘
```

This mode will open an interactive CLI file explorer, navigate the directories and select the file you want. You will then be asked if the log type is a Squid, NGINX, or AWS S3, select the information you want after that.

&nbsp;

&nbsp;

&nbsp;

## Network Traffic Analysis

&nbsp;

&nbsp;

&nbsp;

## Open Source Intelligence

&nbsp;

&nbsp;

&nbsp;

## Password Cracking

```
┌ RVC Hacking Toolbox ───────────────────────────────┐
│    ____                                          __│
│   / __ \____ ____________      ______  _________/ /│
│  / /_/ / __ `/ ___/ ___/ | /| / / __ \/ ___/ __  / │
│ / ____/ /_/ (__  |__  )| |/ |/ / /_/ / /  / /_/ /  │
│/_/    \__,_/____/____/ |__/|__/\____/_/   \__,_/   │
│   ______                __   _                     │
│  / ____/________ ______/ /__(_)___  ____ _         │
│ / /   / ___/ __ `/ ___/ //_/ / __ \/ __ `/         │
│/ /___/ /  / /_/ / /__/ ,< / / / / / /_/ /          │
│\____/_/   \__,_/\___/_/|_/_/_/ /_/\__, /           │
│                                  /____/            │
└─────────────────────────────────────────── version ┘
Please select a mode (Press ↑/↓ arrow to move and Enter to select)
‣ John
  Wordlist enhancer
  Go to Main Menu
  Quit application
```

&nbsp;

&nbsp;

### John
```
┌ RVC Hacking Toolbox - Password Cracking─────┐
│       __      __             ________       │
│      / /___  / /_  ____     /_  __/ /_  ___ │
│ __  / / __ \/ __ \/ __ \     / / / __ \/ _ \│
│/ /_/ / /_/ / / / / / / /    / / / / / /  __/│
│\____/\____/_/ /_/_/ /_/    /_/ /_/ /_/\___/ │
│                                             │
│    ____  _                                  │
│   / __ \(_)___  ____  ___  _____            │
│  / /_/ / / __ \/ __ \/ _ \/ ___/            │
│ / _, _/ / /_/ / /_/ /  __/ /                │
│/_/ |_/_/ .___/ .___/\___/_/                 │
│       /_/   /_/                             │
└──────────────────────────────────── version ┘
Please select your mode (Press ↑/↓ arrow to move and Enter to select)
‣ Create John Substitution Rules
  Create John Substitution Rules with numbers after
  Go to previous menu
  Go to Main Menu
  Quit application
```

&nbsp;

&nbsp;

### Create John Substitution Rules

This allows you to create John the Ripper substitution rules.

**Syntax:**

```
{LETTER/PHRASE IN WORD} {REPLACEMENT LETTER/PHRASE}
```

When you are done, hit enter to make a new substitution, and once you are done making substitutions, enter "qq" to exit. Your substitutions will then be put out in a copyable format.

```
┌ RVC Hacking Toolbox - Password Cracking─────┐
│       __      __             ________       │
│      / /___  / /_  ____     /_  __/ /_  ___ │
│ __  / / __ \/ __ \/ __ \     / / / __ \/ _ \│
│/ /_/ / /_/ / / / / / / /    / / / / / /  __/│
│\____/\____/_/ /_/_/ /_/    /_/ /_/ /_/\___/ │
│                                             │
│    ____  _                                  │
│   / __ \(_)___  ____  ___  _____            │
│  / /_/ / / __ \/ __ \/ _ \/ ___/            │
│ / _, _/ / /_/ / /_/ /  __/ /                │
│/_/ |_/_/ .___/ .___/\___/_/                 │
│       /_/   /_/                             │
└──────────────────────────────────── version ┘
Please select your mode Create John Substitution Rules

Enter what you want to replace, then the value you want to replace it with separated by a space. Ex 's $'
Enter 'qq' to stop entering values
a @

Enter what you want to replace, then the value you want to replace it with separated by a space. Ex 's $'
Enter 'qq' to stop entering values
qq


SUBSTITUTIONS
sa@
```

&nbsp;

&nbsp;

### Create John Substitution Rules and append numbers

This follows the same syntax as the method above, while also allowing for you to select an amount of numbers to append to the rules.

```
┌ RVC Hacking Toolbox - Password Cracking─────┐
│       __      __             ________       │
│      / /___  / /_  ____     /_  __/ /_  ___ │
│ __  / / __ \/ __ \/ __ \     / / / __ \/ _ \│
│/ /_/ / /_/ / / / / / / /    / / / / / /  __/│
│\____/\____/_/ /_/_/ /_/    /_/ /_/ /_/\___/ │
│                                             │
│    ____  _                                  │
│   / __ \(_)___  ____  ___  _____            │
│  / /_/ / / __ \/ __ \/ _ \/ ___/            │
│ / _, _/ / /_/ / /_/ /  __/ /                │
│/_/ |_/_/ .___/ .___/\___/_/                 │
│       /_/   /_/                             │
└──────────────────────────────────── version ┘
Please select your mode Creare John Substitution Rules with numbers after

Enter what you want to replace, then the value you want to replace it with separated by a space. Ex 's $'
Enter 'qq' to stop entering values
a @

Enter what you want to replace, then the value you want to replace it with separated by a space. Ex 's $'
Enter 'qq' to stop entering values
s $

Enter what you want to replace, then the value you want to replace it with separated by a space. Ex 's $'
Enter 'qq' to stop entering values
A @

Enter what you want to replace, then the value you want to replace it with separated by a space. Ex 's $'
Enter 'qq' to stop entering values
S $

Enter what you want to replace, then the value you want to replace it with separated by a space. Ex 's $'
Enter 'qq' to stop entering values
qq
Please select the amount of numbers to be appended
4  
Please select the lowest and highest number, separated by a space
1 9


SUBSTITUTIONS
sa@
sa@ cAz"[1..9][1..9][1..9][1..9]"
ss$
ss$ cAz"[1..9][1..9][1..9][1..9]"
sA@
sA@ cAz"[1..9][1..9][1..9][1..9]"
sS$
sS$ cAz"[1..9][1..9][1..9][1..9]"
sa@ ss$
sa@ ss$ cAz"[1..9][1..9][1..9][1..9]"
sa@ sA@
sa@ sA@ cAz"[1..9][1..9][1..9][1..9]"
sa@ sS$
sa@ sS$ cAz"[1..9][1..9][1..9][1..9]"
ss$ sA@
ss$ sA@ cAz"[1..9][1..9][1..9][1..9]"
ss$ sS$
ss$ sS$ cAz"[1..9][1..9][1..9][1..9]"
sA@ sS$
sA@ sS$ cAz"[1..9][1..9][1..9][1..9]"
sa@ ss$ sA@
sa@ ss$ sA@ cAz"[1..9][1..9][1..9][1..9]"
sa@ ss$ sS$
sa@ ss$ sS$ cAz"[1..9][1..9][1..9][1..9]"
sa@ sA@ sS$
sa@ sA@ sS$ cAz"[1..9][1..9][1..9][1..9]"
ss$ sA@ sS$
ss$ sA@ sS$ cAz"[1..9][1..9][1..9][1..9]"
sa@ ss$ sA@ sS$
sa@ ss$ sA@ sS$ cAz"[1..9][1..9][1..9][1..9]"
```

&nbsp;

&nbsp;

### Wordlist Enhancer

```
┌ RVC Hacking Toolbox - Password Cracking─────────────┐
│ _       __               _____      __              │
│| |     / /___  _________/ / (_)____/ /_             │
│| | /| / / __ \/ ___/ __  / / / ___/ __/             │
│| |/ |/ / /_/ / /  / /_/ / / (__  ) /_               │
│|__/|__/\____/_/   \__,_/_/_/____/\__/               │
│                                                     │
│    ______           __                              │
│   / ____/___  _____/ /_  ____ _____  ________  _____│
│  / __/ / __ \/ ___/ __ \/ __ `/ __ \/ ___/ _ \/ ___/│
│ / /___/ / / / /__/ / / / /_/ / / / / /__/  __/ /    │
│/_____/_/ /_/\___/_/ /_/\__,_/_/ /_/\___/\___/_/     │
└──────────────────────────────────────────── version ┘
Please select your mode (Press ↑/↓ arrow to move and Enter to select)
‣ Replace characters/phrases
  Prepend numbers
  Append numbers
  Enhanced leetspeak replacement
  Go to previous menu
  Go to Main Menu
  Quit application

```

#### Replace characters/phrases

See [Create John substitution rules](#create-john-substitution-rules) as it is the same mechanics, you will also need to select a file

&nbsp;

#### Prepend numbers / Append numbers

You will need to select a file, then you will need to specify the range of numbers, separated by '-'. The program will load the file, and prompt you for a keypress. The program will begin to write the new password to a file with the same name with 'numbers_' prepended to it.

&nbsp;

#### Enhanced Leetspeak replacement

You will need to select a file, then the program will begin to write the new password to a file with the same name with 'leetspeak_' prepended to it.

&nbsp;

&nbsp;

&nbsp;

## Scanning and Reconnaissance

&nbsp;

&nbsp;

&nbsp;

## Web Application Exploitation

```
┌ RVC Hacking Toolbox ────────────────────────────────────┐
│ _       __     __                                       │
│| |     / /__  / /_                                      │
│| | /| / / _ \/ __ \                                     │
│| |/ |/ /  __/ /_/ /                                     │
│|__/|__/\___/_.___/                                      │
│    ___                ___            __  _              │
│   /   |  ____  ____  / (_)________ _/ /_(_)___  ____    │
│  / /| | / __ \/ __ \/ / / ___/ __ `/ __/ / __ \/ __ \   │
│ / ___ |/ /_/ / /_/ / / / /__/ /_/ / /_/ / /_/ / / / /   │
│/_/  |_/ .___/ .___/_/_/\___/\__,_/\__/_/\____/_/ /_/    │
│      /_/   /_/                                          │
│    ______           __      _ __        __  _           │
│   / ____/  ______  / /___  (_) /_____ _/ /_(_)___  ____ │
│  / __/ | |/_/ __ \/ / __ \/ / __/ __ `/ __/ / __ \/ __ \│
│ / /____>  </ /_/ / / /_/ / / /_/ /_/ / /_/ / /_/ / / / /│
│/_____/_/|_/ .___/_/\____/_/\__/\__,_/\__/_/\____/_/ /_/ │
│          /_/                                            │
└──────────────────────────────────────────────── version ┘
Please select your mode (Press ↑/↓ arrow to move and Enter to select)
‣ Scan Website
  Go to Main Menu
  Quit Program

```

When you scan a website, it will ask you for a website. Please type out the full url for the program to work.

```
┌ RVC Hacking Toolbox - Web Application Exploitation───────────────────────┐
│   ______                                __                    _          │
│  / ____/___  ____ ___  ____  ________  / /_  ___  ____  _____(_)   _____ │
│ / /   / __ \/ __ `__ \/ __ \/ ___/ _ \/ __ \/ _ \/ __ \/ ___/ / | / / _ \│
│/ /___/ /_/ / / / / / / /_/ / /  /  __/ / / /  __/ / / (__  ) /| |/ /  __/│
│\____/\____/_/ /_/ /_/ .___/_/   \___/_/ /_/\___/_/ /_/____/_/ |___/\___/ │
│                    /_/                                                   │
│   _____                                                                  │
│  / ___/_________ _____                                                   │
│  \__ \/ ___/ __ `/ __ \                                                  │
│ ___/ / /__/ /_/ / / / /                                                  │
│/____/\___/\__,_/_/ /_/                                                   │
└───────────────────────────────────────────────────────────────── version ┘
Please enter the url you wish to audit
https://www.google.com
```

After you hit enter, it will begin the scan. It checks the code for comments, PHP includes statements, and any other linked webpages get scanned too.

```
┌ RVC Hacking Toolbox - Web Application Exploitation───────────────────────┐
│   ______                                __                    _          │
│  / ____/___  ____ ___  ____  ________  / /_  ___  ____  _____(_)   _____ │
│ / /   / __ \/ __ `__ \/ __ \/ ___/ _ \/ __ \/ _ \/ __ \/ ___/ / | / / _ \│
│/ /___/ /_/ / / / / / / /_/ / /  /  __/ / / /  __/ / / (__  ) /| |/ /  __/│
│\____/\____/_/ /_/ /_/ .___/_/   \___/_/ /_/\___/_/ /_/____/_/ |___/\___/ │
│                    /_/                                                   │
│   _____                                                                  │
│  / ___/_________ _____                                                   │
│  \__ \/ ___/ __ `/ __ \                                                  │
│ ___/ / /__/ /_/ / / / /                                                  │
│/____/\___/\__,_/_/ /_/                                                   │
└───────────────────────────────────────────────────────────────── version ┘
Please enter the url you wish to audit
https://www.google.com

Fetching robots.txt
Found robots.txt

Scanning website
/imghp
adding /imghp to file structure 0
/imghp has been initialized
No comments found in /imghp
No PHP code found in /imghp


/maps
adding /maps to file structure 1
/maps has been initialized
No comments found in /maps
No PHP code found in /maps


/
adding / to file structure 2
/ has been initialized
No comments found in /
No PHP code found in /


/
adding / to file structure 3
/ has been initialized
No comments found in /
No PHP code found in /


/
adding / to file structure 4
/ has been initialized
Comments found in /:
<!-- Google tag (gtag.js) -->
No PHP code found in /


/mail/
adding /mail/ to file structure 5
/mail/ has been initialized
No comments found in /mail/
No PHP code found in /mail/


/
adding / to file structure 6
/ has been initialized
No comments found in /
No PHP code found in /


/intl/en/about/products
adding /intl/en/about/products to file structure 7
/intl/en/about/products has been initialized
Comments found in /intl/en/about/products:
<!-- Google Tag Manager -->
<!-- End Google Tag Manager -->
<!--[if IE 9]><video style="display: none;"><![endif]-->
<!--[if IE 9]></video><![endif]-->
<!--[if IE 9]><video style="display: none;"><![endif]-->
<!--[if IE 9]></video><![endif]-->
<!--[if IE 9]><video style="display: none;"><![endif]-->
<!--[if IE 9]></video><![endif]-->
<!--[if IE 9]><video style="display: none;"><![endif]-->
<!--[if IE 9]></video><![endif]-->
<!--[if IE 9]><video style="display: none;"><![endif]-->
<!--[if IE 9]></video><![endif]-->
<!--[if IE 9]><video style="display: none;"><![endif]-->
<!--[if IE 9]></video><![endif]-->
<!--[if IE 9]><video style="display: none;"><![endif]-->
<!--[if IE 9]></video><![endif]-->
<!--[if IE 9]><video style="display: none;"><![endif]-->
<!--[if IE 9]></video><![endif]-->
<!--[if IE 9]><video style="display: none;"><![endif]-->
<!--[if IE 9]></video><![endif]-->
<!--[if IE 9]><video style="display: none;"><![endif]-->
<!--[if IE 9]></video><![endif]-->
<!--[if IE 9]><video style="display: none;"><![endif]-->
<!--[if IE 9]></video><![endif]-->
<!--[if IE 9]><video style="display: none;"><![endif]-->
<!--[if IE 9]></video><![endif]-->
<!--[if IE 9]><video style="display: none;"><![endif]-->
<!--[if IE 9]></video><![endif]-->
<!--[if IE 9]><video style="display: none;"><![endif]-->
<!--[if IE 9]></video><![endif]-->
<!--[if IE 9]><video style="display: none;"><![endif]-->
<!--[if IE 9]></video><![endif]-->
<!--[if IE 9]><video style="display: none;"><![endif]-->
<!--[if IE 9]></video><![endif]-->
<!--[if IE 9]><video style="display: none;"><![endif]-->
<!--[if IE 9]></video><![endif]-->
No PHP code found in /intl/en/about/products


/history/optout
adding /history/optout to file structure 8
/history/optout has been initialized
No comments found in /history/optout
No PHP code found in /history/optout


/ServiceLogin
adding /ServiceLogin to file structure 9
/ServiceLogin has been initialized
No comments found in /ServiceLogin
No PHP code found in /ServiceLogin


Please select your options for the audit (Press ↑/↓ arrow to move, Space/Ctrl+A|R to select (all|rev) and Enter to finish)
‣ ⬡ Show robots.txt
  ⬡ Show File Tree
  ⬡ Show request
  ⬡ Go to previous menu
  ⬡ Go to Main Menu
  ⬡ Quit Program
```

From there, you can select other information to see. Select them by hitting space, and hit enter to make your selections.

&nbsp;

&nbsp;

&nbsp;

## Wireless Access Exploitation
