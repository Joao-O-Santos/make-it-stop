# Make it Stop

Have you ever looked at the complexity of modern websites and though
someone should make it stop? When you come across a needlessly
complicated "web app" do you wish you could make it stop and become
a static website? Have you turned to static website generators only to
find them reliant on too many dependencies and a scripting language you
don't have you installed on you minimalist machine? Then `make-it-stop`
could be for you!

**Disclaimer: the former is meant to be as a tongue-in-cheek play on
words I don't wish to aggravate hardworking web developer or
developers of static website generators (they are all better than this
one).**


## Description

> How many websites could `(GNU) Make` make if `(GNU) Make` knew how to
> make websites?

Make it stop is my sorry attempt at making `(GNU) Make` make static
websites from simple markdown files, coupled with raw `html` and `css`.

*Note: The GNU/knew pun is taken from this [epic rap battle from
history](https://www.youtube.com/watch?v=njos57IJf-0).


## Tutorial

1. To use `make-it-stop` write your pages' text in pure markdown and save
   them in `pages/`.

2. Write whatever pure `HTML` code you need to appear before each pages'
   text in `templates/header.html` and the `HTML` code to appear below
   the text in `templates/footer.html`. Style your webpage by tweaking
   the `templates/styles.css` file. 

3. Run `make` to build your website.

4. If you wish to host it as a GitLab Pages go to your GitLab repo and
   ensure you have the GitLab Pages feature enabled.

5. In case you want your website to be publicly accessible set your
   project's visibility to public. **WARNING: this will make all the
   files you committed to your `git` repo available online through the
   GitLab repo.** *Note: you can work on pages and files you don't want
   to make public by putting them in `wip/`, which is `.gitignore`d by
   default, just take caution not to `git add -f` those files.*


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
