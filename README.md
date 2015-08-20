# Arne's Emacs config

This is the third iteration of my personal Emacs config. I've looked
at dozens of people's configs over the years, tried various
approaches, and finally distilled my own set of best practices.

It's layered as follows

* `sane-defaults` Tweaking of basic settings
* `setup-emacs` Enabling and configuring built-in functionality
* `setup-packages` Initialize the package system, and install and configure a small number of essential packages that no-one should do without
* `setup-{clojure,org-mode,ruby,...}` Per-language or major mode config, including installing packages, configuring, setting up keybindings.
* `look-and-feel` Font and theme
* `key-bindings` Bindings not relating to a specific language or major mode

If you want to adopt this config, then start from the bottom, since
those are the most personal and particular. For example, I have my
right control key mapped to `Hyper`, so a lot of my keybindings use
`H-`. You probably want to change those.

For `look-and-feel`, I'm a big fan of the Inconsolata font. Chances
are you don't have that installed or prefer something else.

For each language or major mode that doesn't apply to your workflow
you should comment out the relevant `(require )` line in `init.el`. If
you comment all of them out you get a clean and minimal, but sane and
well considered Emacs config.

Some principles I try to follow

* Keep it simple
* Prefer ELPA packages over custom functions or vendored dependencies
* Add enough comments so that any Emacs novice can easily find their way
* Separate the things people generally agree on from the things people are more likely to personalize
* Allow easy opting out of features that don't apply to a persons job or workflow

Custom functions of my own devising are prefixed with `plexus/`. Those
I've "borrowed" from others have been prefixed for attribution.