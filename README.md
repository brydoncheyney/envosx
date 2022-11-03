# Environment

Installs and configures a development environment on OSX

## Prerequisites

These tools and packages require the installation of the Apple CLI
developer tools. This is normally installed with
[Xcode](https://developer.apple.com/xcode/)... but we don't need
that overhead.

To *only* install the Apple CLI developer tools,

```console
xcode-select --install
```

## Package Management

[Homebrew](https://brew.sh/) is *the Missing Package Manager for macOS* and allows for package management in OSX.

## Installing

To install a package -

```console
make TARGET
```

To install all packages -

```console
make install
```

## Targets/Tools/Packages

- [aws](https://aws.amazon.com/cli/)
- [git](https://git-scm.com/)
- [homebrew](https://brew.sh/)
- [kubernetes](https://kubernetes.io/)
- [python](https://www.python.org/)
- [go](https://go.dev/)
- [vim](https://www.vim.org/)
- [vscode](https://code.visualstudio.com/)
- [zsh](http://www.zsh.org/)/[ohmyzsh](https://ohmyz.sh/)
- shell; various tools and configuration snippets
