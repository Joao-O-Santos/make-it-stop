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

> How many websites could `(GNU) Make` make if `(GNU) Make` knew how to
> make websites?

Make it stop is my sorry attempt at making `(GNU) Make` make static
websites from simple markdown files, coupled with raw `html` and `css`.

*Note: The GNU/knew pun is taken from this [epic rap battle from
history](https://www.youtube.com/watch?v=njos57IJf-0).*


## Tutorial

1. See if you want to change any of the defaults in `config.mk`.

2. To use `make it_stop` write your websites pages' in `PAGES_DIR`
   (which is `pages/` by default; see `config.mk`). **To include a link
   to a page in the top menu bar add a comment formatted as
   `<!-- X MENU_ENTRY=LINK TEXT HERE -->` somewhere in the page, where
   is the entry's position in the menu, if X is missing all entries are
   sorted by `LINK TEXT`.**

3. Write whatever `HTML` and `CSS` code you may need in `TEMPLATES_DIR`
   (which is `templates/` by default, see `config.mk`)
	- `HTML` to appear **BEFORE** each pages' menu goes in
	  `TEMPLATES_DIR/header.html`.
	- `HTML` to appear **AFTER** each pages' menu but **BEFORE** the
	  main text in `TEMPLATES_DIR/after_menu.html`.
	- `HTML` to after the main text goes in `TEMPLATES_DIR/footer.html`.
	- Style your webpage by writing your styles in `TEMPLATES_DIR/styles.css`.

4. Run `make it_stop` to build your website (just running `make` works
   as well but where's the fun in that...).

5. If you wish to host it as a GitLab Pages go to your GitLab repo and
   ensure you have the GitLab Pages feature enabled.

6. In case you want your website to be publicly accessible set your
   project's visibility to public. **WARNING: this will make all the
   files you committed to your `git` repo available online through the
   GitLab repo.** *Note: you can work on pages and files you don't want
   to make public by putting them in `wip/`, which is `.gitignore`d by
   default, just take caution not to `git add -f` those files.*


## Example Website

You can see an example of how a website made with `make it_stop` can be
made to look by checking out the GitLab Pages' page `make it_stop` made
from the files on this repo by going to:
[https://joao-o-santos.gitlab.io/make-it-stop](https://joao-o-santos.gitlab.io/make-it-stop)


## GitLab Pages

If you wish to host your static websites using the GitLab Pages service
you can do so by using the simple `.gitlab-ci.yml` included in this
repo.

```
image: alpine

pages:
    stage: deploy
    script:
        - apk update
        - apk add make markdown
        - make
    artifacts:
        paths:
            - public
```
