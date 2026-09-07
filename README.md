<!-- SPDX-License-Identifier: CC0-1.0 -->
# make it\_stop

Have you ever looked at the complexity of modern websites and thought
someone should make it stop? When you come across a needlessly
complicated "web app" do you wish you could make it stop and become
a static website? Have you turned to static website generators only to
find them reliant on too many dependencies and a scripting language you
don't have installed on your minimalist machine? Then, `make it_stop`
could be for you!

**Disclaimer: the former is meant to be a tongue-in-cheek play on words,
I don't wish to aggravate hardworking web developer nor developers of
static website generators (they are all better than this one).**


## Description

> How many websites could `Make` make if `Make` GNU how to make
> websites?

Make it stop is my sorry attempt at making `Make` make static websites
from simple markdown files, coupled with raw `html` and `css`.

*Notes:*
1. *The GNU/knew pun is taken from this [epic rap battle from
   history](https://www.youtube.com/watch?v=njos57IJf-0).*
2. *`make it\_stop` is intended to be compatible with different versions
   of `Make`, not only with `(GNU) Make`.*


## Example Website

To see and example website read the `make it_stop`
[documentation](https://joao-o-santos.gitlab.io/make-it-stop) which is
itself made with `make it_stop`.


## How To

1. Write your pages in `PAGES_DIR`

2. Customize the files in `TEMPLATES_DIR`

3. If necessary make change the defaults in `config.mk`

4. Run `make it_stop`

5. Preview the rendered pages in `WEB_DIR` by opening them with your
   browser.

6. Iterate over the previous steps until you're happy with the results

7. Get the pages in `WEB_DIR` to your web server or use GitLab Pages
   and/or GitHub Pages.

**For more detailed instructions checkout the
[tutorial](https://joao-o-santos.gitlab.io/make-it-stop/tutorial.html).**
