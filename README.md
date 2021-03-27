# lugh

`lugh` is a small CLI tool for rendering Markdown files to their resulting source files ie `zshrc.md` -> `.zshrc`

Loosely inspired by some Markdown tools like [lmt](https://github.com/driusan/lmt) and of course [orgmode](https://orgmode.org).

As much as I like orgmode, I like the simplicity of rendering configs from Markdown since they're universally readable unlike org which looks like a mess if you don't have Emacs installed. I say this as someone who continually breaks my configuration and so I only really have Emacs around currently for dotfiles.

The code present in this repo is pretty horrible, inspired heavily by the since-removed [Markdown::Parser](https://crystal-lang.org/api/0.20.3/Markdown/Parser.html) class and subject to change.

That said, it scratches two itches I have (wanting to fiddle with [Crystal](https://crystal-lang.org) a bit and having a compiled literate markdown tool with binaries precompiled because I'm lazy.

## Installation

There's two options:

1) Download one of the binaries that are available on Github

2) Install Crystal, run `crystal build src/lugh.cr` and move the resulting binary somewhere in your `PATH`

**NOTE**: If you're on macOS, the resulting binaries aren't signed so you'll need to head to `System Preferences -> Security` and mark it as allowed before it'll run.

## Usage

A list of commands can be found by running `lugh -h`

The only command currently is `lugh -f <filename>` which will read a Markdown file, gather up all of the code blocks and spit them out into a plain text file.

There is no error handling currently and nothing to check that you're providing a Markdown file so you've been warned!

## Example

The only requirement, besides some codeblocks present, is frontmatter containing an `output` key. Other frontmatter is welcome, ie if you wanted to publish your Markdown file as a blog post, but will be ignored by `lugh`

Here's an example file. Let's say it lives at $HOME/dotfiles/zshrc.md

```
---
output: ".zshrc"
---

{3 backticks}
export PATH="/bin /sbin"
echo "hmm"
{3 backticks}

{3 backticks}
alias blah="bleh"
{3 backticks}
```

Given I'm writing markdown within markdown, the `{3 backticks}` part should actually contain literal backticks.

The result of this Markdown file would be the following:

```
export PATH="/bin/sbin"
echo "hmm"

alias blah="bleh"
```

and it would be rendered in the same directory as the source file so in this case, `$HOME/dotfiles/.zshrc`

There is currently no way to override this functionality as personally I use [GNU Stow](https://www.gnu.org/software/stow) to handle this concern.

## Development

Beyond installing Crystal v1.0.0, there's nothing special

## Contributing

I'm not looking for any contributions at the moment. Feel free to file an issue but you're not guaranteed a response or a fix. Pull requests will be ignored.

